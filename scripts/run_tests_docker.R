reporters <- c(
  testthat::JunitReporter$new(file = file.path(usethis::proj_get(), "scripts", "results", "report.xml")),
  testthat::ProgressReporter$new(),
  testthat::FailReporter$new()
)

options(warn = 2)

devtools::test(
  reporter = testthat::MultiReporter$new(reporters = reporters),
  stop_on_failure = TRUE
)

cov <- covr::package_coverage(
  path = file.path(usethis::proj_get()),
  type = "tests",
  quiet = FALSE,
  clean = FALSE,
)

covr::report(x = cov, file = file.path(usethis::proj_get(), "scripts", "results", "covr.html"), browse = FALSE)

