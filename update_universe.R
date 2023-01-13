paws_tree <- "./paws/cran"

url <- "https://github.com/paws-r/paws"
df <- data.frame(package = list.files(paws_tree))
df$url <- url
df$subdir <- sprintf("cran/%s", df$package)
paws.common <- c("paws.common", url, "paws.common")
df <- rbind(df, paws.common)

list_sub_cat_pkgs <- function(pkgs){
  return(pkgs[grepl(".p[0-9]+$", pkgs)])
}

list_cat_pkgs <- function(pkgs){
  pkgs <- pkgs[grepl("paws[.].*$", pkgs)]
  pkgs <- pkgs[!grepl(".p[0-9]+$", pkgs)]
  return(pkgs[!grepl("paws.common", pkgs)])
}

build_order <- c(
  "paws.common",
  list_sub_cat_pkgs(df$package),
  list_cat_pkgs(df$package),
  "paws"
)

jsonlite::write_json(
  df[match(build_order, df$package),],
  "packages.json",
  pretty = T
)
