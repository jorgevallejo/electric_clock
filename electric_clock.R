# Original code from https://stackoverflow.com/questions/11877379/how-to-draw-clock-in-r#11878078

require('grid')
require('gridBase')

# Draw a pie chart
pie(c(1,2), # areas of pie slices
    clockwise = TRUE, # slices are drawn clockwise
    radius = 1.0,
    init.angle = 90, # starting at 12 o'clock
    col = c('pink', 'lightblue'), # filling the slices
    border = NA)

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