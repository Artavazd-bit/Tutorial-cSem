# TODO — cSEM Tutorial Paper

_Last updated: 2026-09-01. Upstream work done (Jason): HTMT-warning PR and the assess()-robustness report to FloSchuberth/cSEM (items 1/15 closed). Typos outside the assessment chapter fixed, title date now `\today` (item 17 closed). **Jason is currently writing the assessment-chapter prose (item 9).** cSEM runs from GitHub master; HTMT2 stays NaN for JS–AC (data-driven, decision in item 13)._

## Open

1. ~~[3.2] `assess()` warning message (HTMT)~~ — **✅ PR to FloSchuberth/cSEM done (Jason, 2026-09-01).** Watch-out once the fix lands in the installed build: the `htmt` chunk (`warning = TRUE`) will then show no warning, and the prose "The warning message says that some of the correlations …" becomes stale — rework it together with item 6 (cSEM surfaces warnings, SmartPLS doesn't) at that point.
3. **Generate Table `tab:structural` from R instead of hard-coding** — the structural section now exists as subchapter 3.3 (2026-08-31) with raw-output chunks (`paths-boot`, `effect-sizes`, `r-squared`); the R-generated table would replace/complement those. Hidden chunk (`echo=FALSE, results='asis'`) that builds the LaTeX via `cat()`/`sprintf()` from `summarize(res_csem_boot)` (Estimate, SD, t, p, 95% percentile CI per path) plus `quality$VIF` / `quality$F2` for the diagnostics columns, incl. a *Note* line. Verify against Cheah et al.'s published tables (ground truth). Same pattern later for `tab:htmt` and `tab:fit`. (Claude drafted a chunk pattern for this on 2026-08-04.)
4. **[after 3.2] Overhaul everything after the main chapter** — discuss further structure and topics (Jason + Florian + Claude) so the paper has enough content for a tutorial: what goes into structural model assessment, customization, comparison with alternative estimators (lavaan/CB-SEM, GSCA, sum scores?), further cSEM functionality (predict(), testMICOM(), MGA, second-order constructs?), discussion. → See Jason's structure proposal in item 7.
5. **Mention the open-source advantages of cSEM vs. closed-source software somewhere** — _update 2026-08-31: the Introduction now has a full passage (~lines 160–170: proprietary vs. open-source, open-science principles, transparency/reproducibility citations)._ Remaining: pick it up again in the Discussion once that section exists (item 4); one empty `\citep{}` in the passage (accessibility/inclusiveness claim, see Backlog).
6. **Point out that cSEM reports warnings, Cheah/SmartPLS did not** — Cheah et al. report no warnings or similar diagnostics; cSEM surfaces them (e.g., the HTMT warning). Mention this as a difference/advantage in the paper.
7. **General paper structure (updated 2026-07-31, assessment now one chapter in Benitez order):**
   1. Introduction und 
   2. cSEM R Illustration — 2.1 Getting started, 2.2 Model and Data, 2.3 Model specification, 2.4 Estimating the model with cSEM
   3. Assessment Methods — restructured 2026-08-31 into three numbered subchapters (chapter renamed from "Assessment methods in cSEM"):
      - Validation of the estimation (`verify()`) now opens subchapter 3.1 (moved there by Jason 2026-08-31; chapter lead-in rewritten as a three-step overview)
      - 3.1 Overall model fit (`testOMF()`: SRMR, d_ULS, d_G)
      - 3.2 Assessment of the reflective measurement models (renamed by Jason 2026-08-31, "and composite models" dropped) — the previous steps as unnumbered `\subsubsection*`: reliability of construct scores (ρ_A) → indicator reliability (loadings + significance, bootstrap introduced here) → convergent validity (AVE) → discriminant validity (HTMT) → multicollinearity among indicators + weights
      - 3.3 Structural model evaluation — new skeleton (chunks `paths-boot`, `effect-sizes`, `r-squared`; element names `Path_estimates`, `quality$F2`, `quality$R2`, `quality$R2_adj` verified live 2026-08-31) with `% TODO (Jason)` text markers
   4. Comparing PLS with alternative estimators
   5. Further features of cSEM (some ideas) 
	5.1 Customization of PLS-PM
	5.2 predictive model assessment
	5.3 non linear
	5.4 IMAP mediation 
	5.5 multi group
   (Later sections — further functionality, discussion — still to be decided with Florian. Sections 1–3 are implemented in the .Rnw; 4 and 5 still to be rebuilt.)
8. **Restructure follow-ups:**
   - ~~Move `verify()`~~ → resolved: `verify()` now opens the assessment chapter as "validation of the estimation".
   - Roadmap paragraph: still a commented-out blueprint in the Introduction (~lines 214–227). Label status after the 2026-08-31 batch: every roadmap label exists **except `sec:comparison`** (comparison section still to be built, item 4) — uncomment and adapt wording once it does. (Jason added skeleton sections "Further features of cSEM" (5.1 Customization, 5.2 predictive, 5.3 non linear) and "Concluding remarks"; Claude added `\label{sec:further}`, `\label{sec:customization}`, `\label{sec:discussion}` to them.)
   - ~~Section-level mismatch~~ — resolved by Jason 2026-09-01: estimation is now `\subsection{Model estimation}` (2.4) inside the Illustration chapter, as planned in item 7.

9. **[Sec. "Assessment Methods"] Write the text blocks for the assessment chapter** — skeleton with chunks and `% TODO (Jason)` markers is in place; write the prose for each step, incl. the part explaining `assess()` (criteria are extracted from `quality` one at a time instead of printing the full output). _**Style decision (Jason, 2026-08-31): the chapter describes what cSEM lets you do to assess each aspect — no thresholds, benchmarks, or compare-against-value decision rules.** Claude's TODO markers updated accordingly. Two existing prose spots still use threshold/decision language, Jason to rework or keep deliberately: the AVE conclusion sentence ("above the recommended threshold of 0.5") and the HTMT decision sentence ("if one is bigger than the upper limit … established"). Still to write: indicator reliability, AVE, weights, the three structural blocks (paths, f², R²). Chapter lead-in reworked by Jason 2026-08-31 (three-step overview)._ Open decisions inside the skeleton (additional to below): structural collinearity — the Abstract and Benitez both list collinearity as part of the structural assessment, and `quality$VIF` (structural VIF, verified) exists — decide whether 3.3 gets a VIF chunk. Open decisions inside the skeleton: multicollinearity step (Mode B VIF not applicable to the all-reflective retention model — show pattern only, or switch one construct to a composite? element name `quality$VIF_modeB` unverified, chunk is `eval=FALSE`) and whether loadings significance is repeated in the weights step per Benitez's composite checklist.
_Items 11–14: from Claude's review of the assessment section (2026-08-04). Item 10 (testOMF error) moved to Done 2026-08-31._

11. ~~[Sec. assessment] Fix knit-breakers~~ — **✅ resolved 2026-08-31** via the item-16 batch: `Beran1985` added to the bib, both cite keys fixed, `\ref{sec:customization}` now resolves (label added to Jason's new "Further features" skeleton), math underscores fixed (incl. the new `$d\_G$` in Jason's rewritten testOMF sentence).
12. **[Sec. assessment] Reliability chunks — remaining decision only** (dedup overtaken: Jason deleted the `assess-cronbach-alpha` chunk 2026-08-31; `assess-rho-A` now prints the full `quality$Reliability` table of all three estimates). Still to decide: keep all four rho_C variants (`quality$RhoC`, `_mm`, `_weighted`, `_weighted_mm`) or trim, since Benitez keys on rho_A; optionally have `assess-rho-A` extract only `` quality$Reliability$`Dijkstra-Henselers_rho_A` `` (backticks required). The removed threshold prose (rho_A ≥ 0.707) stays removed — matches the no-thresholds style decision (item 9). _Verified 2026-08-18: `names(quality)` contains **no** `VIF_modeB` element — only `VIF` (structural); feed into the multicollinearity decision (item 9)._
13. **[Sec. assessment] HTMT2 — mostly resolved** — Jason added an `htmt2` chunk 2026-09-01 (`.quality_criterion = "htmt2"`, `.inference = "bootstrap"`, `.absolute = FALSE`, `warning = FALSE`), so HTMT2 is now shown, not just claimed. Remaining: the JS–AC cell is NaN in the output (data-driven, item 15) and the chunk suppresses its warning — decide (with Florian) whether the NaN gets a sentence in the text (ties into items 1/6), and note the chunk has no `.seed`, so the bootstrap CI bounds change on every knit — consider adding `.seed = 42`. _HTMT CI rule handled via `.inference = "asymptotic"` in the `htmt` chunk (confirmed working)._
14. ~~[Sec. assessment] Prose polish~~ — **✅ resolved 2026-08-31**: partly by Jason's chapter rewrite (assed/Additionnaly/succeed-the-recommend/duplicates/old markers gone), rest via the item-16 batch (checks-of/covarariance, duplicate verify sentence deleted, boostrap, tests-the-null, standardized RMR, AVE subject–verb).

15. **[Sec. assessment] `assess(.inference = TRUE)` crashes — cSEM 0.6.1 bug via HTMT2 (diagnosed 2026-08-04)** — the chunk `assess-with-inference` (`quality_inf <- assess(res_csem, .inference = TRUE)`) can never finish on this dataset: with all quality criteria enabled, `assess()` also runs **HTMT2**, whose point estimate for the JS–AC pair is `NaN` (mixed-sign intra/inter-block correlations — same root cause as the known HTMT warning, item 1). `calculateHTMT()` then evaluates `if (c(out)[x] < 0)` on that `NaN` → `Error: missing value where TRUE/FALSE needed`. Even with the guard fixed, HTMT2 inference would rest on ~5 of 499 admissible bootstrap draws.
    - **Tutorial fix (verified, works):** `quality_inf <- assess(res_csem, .quality_criterion = "htmt", .inference = TRUE, .seed = 42)` → 499 admissible draws; returned `$htmts` matrix has HTMT point estimates in the lower triangle and the 90% upper CI bounds in the upper triangle. Add `.seed` in any case (default is `NULL` → CI bounds change every knit). Consider `.absolute = FALSE` (cSEM warns it's recommended for resampling).
    - **Consequence for the lead-in:** HTMT2 is promised there (item 13) but is not computable for this dataset (NaN for JS–AC) — decide with Florian: drop HTMT2, or discuss the NaN as another example of cSEM surfacing problems SmartPLS hides (ties into items 1/6).
    - _Update 2026-08-18: Jason is now working on the HTMT2 fix in the cSEM repo himself. The tutorial-side chunk fix is part of item 16._
    - _Update 2026-08-31: NaN-guard fix is in master and installed — the crash is gone. But the HTMT2 value for JS–AC stays NaN, as diagnosed: mixed-sign intra-/inter-block correlations make it uncomputable for this dataset. No code fix possible. What remains is the **decision with Florian** (see also item 13): drop HTMT2 from the lead-in, or keep the NaN and discuss it as cSEM surfacing a data problem SmartPLS hides (ties into items 1/6)._
    - _Update 2026-08-31 (later): tutorial side fully settled — Jason's `htmt` chunk now uses `.quality_criterion = "htmt", .inference = "asymptotic", .absolute = FALSE` (GitHub-build feature) and knits fine; the workaround call from item 16 is obsolete._
    - _**Closed 2026-09-01: the upstream `assess()` robustness report is done too (Jason). Item fully resolved — only the item-13 NaN-sentence decision lives on, tracked there.** The draft issue text below is kept for reference only._
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

16. ~~Mechanical fix batch~~ — **✅ applied 2026-08-31** after re-verification against the current .Rnw (about half was overtaken by Jason's same-day edits; the surviving fixes went in, plus new-prose typos). Full list in Done. Closed with it: item 11 entirely, item 14 entirely, the dedup part of 12, and the tutorial-side part of 15.

17. ~~Prose polish outside the assessment section~~ — **✅ applied 2026-09-01 (Claude, on Jason's request):** missing period after Hwang citation; missing space after `{Wold1982c},`; "accessible of transparency" → "accessible, which impedes transparency"; "an CSV File" → "a CSV file" + both "following command" articles; "one missing values" → "one missing value"; "leasts sqaures" → "least squares"; `\date{September 18, 2022}` → `\date{\today}`.

18. **Keep `R/tutorial.R` in sync with the .Rnw chunks** — created 2026-09-01 (all chunk code in paper order, `## ---- chunk-name ----` markers, syntax-checked). It's a manual extract: after chunk changes in tutorial.Rnw, the script needs updating too (ask Claude).

## Backlog (from earlier session, still open)

- ~~`infer()` output too large~~ — largely resolved: the `infer(res_csem_boot)` call is gone from the .Rnw; the assessment skeleton now extracts only `summarize(res_csem_boot)$Estimates$Loading_estimates` / `$Weight_estimates`. Remaining aspect (percentile CIs) is covered by item 3 (tables built from R).
- Fill the empty `\citep{}` — now **three** (verified 2026-08-31): Introduction (open-science/accessibility claim, line 168), "Model specification" (reflective vs. composite models explanation, line 289 — newly spotted, was untracked) and (single-indicator constructs, line 291).
- ~~`\ref{tab:measurement}` dangling~~ — obsolete, reference no longer in the .Rnw.
- ~~"Further cSEM functionality" empty heading~~ — obsolete, heading removed; topic covered by items 4/7.
- Decide: proper `renv::restore()` on Linux vs. current user-library workaround (renv `.Rprofile` is bypassed with `--no-init-file` for now).

## Done

- ✅ **Mechanical fix batch applied (was item 16; closed items 11 and 14, 2026-08-31):** tutorial.bib got `Beran1985`; `\citet{Beran}` → `\citet{Beran1985}`, `\citet{DijkstraandHenseler2015}` → `\citet{Dijkstra2015}`; "boostrap" → "bootstrap"; `$d\_G$` → `$d_G$`; "checks of" → "checks whether" + "covarariance" → "covariance" and the duplicate verify sentence deleted; "test the null" → "tests"; "root mean square residual" → "standardized …"; `\ref{sec:Customization}` → `\ref{sec:customization}` with labels `sec:further`/`sec:customization`/`sec:discussion` added to Jason's new skeleton sections (+ "CSEM" → `\pkg{cSEM}` in that heading); new-prose typos: "Structural model" → lowercase, "ommited" → "omitted", "extracted from one at a time" → "extracted one at a time", AVE "are" → "is", "asscociated" → "associated", missing period after "calculation issues". Verified by grep: no old strings remain; all cite keys and section refs resolve (only `sec:comparison` is label-less, and only inside the commented-out roadmap).
- ✅ **Shortened `assess()` overview output (2026-08-31):** section-aware knitr output hook in the setup chunk — chunks with option `excerpt.lines = n` show each section headline of the printed output plus the first n lines, "..." for omitted lines (logic tested against the real 169-line output → 73 lines at n = 5). Applied to `assess-quality` (`excerpt.lines = 5`); `% TODO (Jason)` marker added for the explanatory sentence. Reusable for other long outputs (e.g. `summarize()`). Caveat: keyed to cSEM's print separator style; if that changes, the untrimmed output appears (no error).
- ✅ **Warning display fixed (2026-08-31):** custom knitr warning hook in the setup chunk — warnings keep the magenta `warningcolor` but are typeset as a verbatim block inside the chunk box (like normal output) instead of a full-width wrapped text paragraph; lines are wrapped at 80 characters to fit the output frame.
- ✅ **testOMF() error (was item 10)** — fix merged in FloSchuberth/cSEM master, GitHub build installed, chunk confirmed working (2026-08-31). `.seed = 42` is active in the chunk and the external `set.seed(42)` workaround is gone (verified in the .Rnw).
- ✅ Assessment chapter restructured into "Assessment Methods" with three numbered subchapters: 3.1 Overall model fit, 3.2 Reflective measurement and composite models, 3.3 Structural model evaluation (new skeleton) — 2026-08-31, see item 7.
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
