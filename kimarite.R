# extracts data from https://en.wikipedia.org/wiki/Kimarite


library(dplyr)
library(httr)
library(stringr)

options(stringsAsFactors = FALSE)


write.csv(
	as.data.frame(
		str_match_all(
			content(GET("https://en.wikipedia.org/wiki/Kimarite"), "text"),
			"<span class=\"tocnumber\">(.+)</span> <span class=\"toctext\"><i>(.+)</i>"
		)[[1]][, -1]
	) %>%
		group_by(substr(V1, 1, 1)) %>%
		mutate(V3 = first(V2)) %>%
		ungroup() %>%
		filter(nchar(V1) > 1) %>%
		transmute(kimarite = tolower(V2), group = tolower(V3)),
	file = "kimarite.csv",
	quote = FALSE,
	row.names = FALSE
)
