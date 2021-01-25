source("../scripts/install.R")

scholar_id <- "6fC0BYYAAAAJ"
pubs <- scholar::get_publications(scholar_id) %>%
  dplyr::mutate(author = author %>% 
                  as.character %>% 
                  stringr::str_trim() %>% 
                  gsub("\\.\\.\\.", "et al", .)) %>%
  dplyr::select(pubid, title, dplyr::everything()) %>%
  arrange(desc(year))
write.csv(pubs, here("data", "pubs.csv"))
npubs <- nrow(pubs)

selected_pubs <- read_csv(here("data", "selected_pubs.csv")) %>%
  mutate(
    note = case_when(
      !is.na(note) ~ note, 
      is.na(note) ~ ""),
    info = case_when(
      note == "" ~ paste0("Role: ", role),
      TRUE ~ paste0("Role: ", role, ". ", note)
    )
  ) %>%
  select(-title)

spubs <- inner_join(pubs, selected_pubs, by="pubid")
for(i in 1:nrow(spubs))
{
  message(i, " of ", nrow(spubs))
  Sys.sleep(2)
  spubs$author[i] <- get_complete_authors(scholar_id, spubs$pubid[i], initials=FALSE)
}

get_author_pos <- function(author, m=c("Hemani"))
{
  strsplit(author, split=", ") %>% 
    sapply(., function(x) {
      paste0(grep(m, x)[1], "/", length(x))
    })
}

spubs$authorpos <- get_author_pos(spubs$author, "Hemani")
spubs <- spubs %>% mutate(
  authorpos = get_author_pos(author, "Hemani"),
  info = case_when(
    str_count(author, ",") >= 5 ~ paste0(info, ". Position: ", authorpos),
    TRUE ~ info
  ),
  info = case_when(
    !is.na(pos) ~ paste0(info, " (", pos, ")"),
    TRUE ~ info
  )
)

scholar_profile <- scholar::get_profile(scholar_id)
h_index <- scholar_profile$h_index
i10_index <- scholar_profile$i10_index
save(spubs, pubs, npubs, h_index, i10_index, scholar_id, file="../data/pubs.rdata")
