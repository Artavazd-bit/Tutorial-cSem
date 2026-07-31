# TODO — cSEM Tutorial Paper

_Last updated: 2026-07-31 (session with Claude)_

## Open

1. **[3.2] `assess()` warning message (HTMT)** — "Intra-block and inter-block correlations … all-positive or all-negative". Jason has a fix in another repo → **open a pull request to FloSchuberth/cSEM and get it merged** (reminder for Jason!). Until merged, the knitted PDF shows the warning.
2. **[3.2] `infer()` output too large** — the `infer(res_csem_boot)` call prints pages of output into the PDF. Find a solution (extract only the relevant CIs, or suppress and reference a table).
3. **[3.2] Generate Table `tab:structural` from R instead of hard-coding** — replace the hand-typed structural model table (currently ~line 483) with a hidden chunk (`echo=FALSE, results='asis'`) that builds the LaTeX via `cat()`/`sprintf()` from `summarize(res_csem_boot)` (Estimate, SD, t, p, 95% percentile CI per path) plus `quality$VIF` / `quality$F2` for the diagnostics columns. Keep the exact current layout incl. the *Note* line; verify first knit against the current hard-coded numbers (ground truth, replicate Cheah). Same pattern later for `tab:htmt` and `tab:fit`.
4. **[after 3.2] Overhaul everything after the main chapter** — discuss further structure and topics (Jason + Florian + Claude) so the paper has enough content for a tutorial: what goes into structural model assessment, customization, comparison with alternative estimators (lavaan/CB-SEM, GSCA, sum scores?), further cSEM functionality (predict(), testMICOM(), MGA, second-order constructs?), discussion. → See Jason's structure proposal in item 7.
5. **Mention the open-source advantages of cSEM vs. closed-source software somewhere** — currently only touched in the Introduction; needs a proper place (e.g., expanded in Introduction or picked up again in the Discussion).
6. **Point out that cSEM reports warnings, Cheah/SmartPLS did not** — Cheah et al. report no warnings or similar diagnostics; cSEM surfaces them (e.g., the HTMT warning). Mention this as a difference/advantage in the paper.
7. **Jason's proposal for the general paper structure (2026-07-31):**
   1. Introduction
   2. cSEM R Illustration — 2.1 Getting started, 2.2 Model and Data, 2.3 Model specification, 2.4 Estimating the model with cSEM
   3. Assessment methods in cSEM — 3.1 Assessing the measurement model, 3.2 Assessing the structural model
   4. Comparing PLS with alternative estimators
   5. Customization of PLS-PM
   (Jason's note listed the last point as "8."; later sections — further functionality, discussion — still to be decided with Florian.)
8. **Restructure follow-ups once the new structure (item 7) is implemented:**
   - Move `verify()` + explanation again: it currently opens "Customizing the PLS algorithm" as motivation; with customization moving to the end (new Section 5), decide where `verify()` belongs (e.g., after estimation in 2.4) and adapt the transition text.
   - Roadmap paragraph: now a commented-out blueprint in the Introduction (follows the item-7 structure with placeholder labels `sec:assessment`, `sec:comparison`, `sec:customization`, `sec:further`, `sec:discussion`) — uncomment, adapt wording, and make sure the labels exist once the final structure is in place.

9. **[3.1 Assessing the measurement model] Write the text block explaining the `assess()` output** — figure out how to walk the reader through what `assess()` prints (which quality criteria appear, in what order, what to look at) and write the accompanying explanation text.

## Backlog (from earlier session, still open)

- Fill empty `\citep{}` in the Introduction (open-science/accessibility claim) and in "Customizing the PLS algorithm" (defaults recommendation).
- Two more empty `\citep{}` in "Model specification" (reflective vs. composite explanation; single-indicator constructs).
- Build Table 1 (measurement model results) — `\ref{tab:measurement}` is currently a dangling reference.
- "Further cSEM functionality" section is an empty heading.
- Decide: proper `renv::restore()` on Linux vs. current user-library workaround (renv `.Rprofile` is bypassed with `--no-init-file` for now).

## Done

- ✅ Replaced `summary(HBAT_SEM_rel)` with `colSums(is.na(HBAT_SEM_rel))`; text now motivates the check (cSEM requires complete datasets without missings).
- ✅ Moved `verify(res_csem)` + explanation out of 3.1; now opens "Customizing the PLS algorithm" as motivation for the customization options.
- ✅ Added paragraph in 3.1 explaining the `NA` std. errors / t-values / p-values (point estimates only; bootstrap introduced in Section "Assessing the measurement model").
- ✅ Flattened structure: removed all five `\subsubsection` headings (HTMT + the four under "Assessing the structural model").
- ✅ Added sentence after complete-cases step: remainder of tutorial uses N = 398 complete observations (no Cheah citation, per Jason).
- ✅ Introduction: removed orphan `\citet{Barba2022}` / `\citep{Chuah2021}` lines; wrote the roadmap paragraph with `\ref`s; added `\label{sec:…}` to all sections.
- ✅ Object-name consistency across all chunks (`res_csem`, `res_csem_boot`, `HBAT_SEM_rel`).
- ✅ Appendix script: correct CSV path, complete-cases step, correct `assess()` element names (`q$Reliability`).
- ✅ Escaped underscore in `\code{res\_csem}` (was breaking pdflatex).
- ✅ Added missing bib entries `Hair2026primer`, `UNESCO`.
- ✅ Full pipeline verified: knit → pdflatex/bibtex → 46-page PDF, zero LaTeX errors.
- ✅ Replication check against Cheah et al. (2026) Tables 1–4: matches within ±0.005.
