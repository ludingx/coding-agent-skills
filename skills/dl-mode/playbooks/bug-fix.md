# Bug fix

Own the diagnosis and the proof, not just the code change. Do not invoke `implement` or `tdd` as a prerequisite.

1. **Reproduce the failure.** Find the affected user path and the project's instructions for running it. Drive the failing behavior locally on the same surface the user uses, and record the input, expected result, and actual result. If it does not reproduce, investigate the conditions or instrument the path; do not claim to have fixed an unobserved failure.
2. **Trace the cause.** Follow the failing path through the relevant code and runtime evidence. Test hypotheses against observations rather than guessing. Distinguish the mechanism causing the failure from the symptom; do not add a guard or workaround merely because it might help. Nearby legacy code is evidence, not an instruction to copy its pattern.
3. **Make the smallest justified fix.** Change only what the confirmed cause requires. Add a focused regression test at an observable boundary when it can capture the failure; test-first is useful when practical, not mandatory. Keep unrelated cleanup and broad refactoring out of the bug fix.
4. **Recheck the original path.** Rerun the same input on the same surface and record the result. Run relevant targeted tests and check important nearby behavior for regressions. A passing unit test or a different test surface does not by itself prove that the original bug is gone. If the path remains inaccessible, report it as **not verified**, not fixed.
5. **Review the diff.** Compare with the base branch. Remove speculative changes and incidental code movement. Make it easy for a reviewer to connect each changed line to the cause and the before/after evidence.

Hand back a short briefing: failure before; root cause and fix; result of the same reproduction after; regression checks; anything not verified. Include concrete commands, observations, or evidence pointers, not a debugging diary.
