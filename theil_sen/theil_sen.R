library(deming)

usage = paste(
    sep='\n',
    "ús: Rscript theil_sen.R fitxer.csv [fitxer.pdf]",
    "utilitza la taula de fitxer.csv per estimar l'exponent de la llei de zipf",
    "si s'ha donat fitxer.pdf, genera una gràfica de rang contra frequència amb la coba fitada"
)

## Llegeix comandes
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1 || length(args) > 2) {
    stop(usage)
}
table <- read.csv(args[1])
generate_plot = length(args) > 1
if (generate_plot) {
    plot_filename = args[2]
} else {
    plot_filename = NULL
}

model <- theilsen(log(rank)~log(freq), table)
alpha <- coef(model)[[2]]
A <- exp(coef(model)[[1]])

cat(paste(
    sep='\n',
    "Estimació dels paràmetres de la llei potencial:",
    paste("alpha =", alpha),
    paste("A =", A),
    ""
))

if (generate_plot) {
    source("../util.R")
    library(ggplot2)

    plot <- ggplot(table, aes(rank, freq, label=word)) +
        geom_point(aes(shape="circle", fill="solid")) +
        geom_line(aes(y=A*rank^alpha)) +
        scale_x_log10(n.breaks=9) +
        scale_y_log10(n.breaks=9) +
        xlab("rang") +
        ylab("freqüència")
    plot <- my_transparent_theme(plot)
    save_figure(plot, plot_filename)
    cat(paste("S'ha generat la gràfica", plot_filename, "\n"))
}
