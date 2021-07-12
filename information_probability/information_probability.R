source("../util.R")
library(ggplot2)

df <- data.frame(p=seq(0.001, 1, 0.001))
df['I'] = -log(df['p'])
df['pI'] = df['p'] * df['I']

plot <- ggplot(df, aes(p)) +
    geom_line(aes(y = I, linetype = 'a')) +
    geom_line(aes(y = pI, linetype = 'c')) +
    xlab("p (probabilitat)") +
    ylab("bits") +
    guides(linetype = FALSE)
plot <- my_transparent_theme(plot)

save_figure(plot, "information_probability.png")
