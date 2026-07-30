library(cSEM)

HBAT_SEM <- read.csv("data/HBAT_SEM.csv", sep=";")

# Select relevant variables
HBAT_SEM_rel <- HBAT_SEM[, c("AC1", "AC2", "AC3", "AC4",
                             "EP1", "EP2", "EP3", "EP4",
                             "JS1", "JS2", "JS3", "JS4", "JS5",
                             "OC1", "OC2", "OC3", "OC4",
                             "SI1", "SI2", "SI3", "SI4")]

HBAT_SEM_rel <- HBAT_SEM_rel[complete.cases(HBAT_SEM_rel),]


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

res_csem <- csem(
  .data  = HBAT_SEM_rel,
  .model = model
)

quality <- assess(res_csem)
