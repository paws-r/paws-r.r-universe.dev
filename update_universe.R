paws_tree <- "./paws/cran"

url <- "https://github.com/paws-r/paws"

list_sub_cat_pkgs <- function(pkgs) {
  return(pkgs[grepl(".p[0-9]+$", pkgs)])
}

list_cat_pkgs <- function(pkgs) {
  pkgs <- pkgs[grepl("paws[.].*$", pkgs)]
  pkgs <- pkgs[!grepl(".p[0-9]+$", pkgs)]
  return(pkgs[!grepl("paws.common", pkgs)])
}

core_pkgs <- list.files(paws_tree)

build_order <- c(
  list_sub_cat_pkgs(core_pkgs),
  list_cat_pkgs(core_pkgs),
  "paws"
)

core_pkg <- lapply(build_order, \(pkg) {
  list(package = pkg, url = url, subdir = sprintf("cran/%s", pkg))
})

support_pkg <- list(
  list(package = "awscrt", url = "https://github.com/paws-r/aws-crt-r"),
  list(package = "paws.common", url = url, subdir = "paws.common")
)

jsonlite::write_json(
  c(support_pkg, core_pkg),
  "packages.json",
  pretty = T,
  auto_unbox = T
)
