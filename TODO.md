# TODO — cSEM Tutorial Paper

_Last updated: 2026-08-04 (session with Claude)_

## Open

1. **[3.2] `assess()` warning message (HTMT)** — "Intra-block and inter-block correlations … all-positive or all-negative". Jason has a fix in another repo → **open a pull request to FloSchuberth/cSEM and get it merged** (reminder for Jason!). Until merged, the knitted PDF shows the warning.
3. **Generate Table `tab:structural` from R instead of hard-coding** — for when the structural-model section is rebuilt (item 4; the old hand-typed table was removed in the restructure). Hidden chunk (`echo=FALSE, results='asis'`) that builds the LaTeX via `cat()`/`sprintf()` from `summarize(res_csem_boot)` (Estimate, SD, t, p, 95% percentile CI per path) plus `quality$VIF` / `quality$F2` for the diagnostics columns, incl. a *Note* line. Verify against Cheah et al.'s published tables (ground truth). Same pattern later for `tab:htmt` and `tab:fit`. (Claude drafted a chunk pattern for this on 2026-08-04.)
4. **[after 3.2] Overhaul everything after the main chapter** — discuss further structure and topics (Jason + Florian + Claude) so the paper has enough content for a tutorial: what goes into structural model assessment, customization, comparison with alternative estimators (lavaan/CB-SEM, GSCA, sum scores?), further cSEM functionality (predict(), testMICOM(), MGA, second-order constructs?), discussion. → See Jason's structure proposal in item 7.
5. **Mention the open-source advantages of cSEM vs. closed-source software somewhere** — currently only touched in the Introduction; needs a proper place (e.g., expanded in Introduction or picked up again in the Discussion).
6. **Point out that cSEM reports warnings, Cheah/SmartPLS did not** — Cheah et al. report no warnings or similar diagnostics; cSEM surfaces them (e.g., the HTMT warning). Mention this as a difference/advantage in the paper.
7. **General paper structure (updated 2026-07-31, assessment now one chapter in Benitez order):**
   1. Introduction
   2. cSEM R Illustration — 2.1 Getting started, 2.2 Model and Data, 2.3 Model specification, 2.4 Estimating the model with cSEM
   3. Assessment methods in cSEM — one chapter, subsections in Benitez order: validation of the estimation (`verify()`) → testing the adequacy of the model (`testOMF()`: SRMR, d_ULS, d_G) → reliability of the construct scores (ρ_A) → indicator reliability (loadings + significance, bootstrap introduced here) → convergent validity (AVE) → discriminant validity (HTMT) → multicollinearity among indicators → weights (value + significance)
   4. Comparing PLS with alternative estimators
   5. Customization of PLS-PM
   (Later sections — further functionality, discussion — still to be decided with Florian. Sections 1–3 are implemented in the .Rnw; 4 and 5 still to be rebuilt.)
8. **Restructure follow-ups:**
   - ~~Move `verify()`~~ → resolved: `verify()` now opens the assessment chapter as "validation of the estimation".
   - Roadmap paragraph: now a commented-out blueprint in the Introduction (placeholder labels `sec:assessment` ✓ exists, `sec:comparison`, `sec:customization`, `sec:further`, `sec:discussion` still missing) — uncomment, adapt wording, and make sure the labels exist once the final structure is in place.

9. **[Sec. "Assessment methods in cSEM"] Write the text blocks for the assessment chapter** — skeleton with chunks and `% TODO (Jason)` markers is in place; write the prose for each step, incl. the part explaining `assess()` (criteria are extracted from `quality` one at a time instead of printing the full output). _Progress 2026-08-04: chapter lead-in, verify(), testOMF, and construct-score reliability are written; still to write: testOMF decision rule (95% quantile), indicator reliability, AVE, HTMT, weights._ Open decisions inside the skeleton: multicollinearity step (Mode B VIF not applicable to the all-reflective retention model — show pattern only, or switch one construct to a composite? element name `quality$VIF_modeB` unverified, chunk is `eval=FALSE`) and whether loadings significance is repeated in the weights step per Benitez's composite checklist.
10. **Look into the `testOMF()` error** — the `test-omf` chunk throws an error at knit time. Fix PR opened to FloSchuberth/cSEM (2026-08-04) → wait for merge, then restore `.seed = 42` (currently commented out) and re-knit to confirm. Chunk is currently R=1000. Until the merge, the `set.seed(42)` workaround before the call stands.

_Items 11–14: from Claude's review of the assessment section (2026-08-04)._

11. **[Sec. assessment] Fix knit-breakers** (mechanical, Claude can do):
    - `\citet{Beran}` (~line 397): no bib entry — add Beran & Srivastava (1985, Annals of Statistics) to tutorial.bib.
    - `\citet{DijkstraandHenseler2015}` (~line 398): key doesn't exist — the right entry is already in the bib as `Dijkstra2015` (CSDA paper).
    - `\ref{sec:Customization}` (~line 382): dangling, section doesn't exist yet; also settle capitalization (roadmap plans lowercase `sec:customization`).
    - Math-mode underscores ~line 359: `$SRMR, d\_{uls}$ and $d\_{G}$` → `$SRMR$, $d_{ULS}$, and $d_G$` (`\_` prints a literal underscore, no subscript; notation should match line ~418).
12. **[Sec. assessment] Deduplicate the reliability chunks** — `assess-rho-A` and `assess-cronbach-alpha` both print `quality$Reliability`, which contains all three estimates (alpha, rho_C, rho_A) → identical table appears twice. Switch to element-level extraction (sub-element names to verify at knit). Also decide: keep all four rho_C variants (`quality$RhoC`, `_mm`, `_weighted`, `_weighted_mm` — names unverified, same status as `VIF_modeB`) or trim, since Benitez keys on rho_A.
13. **[Sec. assessment] HTMT2 + CI-based decision** — lead-in promises HTMT *and* HTMT2, but the `htmt` chunk computes only default HTMT → needs `.type_htmt = "htmt2"`. The CI decision rule (upper bound of the 90%/95% bootstrap CI) can't come from `quality` (computed on `res_csem`, no resamples) → needs an `assess()` on `res_csem_boot`.
14. **[Sec. assessment] Prose polish (Jason)** — duplicate sentences ~379–380 (verify() checks listed twice); typos: "assed" (×2, ~363–364), "boostrap" (~397), "indictator" (~417), "covarariance" (~379), "Additionnaly" (~436); "succeed the recommend threshold" → "exceed the recommended" (~435); "testOMF() test" → "tests" (~417); "AVE … are" subject–verb (~488); SRMR = *standardized* RMR (~418). Remove superseded TODO markers (lead-in ~367–370, verify ~383–386, reliability ~451–454 after item 12).

## Backlog (from earlier session, still open)

- ~~`infer()` output too large~~ — largely resolved: the `infer(res_csem_boot)` call is gone from the .Rnw; the assessment skeleton now extracts only `summarize(res_csem_boot)$Estimates$Loading_estimates` / `$Weight_estimates`. Remaining aspect (percentile CIs) is covered by item 3 (tables built from R).
- Fill the two remaining empty `\citep{}`: Introduction (open-science/accessibility claim, ~line 168) and "Model specification" (single-indicator constructs, ~line 291). (The ones in "Customizing the PLS algorithm" and the second Model-spec one are gone — section removed / resolved.)
- ~~`\ref{tab:measurement}` dangling~~ — obsolete, reference no longer in the .Rnw.
- ~~"Further cSEM functionality" empty heading~~ — obsolete, heading removed; topic covered by items 4/7.
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
