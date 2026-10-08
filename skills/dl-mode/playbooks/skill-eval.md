# Skill eval

**You own the comparison, not the candidate's answer.** Use this route to test whether a skill, structure, or prompt variant changes agent behavior. For edits alone, use **Authoring or modifying a skill**.

1. Define the behavior being tested and an observable success criterion. Write a short rubric before running candidates; keep it out of their view. Decide which variant is the baseline and which is the treatment.
2. Prepare isolated, otherwise equivalent environments for both variants. Give each candidate only the version of the skill it should see. Use an organic task prompt that states the goal, not that this is an eval, a comparison, or a test of skill use. Keep rubric, variant labels, and other candidate outputs hidden. Avoid naming scratch paths or artifacts in ways that reveal the treatment.
3. Run candidates under the same task and relevant settings, with separate writable locations. If multiple runs or models are needed to support a claim, use them on both sides. Do not let candidates or the judge see each other's identities or responses.
4. Inspect the actual artifacts and execution trails, not candidate claims about what they read or followed. Give a judge the rubric and anonymized outputs from both variants on one scale. Independently read the outputs and reconcile disagreements with the judge. Check that both sides did the task and that the prompt or environment did not reveal the expected result.
5. Report the rubric, run count, observed difference, failures and limitations. Apply **principle-explain-the-number** before treating a score or timing gap as evidence. If the trial was unblinded, incomplete, or too noisy to distinguish variants, call it inconclusive. Recommend promotion only when the evidence supports it; route any approved skill edit through **Authoring or modifying a skill**.

Hand back: the variant tested, rubric, anonymized evidence, verdict, and recommendation. Do not promote a skill merely because one agent said it followed it.
