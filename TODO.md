# TODO — cSEM Tutorial Paper

_Last updated: 2026-08-18 (session with Claude). Note: `tutorial.Rnw` was edited 2026-08-10 (testOMF explanation, AVE sentence, HTMT lead-in written; `htmt-inference` chunk added — currently the crashing full-criteria call, see items 15/16)._

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

9. **[Sec. "Assessment methods in cSEM"] Write the text blocks for the assessment chapter** — skeleton with chunks and `% TODO (Jason)` markers is in place; write the prose for each step, incl. the part explaining `assess()` (criteria are extracted from `quality` one at a time instead of printing the full output). _Progress 2026-08-04: chapter lead-in, verify(), testOMF, construct-score reliability, and discriminant validity (HTMT thresholds + CI decision rule) are written; still to write: testOMF decision rule (95% quantile), indicator reliability, AVE, weights._ Open decisions inside the skeleton: multicollinearity step (Mode B VIF not applicable to the all-reflective retention model — show pattern only, or switch one construct to a composite? element name `quality$VIF_modeB` unverified, chunk is `eval=FALSE`) and whether loadings significance is repeated in the weights step per Benitez's composite checklist.
10. **Look into the `testOMF()` error** — the `test-omf` chunk throws an error at knit time. Fix PR opened to FloSchuberth/cSEM (2026-08-04) → wait for merge, then restore `.seed = 42` (currently commented out) and re-knit to confirm. Chunk is currently R=1000. Until the merge, the `set.seed(42)` workaround before the call stands.

_Items 11–14: from Claude's review of the assessment section (2026-08-04)._

11. **[Sec. assessment] Fix knit-breakers** → folded into item 16 (plan verified 2026-08-18):
    - `\citet{Beran}` (~line 397): no bib entry — add Beran & Srivastava (1985, Annals of Statistics) to tutorial.bib.
    - `\citet{DijkstraandHenseler2015}` (~line 398): key doesn't exist — the right entry is already in the bib as `Dijkstra2015` (CSDA paper).
    - `\ref{sec:Customization}` (~line 382): dangling, section doesn't exist yet; also settle capitalization (roadmap plans lowercase `sec:customization`).
    - Math-mode underscores ~line 359: `$SRMR, d\_{uls}$ and $d\_{G}$` → `$SRMR$, $d_{ULS}$, and $d_G$` (`\_` prints a literal underscore, no subscript; notation should match line ~418).
12. **[Sec. assessment] Deduplicate the reliability chunks** → dedup itself folded into item 16 (sub-element names verified 2026-08-18 in a live R session: `quality$Reliability` = `Cronbachs_alpha`, `Joereskogs_rho`, `Dijkstra-Henselers_rho_A`). Still to decide: keep all four rho_C variants (`quality$RhoC`, `_mm`, `_weighted`, `_weighted_mm` — all four names verified valid) or trim, since Benitez keys on rho_A. _Verified 2026-08-18: `names(quality)` contains **no** `VIF_modeB` element at all — only `VIF` (structural). The vif-indicators chunk element name is definitely wrong; feed this into the multicollinearity decision (item 9)._
13. **[Sec. assessment] HTMT2 + CI-based decision** — lead-in promises HTMT *and* HTMT2, but the `htmt` chunk computes only default HTMT → needs `.type_htmt = "htmt2"`. The CI decision rule (upper bound of the 90%/95% bootstrap CI) can't come from `quality` (computed on `res_csem`, no resamples) → needs an `assess()` on `res_csem_boot`.
14. **[Sec. assessment] Prose polish (Jason)** — duplicate sentences ~379–380 (verify() checks listed twice); typos: "assed" (×2, ~363–364), "boostrap" (~397), "indictator" (~417), "covarariance" (~379), "Additionnaly" (~436); "succeed the recommend threshold" → "exceed the recommended" (~435); "testOMF() test" → "tests" (~417); "AVE … are" subject–verb (~488); SRMR = *standardized* RMR (~418). Remove superseded TODO markers (lead-in ~367–370, verify ~383–386, reliability ~451–454 after item 12).

15. **[Sec. assessment] `assess(.inference = TRUE)` crashes — cSEM 0.6.1 bug via HTMT2 (diagnosed 2026-08-04)** — the chunk `assess-with-inference` (`quality_inf <- assess(res_csem, .inference = TRUE)`) can never finish on this dataset: with all quality criteria enabled, `assess()` also runs **HTMT2**, whose point estimate for the JS–AC pair is `NaN` (mixed-sign intra/inter-block correlations — same root cause as the known HTMT warning, item 1). `calculateHTMT()` then evaluates `if (c(out)[x] < 0)` on that `NaN` → `Error: missing value where TRUE/FALSE needed`. Even with the guard fixed, HTMT2 inference would rest on ~5 of 499 admissible bootstrap draws.
    - **Tutorial fix (verified, works):** `quality_inf <- assess(res_csem, .quality_criterion = "htmt", .inference = TRUE, .seed = 42)` → 499 admissible draws; returned `$htmts` matrix has HTMT point estimates in the lower triangle and the 90% upper CI bounds in the upper triangle. Add `.seed` in any case (default is `NULL` → CI bounds change every knit). Consider `.absolute = FALSE` (cSEM warns it's recommended for resampling).
    - **Consequence for the lead-in:** HTMT2 is promised there (item 13) but is not computable for this dataset (NaN for JS–AC) — decide with Florian: drop HTMT2, or discuss the NaN as another example of cSEM surfacing problems SmartPLS hides (ties into items 1/6).
    - _Update 2026-08-18: Jason is now working on the HTMT2 fix in the cSEM repo himself. The tutorial-side chunk fix is part of item 16._
    - **Upstream (plan: Jason opens the GitHub issue on 2026-08-05, then we fix it):** two defects to report — (a) missing NaN-guard in `calculateHTMT()`'s inference branch; (b) `assess()` has no error handling at all (verified: zero `tryCatch` in its source), so one failing criterion kills the whole call with a cryptic message while all successfully computed criteria are lost. Draft issue text below.

      ```markdown
      **Title:** assess(.inference = TRUE) crashes with uninformative error when an HTMT2 value is NaN

      **cSEM version:** 0.6.1 (CRAN) · R on Linux

      **Repro** (Employee Retention data from the SmartPLS sample projects,
      https://www.smartpls.com/documentation/sample-projects/employee-retention;
      21 indicators, complete cases, N = 398):

          res <- csem(.data = HBAT_SEM_rel, .model = model)  # standard PLSc estimation
          assess(res, .inference = TRUE)
          #> Error in if (c(out)[x] < 0) { : missing value where TRUE/FALSE needed
          #> Calls: assess -> calculateHTMT -> sapply -> lapply -> FUN

      **Cause:** With the default criteria, assess() also computes HTMT2. In this dataset the
      JS–AC block has mixed-sign intra-/inter-block correlations, so the HTMT2 point estimate
      is NaN (geometric mean of a negative product). In calculateHTMT()'s inference branch,
      `quants_for_print <- sapply(1:dim(quants)[2], function(x) if (c(out)[x] < 0) ...)`
      evaluates the condition on that NaN → error. Any dataset with an NaN HTMT2 value
      triggers it; `calculateHTMT(res, .type_htmt = "htmt2", .inference = TRUE)` reproduces
      it directly. Likely related to the "Intra-block and inter-block correlations …
      all-positive or all-negative" warning (same underlying data pattern).

      **Two suggestions:**
      1. Guard the condition (e.g. `!is.na(c(out)[x]) && c(out)[x] < 0`) and propagate NA for
         the affected cell. Note the affected draws are already dropped by the na.omit() above,
         so inference for such cells rests on very few admissible resamples (5 of 499 here) —
         maybe worth a warning of its own.
      2. Consider making assess() robust to a single failing criterion (skip + warn instead of
         aborting), and/or a clearer error message. Currently one NaN in HTMT2 makes the whole
         assess(.inference = TRUE) output unavailable, including all criteria that computed fine.

      **Workaround for users:** `assess(res, .quality_criterion = "htmt", .inference = TRUE, .seed = ...)`.
      ```

16. **Mechanical fix batch — plan verified 2026-08-18 (Claude), ready to apply on go-ahead.** Consolidates items 11, 12 (dedup part), 14 (typos), and the tutorial-side fix from 15. All element names verified in a live R session (`assess()` on the actual data, cSEM as installed). Line numbers refer to the .Rnw as of 2026-08-10. Edits:
    - **tutorial.bib:** add entry `Beran1985` — Beran, R., & Srivastava, M. S. (1985). Bootstrap tests and confidence regions for functions of a covariance matrix. _The Annals of Statistics, 13_(1), 95–115. doi:10.1214/aos/1176346579.
    - **Cite keys:** `\citet{Beran}` (~399) → `\citet{Beran1985}`; `\citet{DijkstraandHenseler2015}` (~400) → `\citet{Dijkstra2015}`.
    - **Dangling ref (~383):** `\ref{sec:Customization}` → lowercase `\ref{sec:customization}` + TODO comment (prints "??" until the customization section is rebuilt; alternative: comment the sentence out — Jason to pick).
    - **Math underscores (~359):** `$SRMR, d\_{uls}$ and $d\_{G}$` → `$SRMR$, $d_{ULS}$, and $d_G$`.
    - **`htmt-inference` chunk (~512):** currently `assess(.object = res_csem, .inference = TRUE, .absolute = FALSE)` — this is the crashing full-criteria call from item 15. Replace with the verified call:
      ```r
      quality_inf <- assess(.object = res_csem,
                            .quality_criterion = "htmt",
                            .inference = TRUE,
                            .seed = 42,
                            .absolute = FALSE)
      quality_inf$HTMT$htmts
      ```
      Verified: runs clean, 499 admissible draws; `$htmts` is the 5×5 matrix (lower triangle = HTMT point estimates, upper triangle = 90% upper CI bounds). Note the element path: `quality_inf$HTMT$htmts`, not `quality_inf$htmts`.
    - **Reliability dedup:** `assess-rho-A` chunk → `` quality$Reliability$`Dijkstra-Henselers_rho_A` `` (backticks required — hyphen in the name); `assess-cronbach-alpha` chunk → `quality$Reliability$Cronbachs_alpha`. `assess-rho_C` chunk untouched (trim decision stays in item 12).
    - **Typos:** "assed" → "assessed" (~364, ~365); "checks of" → "checks whether" + "covarariance" → "covariance" (~380); **delete ~381 entirely** (near-verbatim repeat of ~380); "boostrap" → "bootstrap" (~399); "test the null" → "tests the null" + "indictator" → "indicator" (~419); "root mean square residual" → "standardized root mean square residual" (~420); "succeed the recommend threshold" → "exceed the recommended threshold" (~438); "Additionnaly" → "Additionally" (~439).
    - **Optional (Jason to confirm):** remove superseded `% TODO (Jason)` markers at ~368–371 (lead-in), ~384–387 (verify), ~454–457 (reliability — superseded once the dedup is applied).
    - _Bonus finding for item 13: default `assess()` output does contain `quality$HTMT2` (point estimates, with the NaN for JS–AC) — only the inference branch crashes._

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
