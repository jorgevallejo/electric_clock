# Second take
# Code from https://stackoverflow.com/questions/18648115/circular-time-plots-in-r-with-stacked-rose

horas <- read.csv("tramos2.csv",
                  header = TRUE)

library('ggplot2')

p <- ggplot(horas, aes(x = Hora, y = 1, fill = Tarifa)) +
  geom_bar(width = 2, colour = 'grey', stat = 'identity') +
  theme_minimal() +
  scale_fill_brewer() +
  coord_polar(start = 0) +
  scale_x_continuous("", limits = c(0,24), breaks = seq(0,24), labels = seq(0,24))

p
