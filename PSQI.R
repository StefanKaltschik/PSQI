library(haven)
library(ggplot2)
library(tidyr)
PSQI <- read_sav(file.choose())

str(PSQI)
head(PSQI)


library(plyr)

PSQI$Schulform<-as.factor(PSQI$Schulform)

neuedaten<-select(PSQI, Schulform, PSQI)

neuedaten$Schulform<-revalue(neuedaten$Schulform, c("1"="BHAS", "2"="HAK", "3"="AHS"))
neuedaten<-drop_na(neuedaten)

library(dplyr)
group_by(neuedaten, Schulform) %>%
  summarise(
    count = n(),
    mean = mean(PSQI, na.rm = TRUE),
    sd = sd(PSQI, na.rm = TRUE)
  )

ggboxplot(neuedaten, "Schulform",  "PSQI", 
          color = "Schulform", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("BHAS", "HAK", "AHS"),
          ylab = "PSQI-Score", xlab = "Schulform")






##ggplot(newdata, aes(KörpergrößeMeter, Gewicht))+geom_point(aes(colour = factor(Geschlecht)),size=PSQI$PSQI,alpha=0.5)


