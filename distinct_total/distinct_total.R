source("../util.R")
library(ggplot2)

usage = paste(
    sep='\n',
    "ús: Rscript distinct_total.R fitxer.csv fitxer.pdf",
    "utilitza la taula de fitxer.csv per crear una figura que desa a fitxer.pdf",
    "genera ona gràfica mostrant el nombre de paraules totals contra el numbre de paraules úniques"
)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
    stop(usage)
}
table <- read.csv(args[1])
pdffile <- args[2]

plot <- ggplot(table, aes(tokens, types)) +
    geom_point(aes(shape="circle", fill="solid")) +
    scale_y_log10(n.breaks=9) +
    scale_x_log10(n.breaks=9) +
    xlab("aparicions") +
    ylab("tipus")
plot <- my_transparent_theme(plot)

save_figure(plot, pdffile)
