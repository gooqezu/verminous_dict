karta = read.csv("kartaslovsent.csv", sep=";", encoding="UTF-8")[, c(1, 2)]
babenko = read.csv("babenko.csv", sep=";", encoding="UTF-8")[, c(2, 6)]
russent = read.csv("russent.csv", sep=";", encoding="UTF-8")[, c(1, 4)]
babenko$word = stringr::str_to_lower(babenko$word)
russent$class = trimws(russent$class)
russent$word = trimws(russent$word)
russent_pos = c("positive", "postive", "postitive", "posititve", "posiive")
russent_neg = c("negative", "negative opinion", "negaitve", "negative. fact")
russent$class = ifelse(russent$class %in% russent_pos, "positive", "negative")
rm(russent_pos, russent_neg)

neg_dict = unique(c(karta$term[karta$tag=="NGTV"], babenko$word[babenko$X=="neg"], russent$word[russent$class=="negative"]))
pos_dict = unique(c(karta$term[karta$tag=="PSTV"], babenko$word[babenko$X=="pos"], russent$word[russent$class=="positive"]))
new_dict = data.frame(word = c(neg_dict, pos_dict), class = NA)
new_dict$class = ifelse(new_dict$word %in% pos_dict, "positive", "negative")
# write.csv(new_dict, "verminous.csv", row.names = F)
# View(read.csv("verminous.csv"))
