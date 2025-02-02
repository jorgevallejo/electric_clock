# Second take
# Code adapted from https://stackoverflow.com/questions/18648115/circular-time-plots-in-r-with-stacked-rose

library('ggplot2')

horas <- read.csv("data/tramos2.csv",
                  header = TRUE)

# Reordering factor levels for a nicer plot legend
horas$Tarifa <- factor(horas$Tarifa, levels = c("Valle", "Llana", "Punta"))

p <- ggplot(horas, aes(x = Hora, y = 1, fill = Tarifa)) +
  geom_bar(width = 2, colour = 'grey', stat = 'identity') +
  theme_minimal() +
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        plot.background = element_rect(fill = "lightyellow"),
        plot.caption = element_text(hjust = 0)) + # Background colour
  scale_fill_manual(values = c("chartreuse3", "orange", "red")) + # Colours for factors
  coord_polar(start = 0) +
  scale_x_continuous("", limits = c(0,24), breaks = seq(0,24), labels = seq(0,24)) +
  labs(title = "TARIFAS DE LA LUZ",
       subtitle = "de lunes a viernes*",
       caption = "*Durante los fines de semana (sábado y domingo) la tarifa es siempre Valle.")

p

# Create results directory
if (!(dir.exists("results"))) {
  dir.create("results")
}

# Save as files
## Width and height found by trial and error to avoid printing the limits of the graph
## pdf format is way lighter than png
ggsave("results/tarifas.pdf", p, width = 4.82, height = 4.78)
ggsave("results/tarifas.png", p, width = 4.82, height = 4.78)
