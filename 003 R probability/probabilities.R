#One ball will be drawn at random from a box containing: 3 cyan balls, 5 magenta balls, and 7 yellow balls.
#What is the probability that the ball will be cyan?
  
cyan <- 3
magenta <- 5
yellow <- 7

p1 = cyan/(cyan + magenta + yellow)
p1

#One ball will be drawn at random from a box containing: 3 cyan balls, 5 magenta balls, and 7 yellow balls.
#What is the probability that the ball will not be cyan?
p2 = 1 - p1
p2


#Instead of taking just one draw, consider taking two draws. You take the second draw without returning the first draw to the box. We call this sampling without replacement.
#What is the probability that the first draw is cyan and that the second draw is not cyan?
#Provide at least 3 significant digits.
cyan <- 3
magenta <- 5
yellow <- 7

# The variable `p1` is the probability of choosing a cyan ball from the box on the first draw.
p1 <- cyan / (cyan + magenta + yellow)

# Assign a variable `p2` as the probability of not choosing a cyan ball on the second draw without replacement.
p2 <- 1 - (cyan - 1) / (cyan + magenta + yellow - 1)

# Calculate the probability that the first draw is cyan and the second draw is not cyan.
p1 * p2

#Now repeat the experiment, but this time, after taking the first draw and recording the color, return it back to the box and shake the box. We call this sampling with replacement.
#What is the probability that the first draw is cyan and that the second draw is not cyan?
cyan <- 3
magenta <- 5
yellow <- 7

# The variable `p_1` is the probability of choosing a cyan ball from the box on the first draw.
p1 <- cyan / (cyan + magenta + yellow)

# Assign a variable `p_2` as the probability of not choosing a cyan ball on the second draw with replacement.
p2 <- 1 - (cyan) / (cyan + magenta + yellow - 1)

# Calculate
p1 * p2

#Explanation

#There are 3 + 5 + 7 = 15 total balls in the box. The probability of the first draw being cyan is 3/15, and the probability of the second draw (with replacement) being not cyan is 12/15 (because we put the ball back in that we removed). So the probability of the first draw being cyan and the second draw being not cyan is 3/15 * 12/15, which is 0.16.