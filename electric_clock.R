# Original code from https://stackoverflow.com/questions/11877379/how-to-draw-clock-in-r#11878078
# And https://stackoverflow.com/questions/7721262/colouring-plot-by-factor-in-r

require('grid')
require('gridBase')

# Load data
segmentos <- read.csv("tramos.csv")

# Los inputs son:
# hora de inicio, hora de fin, y tramo

# One of the inputs of pie is the areas of the pie slices
# That would be the number of hours in each register (file)

segmentos$slice_area <- segmentos$Fin - segmentos$Inicio

# Pie takes that data in order, so we need to order the files first

segmentos <- segmentos[order(segmentos$Inicio),]

# Reordering factor levels for a nicer plot legend
segmentos$Tramo <- factor(segmentos$Tramo, levels = c("Valle", "Llana", "Punta"))

# Specify colours of the slices
# They must be in the same order of the factor levels

colores <- c("green", "orange", "red")

# Draw a pie chart
pie(segmentos$slice_area, # areas of pie slices
    clockwise = TRUE, # slices are drawn clockwise
    radius = 1.0,
    init.angle = 90, # starting at 12 o'clock
    col = colores[segmentos$Tramo], # filling the slices according to levels
    border = NA)

legend(x="right", legend = levels(segmentos$Tramo), col = colores, pch = 15, bty = 'n')






# Draw the clock
drawClock <- function (hour, minute) {
  t <- seq(0, 2*pi, length = 13)[-13] # Position of ticks
  x <- cos(t)
  y <- sin(t)
  
  vps <- baseViewports()
  pushViewport(vps$inner, vps$figure, vps$plot)
  # ticks
  
  grid.segments(x, y, x*.9, y*.9, default = 'native')
  # Hour hand
  hourAngle <- pi/2 - (hour + minute/60)/12*2*pi
  grid.segments(0, 0,
                .6*cos(hourAngle), .6*sin(hourAngle),
                default = 'native', gp=gpar(lex=4))
  # Minute hand
  minuteAngle <- pi/2 - (minute/60*2*pi)
  grid.segments(0, 0,
                .8*cos(minuteAngle), .8*sin(minuteAngle),
                default = 'native', gp=gpar(lex=2))
  popViewport(3)
}

drawClock(hour = 2, minute = 25)
