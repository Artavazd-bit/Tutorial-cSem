# TODO — cSEM Tutorial Paper

_Last updated: 2026-10-14. **Next up (Jason): write the prose for 5.1 Customization of PLS-PM** — nine `% TODO (Jason)` slots in `tutorial.Rnw` (lines ~560–706: lead-in, four argument blocks, three example notes); all seven chunks are in place and verified. After that: ask Claude for the 5.2 predict skeleton. — Background: the assessment-chapter prose is written (old item 9 closed); Jason wrote the construct-reliability, indicator-reliability, AVE and structural blocks, the weights step was dropped, Claude reviewed twice on 2026-10-13 and Jason applied the mechanical fixes. What remains in chapter 3 is citations and a few decisions. cSEM runs from GitHub master on Jason's machine (CRAN 0.6.1 in Claude's library does **not** accept `.inference = "asymptotic"` — Jason's knit is the reference)._

## Open

### A. Assessment chapter (Sec. 3) — finishing touches

1. **Citations (knit-breaker) → see the checklist section "Citations" below.** Nine keys without bib entry, seven empty `\cite{}`, and all chapter-3 citations are `\citet` where `\citep` is meant. Jason does these after the first draft.
2. **Reliability definition sentence (l. 437):** "A construct with high reliability tends to produce similar items under consistent conditions" — reads as if the construct produces items; reliability is about the *measurement* yielding consistent *scores*. Jason to rephrase.
3. **Two grammar leftovers in the `verify()` paragraph (l. 386–387):** "It gives information if convergence is achieved, all absolute standardized loading estimates are smaller or equal than one." → "…whether convergence is achieved and whether all absolute standardized loading estimates are less than or equal to one." (second sentence already fixed).
4. **HTMT warning sentence vs. HTMT2 NaN — decision with Florian (was items 1/6/13).** "This does not lead to any calculation issues" (l. ~500) is true for HTMT, but the same mixed-sign pattern makes the HTMT2 JS–AC cell NaN; the `htmt2` chunk hides this with `warning = FALSE`. Decide: say so in the text (cSEM surfaces a data problem SmartPLS hides — the "warnings as an advantage" point, old item 6) or leave it. Watch-out: once Jason's upstream HTMT-warning PR lands in the installed build, the `htmt` chunk's warning disappears and the sentence becomes stale. The warning still fires on CRAN 0.6.1 (verified 2026-10-13).
5. **Threshold sentence:** the HTMT decision rule is now commented out (l. ~489) — the chapter is threshold-free. Decide whether to delete the comment for good.
6. **Structural section leftovers (3.3):** `%direct indirect effects fehlt noch` — decide whether total/indirect effects get a chunk (`quality$Effects` exists, verified 2026-10-13); and whether 3.3 gets a structural-VIF chunk (`quality$VIF` is structural VIF; the Abstract and Benitez list collinearity under structural assessment).
7. **Minor:** `loadings-boot` chunk comment says "std. errors, t-values and p-values" but the output also has the 95 % percentile CI columns the prose promises — add "and CIs". `$\mathdollar$` (l. 445) renders fine but `\code{\$}` would match the inline-code style. Keep the four ρ_C variants (`RhoC`, `_mm`, `_weighted`, `_weighted_mm`) or trim (old item 12, still open).

### B. Rest of the paper

8. **Section 5 "Further features of cSEM".** 5.1 Customization rebuilt (Claude, 2026-10-14) around the 15 `csem()` arguments Jason picked, grouped in the order csem() uses them, one `\subsubsection*` each with the same shape (defaults chunk → example chunk): **Outer and Inner Weights** (`.PLS_modes`, `.PLS_weight_scheme_inner`, `.PLS_ignore_structural_model`, `.starting_values`, `.dominant_indicators`; chunks `custom-weights-default`, `custom-weighting` centroid), **Convergence** (`.conv_criterion`, `.tolerance`, `.iter_max`; chunks `custom-convergence-default`, `custom-nonconvergence` with `.iter_max = 2` → verify() check 1 "not ok", now live), **Correction for Attenuation (PLSc)** (`.disattenuate`, `.PLS_approach_cf`, `.reliabilities`; chunks `custom-plsc-default`, `custom-disattenuate`), **Structural Model** (`.approach_paths`, `.approach_nl`, `.normality`, `.id`; chunk `custom-structural-default`, no example — 2SLS needs instruments, the rest belongs to 5.3/5.4). All seven chunks run on CRAN 0.6.1 (2026-10-14); the four defaults chunks reproduce `res_csem` without bootstrap. The single `custom-overview` chunk and the old Robust Correlations / Resampling Options blocks are gone; to revive them: `.approach_cor_robust = "spearman"` (EP → OC 0.43 vs. 0.61), `.handle_inadmissibles` ("drop"/"ignore"/"replace"), `.sign_change_option` ("none"/"individual"/"individual_reestimate"/"construct_reestimate"). Open: `.approach_nl`/`.normality`/`.id` get one sentence + forward reference to 5.3/5.4, or move there entirely. `args_default()` deliberately not used. Mode B via `.PLS_modes` left out: on this all-reflective model it yields reliabilities > 1 and `verify()` flags it. **Still skeleton-only:** 5.2 predictive (`predict()`), 5.3 non-linear (Dijkstra & Schermelleh-Engel 2014), 5.4 MGA (Klesel et al. 2021; Sarstedt et al. 2019) — their headings still carry Jason's notes *inside* `\subsection{}` (print in heading + TOC → move to `%` comments) and need title case.

9. **Section 4 "Comparing PLS with alternative estimators" — not started.** Planned in the structure (lavaan/CB-SEM, GSCA, sum scores?). `R/tutorial.R` already carries a `lavaan::sem()` run of the same model after the `model-spec` chunk that could seed it. `\label{sec:comparison}` does not exist yet.
10. **Concluding remarks — empty.** Pick up the open-source argument from the Introduction again here (old item 5), and the "cSEM reports warnings, SmartPLS doesn't" point (item 4 above).
11. **Roadmap paragraph in the Introduction — gone.** The commented-out blueprint has been deleted; the Introduction now has no `\ref{sec:…}` at all. Re-add a short roadmap once sections 4/5 exist.
12. **Generate tables from R instead of raw output (old item 3).** Hidden chunk (`echo=FALSE, results='asis'`) building `tab:structural` via `cat()`/`sprintf()` from `summarize(res_csem)$Estimates$Path_estimates` (Estimate, SD, t, p, 95 % percentile CI) + `quality$VIF`/`quality$F2`, with a *Note* line; same pattern later for `tab:htmt`, `tab:fit`. Verify against Cheah et al.'s tables. Depends on how much raw output Florian wants to keep.
13. **Keep `R/tutorial.R` in sync (old item 18)** — currently **out of sync**: still contains a `vif-indicators` chunk that no longer exists in the .Rnw, the `weights-boot` chunk that was deleted, and the `htmt`/`htmt2` chunks lack the new `quality$HTMT` / `quality$HTMT2` lines and the `.seed = 42`. Also the lavaan block (see item 9) is script-only. Ask Claude after the next chunk change.

## Citations — to do after the first draft (Jason)

Checklist of every citation spot that currently breaks BibTeX (verified 2026-10-13). "Suggested source" is Claude's proposal; the bib-status column says whether an entry already exists. All chapter-3 citations are parenthetical → use `\citep{}` (not `\citet{}`). Line numbers refer to `tutorial.Rnw` as of 2026-10-13.

### Placeholder keys (key exists in the .Rnw, not in the bib)

| Line | Context | Current | Suggested source | Bib status |
|---|---|---|---|---|
| 437 | definition of reliability | `\citet{Reliability}` | Jason's pick — e.g. Nunnally & Bernstein (1994) *Psychometric Theory*, or simply `Benitez2020` | new entry, or `Benitez2020` exists |
| 439 | Cronbach's α | `\citet{Cronbach}` | Cronbach (1951). Coefficient alpha and the internal structure of tests. *Psychometrika*, 16(3), 297–334 | **new entry** (`Cronbach1951`) |
| 439 | Jöreskog's ρ_C | `\citet{Joereskog}` | Jöreskog (1971). Statistical analysis of sets of congeneric tests. *Psychometrika*, 36(2), 109–133 | **new entry** (`Joereskog1971`) — note: the existing `Joereskog1970` is the ETS structural-equation bulletin, *not* the congeneric-reliability paper |
| 439 | Dijkstra–Henseler's ρ_A | `\citet{Dijkstra}` | Dijkstra & Henseler (2015), *MIS Quarterly* | **exists** → rename to `Dijkstra2015a` |
| 476 | AVE | `\citet{AVE}` | Fornell & Larcker (1981). Evaluating structural equation models with unobservable variables and measurement error. *JMR*, 18(1), 39–50 | **new entry** (`Fornell1981`) |
| 206 | R | `\citep{R}` | R Core Team (2025). R: A language and environment for statistical computing — `citation()` | **new entry** |
| 206 | SEMinR | `\citep{seminr}` | Ray, Danks & Calero Valdez — `citation("seminr")` | **new entry** |
| 206, 254 | cSEM package | `\citep{csem}` | Rademaker & Schuberth, cSEM manual — `citation("cSEM")` | **new entry** — `Rademaker2019` is the *Internet Research* article, not the package |
| 206 | plspm | `\citep{Sanchez2025}` | Sanchez, Trinchera & Russolillo — `citation("plspm")` | **new entry** |

### Empty citations `\cite?{}`

| Line | Context | Suggested source | Bib status |
|---|---|---|---|
| 441 | α assumes equal weights + tau-equivalence | `Cronbach1951` again, or `Dijkstra2015a` (discusses the assumptions of all three) | see above |
| 442 | ρ_C allows unequal loadings, unit weights | `Joereskog1971` | new entry (above) |
| 443 | ρ_A based on estimated weights | `Dijkstra2015a` | exists |
| 475 | definition of convergent validity | `campbell_convergent_1959` and/or `Benitez2020` | both exist |
| 477 | AVE definition (variance captured vs. measurement error) | `Fornell1981` | new entry (above) |
| 209 | Introduction: open-source → accessibility/inclusiveness claim | `UNESCO` (Open Science Recommendation) is in the bib and fits; otherwise Jason's pick | exists |
| 316 | Model Specification: single-indicator constructs common in PLS-PM | Jason's pick — candidates in bib: `Benitez2020`, `Hair2026primer`, `sarstedt_partial_2022` | exist |

### Suggested additions (no citation at all yet)

| Line | Context | Suggested source | Bib status |
|---|---|---|---|
| ~482 | HTMT | Henseler, Ringle & Sarstedt (2015) | **exists** → `Henseler2015` |
| ~482 | HTMT2 | Roemer, Schuberth & Henseler (2021). HTMT2 — an improved criterion for assessing discriminant validity in structural equation modeling. *Industrial Management & Data Systems*, 121(12), 2637–2650 | **new entry** (`Roemer2021`) |
| ~538 | effect size f² | Cohen (1988). *Statistical Power Analysis for the Behavioral Sciences* (2nd ed.) | **new entry** (`Cohen1988`) — optional |

## Backlog

- Decide: proper `renv::restore()` on Linux vs. current user-library workaround (renv `.Rprofile` is bypassed with `--no-init-file` for now). Claude's library has CRAN cSEM 0.6.1, not the GitHub build.
- Blank line before the `verify` and `test-omf` chunks (cosmetic; all other chunks have one).

## Done

- ✅ **Assessment-chapter prose written (old item 9, 2026-09-04 → 2026-10-13, Jason):** construct reliability (α / ρ_C / ρ_A with assumptions), indicator reliability, convergent validity, discriminant validity (HTMT + HTMT2 incl. `quality$HTMT`/`quality$HTMT2` point estimates before the inference calls), structural model (paths, f², R²/adj. R²). Weights step dropped (option block + `weights-boot` chunk deleted). HTMT threshold sentence commented out → chapter is threshold-free. The AVE threshold sentence is gone.
- ✅ **Mechanical fixes after Claude's review (2026-10-13, Jason):** "examined..", "coeffificents", "measurment", "Additionnaly", "beconsulted", "Heterotrai" ×2 fixed; "less than or equal to one" (2nd occurrence); "For that see Section"; comma splice split into three sentences; "indicators belonging to"; "measurement error"; `\fn{csem()}` object; `assess-rho-A` chunk comment now "Show reliability criteria"; heading "Assessment of the Reflective Measurement Models" in title case; Model Specification / Model Estimation headings in title case.
- ✅ **Verified live 2026-10-13 (CRAN 0.6.1):** `names(quality)` contains `HTMT`, `HTMT2`, `Effects`, `F2`, `R2`, `R2_adj`, `Reliability`, `VIF` (no `VIF_modeB`); `summarize()$Estimates$Loading_estimates` has columns Estimate, Std_err, t_stat, p_value, CI_percentile 95 % L/U; the HTMT sign warning still fires.
- ✅ Upstream: HTMT-warning PR and `assess()`-robustness report to FloSchuberth/cSEM (Jason, 2026-09-01; old items 1/15). testOMF fix merged and installed (old item 10).
- ✅ Prose polish outside the assessment section (old item 17, 2026-09-01) and the mechanical fix batch of 2026-08-31 (old items 11/14/16; details in the next entries).

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
