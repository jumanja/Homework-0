#Key points
#The probability of an event is the proportion of times the event occurs when we repeat the experiment independently under the same conditions.
#Pr(𝐴)=probability of event A 
#An event is defined as an outcome that can occur when when something happens by chance.
#We can determine probabilities related to discrete variables (picking a red bead, choosing 48 Democrats and 52 Republicans from 100 likely voters) and continuous variables (height over 6 feet).

beads <- rep(c("red", "blue"), times = c(2,3))    # create an urn with 2 red, 3 blue
beads    # view beads object
sample(beads, 1)    # sample 1 bead at random

B <- 10000    # number of times to draw 1 bead
events <- replicate(B, sample(beads, 1))    # draw 1 bead, B times
tab <- table(events)    # make a table of outcome counts
tab    # view count table
prop.table(tab)    # view table of outcome proportions

#set.seed(1986) 