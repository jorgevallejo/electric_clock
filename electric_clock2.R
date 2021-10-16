# Second take
# Code from https://stackoverflow.com/questions/18648115/circular-time-plots-in-r-with-stacked-rose

horas <- read.csv("tramos2.csv",
                  header = TRUE)

# Reordering factor levels for a nicer plot legend
horas$Tarifa <- factor(horas$Tarifa, levels = c("Valle", "Llana", "Punta"))

library('ggplot2')

p <- ggplot(horas, aes(x = Hora, y = 1, fill = Tarifa)) +
  geom_bar(width = 2, colour = 'grey', stat = 'identity') +
  theme_minimal() +
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        plot.background = element_rect(fill = "lightyellow")) + # Background colour
  scale_fill_manual(values = c("chartreuse3", "orange", "red")) + # Colours for factors
  coord_polar(start = 0) +
  scale_x_continuous("", limits = c(0,24), breaks = seq(0,24), labels = seq(0,24)) +
  labs(title = "TARIFAS DE LA LUZ",
       subtitle = "de lunes a viernes*",
       caption = "*Durante los fines de semana (sábado y domingo) \nla tarifa es siempre Valle.")

p
