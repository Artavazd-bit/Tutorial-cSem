# Base image: R 4.5.2 + full TeX Live + pandoc (matches the R version in renv.lock).
# rocker/verse already bundles a LaTeX installation, which is what the .Rnw -> PDF
# (knitr -> pdfLaTeX) workflow needs.
FROM rocker/verse:4.5.2

WORKDIR /project

# Install packages directly into the project library instead of symlinking from a
# global cache. In a container the cache adds no value and the symlinks make the
# image more fragile, so disabling it keeps real package folders in renv/library.
ENV RENV_CONFIG_CACHE_ENABLED=FALSE

# Copy the renv infrastructure FIRST. When R starts, .Rprofile sources
# renv/activate.R, which sets the project library path to /project/renv/library
# *before* restore runs. Without these files, renv::restore() installs to the
# wrong library and the packages are missing at runtime.
# Copying only the lockfile here also lets Docker cache the slow install step and
# re-run it only when renv.lock changes.
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# Restore the exact package versions from renv.lock into /project/renv/library.
RUN R -e "renv::restore()"

# Copy the rest of the project (.Rnw, .bib, data, scripts, etc.).
COPY . .

# Default: drop into R. Replace later with your build command, e.g.
#   CMD ["R", "-e", "knitr::knit2pdf('tutorial.Rnw')"]
CMD ["R"]
