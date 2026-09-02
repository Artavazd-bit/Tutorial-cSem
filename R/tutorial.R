# ------------------------------------------------------------------------------
# Consistent Partial Least Squares: A cSEM tutorial
# Jason J. Berger & Florian Schuberth
#
# All R code from the chunks of tutorial.Rnw (state: 2026-09-01), in paper order.
# Chunk names are given as "## ---- name ----" markers.
# Run from the project root (paths are relative to it).
# ------------------------------------------------------------------------------

## ---- install-csem ----
# Install cSEM once per machine (development version: github.com/FloSchuberth/cSEM)
# install.packages("cSEM")

## ---- load-csem ----
library(cSEM)

# --- 2.2 Model and Data -------------------------------------------------------

## ---- load-data ----
# Import dataset
HBAT_SEM <- read.csv("data/HBAT_SEM.csv", sep=";")

# Select relevant variables
HBAT_SEM_rel <- HBAT_SEM[, c("AC1", "AC2", "AC3", "AC4",
                   "EP1", "EP2", "EP3", "EP4",
                   "JS1", "JS2", "JS3", "JS4", "JS5",
                   "OC1", "OC2", "OC3", "OC4",
                   "SI1", "SI2", "SI3", "SI4")]

# show dimensions of the relevant dataset
dim(HBAT_SEM_rel)

# count missing values per variable
colSums(is.na(HBAT_SEM_rel))

## ---- missing-data ----
# filter the dataset, only select complete cases
HBAT_SEM_rel <- HBAT_SEM_rel[complete.cases(HBAT_SEM_rel),]

#  the number of rows changed from 400 to 398
dim(HBAT_SEM_rel)

# --- 2.3 Model specification --------------------------------------------------

## ---- model-spec ----
model <- "
  # Measurement model
  AC =~ AC1 + AC2 + AC3 + AC4
  EP =~ EP1 + EP2 + EP3 + EP4
  JS =~ JS1 + JS2 + JS3 + JS4 + JS5
  OC =~ OC1 + OC2 + OC3 + OC4
  SI =~ SI1 + SI2 + SI3 + SI4

  # Structural model
  JS ~ EP + AC
  OC ~ EP + AC + JS
  SI ~ JS + OC
"

# --- 2.4 Model estimation -----------------------------------------------------

## ---- csem-est ----
# PLSc-SEM estimation
res_csem <- csem(
  .data             = HBAT_SEM_rel,
  .model            = model,
  .resample_method  = "bootstrap",
  .R                = 1000,
  .seed             = 42
)

## ---- summary-rescsem ----
# Full results summary
summary_res <- summarize(res_csem)
summary_res

# --- 3.1 Overall model fit ----------------------------------------------------

## ---- verify ----
# Check whether the estimation is admissible
verify(res_csem)

## ---- test-omf ----
# Bootstrap-based test of the overall model fit
fit_test <- testOMF(
  res_csem,
  .R                    = 1000,
  .seed                 = 42,
  .handle_inadmissibles = "replace"
)

fit_test

# --- 3.2 Assessment of the reflective measurement models ----------------------

## ---- assess-quality ----
#Compute all quality criteria
quality <- assess(res_csem)
quality

## ---- assess-rho-A ----
#Show Dijkstras and Henselers rho A
quality$Reliability

## ---- assess-rho_C ----
# Show rho_C
quality$RhoC
quality$RhoC_mm
quality$RhoC_weighted
quality$RhoC_weighted_mm

## ---- loadings-boot ----
# Loading estimates incl. bootstrap std. errors, t-values and p-values
summarize(res_csem)$Estimates$Loading_estimates

## ---- ave ----
# Average variance extracted (AVE)
quality$AVE

## ---- htmt ----
# Heterotrait-monotrait ratio of correlations (HTMT)
HTMT <- assess(res_csem,
               .quality_criterion = "htmt",
               .inference = "asymptotic",
               .absolute = FALSE)
HTMT

## ---- htmt2 ----
# Heterotrai-monotrait ratio 2 of correlations (HTMT2)
HTMT2 <- assess(res_csem,
                .quality_criterion = "htmt2",
                .inference = "bootstrap",
                .absolute = FALSE)
HTMT2

## ---- vif-indicators ----
# VIF values for Mode B (composite) weights
# (not run in the paper: all constructs are reflective; element name unverified)
# quality$VIF_modeB

## ---- weights-boot ----
# Weight estimates incl. bootstrap std. errors, t-values and p-values
summarize(res_csem)$Estimates$Weight_estimates

# --- 3.3 Structural model evaluation ------------------------------------------

## ---- paths-boot ----
# Path coefficient estimates incl. bootstrap std. errors, t-values and p-values
summarize(res_csem)$Estimates$Path_estimates

## ---- effect-sizes ----
# Effect sizes (f^2)
quality$F2

## ---- r-squared ----
# Coefficient of determination (R^2) and adjusted R^2
quality$R2
quality$R2_adj
