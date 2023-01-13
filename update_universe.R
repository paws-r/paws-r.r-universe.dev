paws_tree <- "./paws/cran"

url <- "https://github.com/paws-r/paws"
df <- data.frame(package = list.files(paws_tree))
df$url <- url
df$subdir <- sprintf("cran/%s", df$package)
paws.common <- c("paws.common", url, "paws.common")
jsonlite::write_json(rbind(df, paws.common), "packages.json", pretty = T)
