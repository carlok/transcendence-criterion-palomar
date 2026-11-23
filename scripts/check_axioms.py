#!/usr/bin/env python3
"""Axiom audit for the compared theorem and the library theorem behind it.

Writes a throwaway Lean file outside the repository (every committed `.lean`
file must use the module system, and this probe does not need to), runs it with
`lake env lean`, and fails unless

  * Lean exits cleanly (so every listed name exists),
  * every `#print axioms` line produced exactly one report, and
  * no theorem depends on anything beyond propext, Classical.choice and
    Quot.sound (so no sorryAx, no Lean.ofReduceBool, no custom axiom).

Run it from the Lean project root after `lake build`.
"""
import os
import re
import subprocess
import sys
import tempfile

ALLOWED = {"propext", "Classical.choice", "Quot.sound"}
IMPORTS = ["Solution"]
NAMES = [
    "TranscendenceCriterion.transcendence_criterion",
    "Diaz.transcendence_criterion",
]

source = "".join(f"import {module}\n" for module in IMPORTS) + "".join(
    f"#print axioms {name}\n" for name in NAMES
)
handle, probe = tempfile.mkstemp(suffix=".lean", prefix="axiom_audit_")
try:
    with os.fdopen(handle, "w", encoding="utf-8") as stream:
        stream.write(source)
    proc = subprocess.run(["lake", "env", "lean", probe], capture_output=True, text=True)
finally:
    os.unlink(probe)

output = proc.stdout + proc.stderr
print(output, end="")
if proc.returncode != 0:
    sys.exit(f"axiom audit: lean exited with status {proc.returncode}")

reports = {}
for match in re.finditer(
    r"'([^']+)' (?:depends on axioms: \[([^\]]*)\]|does not depend on any axioms)",
    output,
):
    name, axioms = match.group(1), match.group(2) or ""
    reports[name] = {a.strip() for a in axioms.replace("\n", " ").split(",") if a.strip()}

failures = []
for name in NAMES:
    if name not in reports:
        failures.append(f"{name}: no axiom report")
    elif reports[name] - ALLOWED:
        failures.append(f"{name}: non-standard axioms {sorted(reports[name] - ALLOWED)}")

for failure in failures:
    print(f"::error::{failure}")
if failures:
    sys.exit(1)
print(f"axiom audit: {len(NAMES)} theorems, standard axioms only")
