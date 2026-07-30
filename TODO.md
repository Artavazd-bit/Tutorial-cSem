# TODO — cSEM Tutorial Paper

_Last updated: 2026-07-30 (session with Claude)_

## Open

1. **[2.2 Model and Data] Summary statistics too long** — `summary(HBAT_SEM_rel)` prints a huge block into the PDF. Find a different solution (e.g., compact descriptive-statistics table generated from the data, or show only selected variables and reference a proper LaTeX table).
2. **[3.1 Running the estimation] Move `verify(res_csem)`** — relocate the line and its explanation to the later section that discusses the other input arguments of `csem()` (Section "Customizing the PLS algorithm").
3. **[3.1] Explain the `NA` std. errors** — the `summarize()` output shows `NA` for standard errors / t-values / p-values because the plain `csem()` call computes point estimates only; inference requires resampling (bootstrap). Add an explanation in the text.
4. **[3.2] `assess()` warning message (HTMT)** — "Intra-block and inter-block correlations … all-positive or all-negative". Jason has a fix in another repo → **open a pull request to FloSchuberth/cSEM and get it merged** (reminder for Jason!). Until merged, the knitted PDF shows the warning.
5. **[3.2.1] Flatten structure** — no subsubsections wanted; only sections and subsections. Fold "Discriminant Validity: The HTMT Criterion" (3.2.1) into 3.2, same for the subsubsections under "Assessing the structural model".
6. **[3.2] `infer()` output too large** — the `infer(res_csem_boot)` call prints pages of output into the PDF. Find a solution (extract only the relevant CIs, or suppress and reference a table).
7. **[after 3.2] Overhaul everything after the main chapter** — discuss further structure and topics (Jason + Florian + Claude) so the paper has enough content for a tutorial: what goes into structural model assessment, customization, comparison with alternative estimators (lavaan/CB-SEM, GSCA, sum scores?), further cSEM functionality (predict(), testMICOM(), MGA, second-order constructs?), discussion.

## Backlog (from earlier session, still open)

- Finish the Introduction: fill empty `\citep{}` (open-science/accessibility claim), remove orphan `\citet{Barba2022}` / `\citep{Chuah2021}` lines, write the "The remainder of this tutorial…" roadmap paragraph.
- Two more empty `\citep{}` in "Model specification" (reflective vs. composite explanation; single-indicator constructs).
- Build Table 1 (measurement model results) — `\ref{tab:measurement}` is currently a dangling reference.
- Footnote on missing-data handling: our N=398 complete cases vs. Cheah's N=400 explains the ±0.005 differences to their published values.
- "Further cSEM functionality" section is an empty heading.
- Decide: proper `renv::restore()` on Linux vs. current user-library workaround (renv `.Rprofile` is bypassed with `--no-init-file` for now).

## Done

- ✅ Object-name consistency across all chunks (`res_csem`, `res_csem_boot`, `HBAT_SEM_rel`).
- ✅ Appendix script: correct CSV path, complete-cases step, correct `assess()` element names (`q$Reliability`).
- ✅ Escaped underscore in `\code{res\_csem}` (was breaking pdflatex).
- ✅ Added missing bib entries `Hair2026primer`, `UNESCO`.
- ✅ Full pipeline verified: knit → pdflatex/bibtex → 46-page PDF, zero LaTeX errors.
- ✅ Replication check against Cheah et al. (2026) Tables 1–4: matches within ±0.005.
