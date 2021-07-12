#' A ggplot theme with transparent backgrounds and a box around the plot. Also
#' defines shapes and colors of points.
#'
#' @param plot The ggplot object
#' @return The same object with the added theme and scale_*
my_transparent_theme <- function(plot) {
    plot +
        theme(
            panel.background = element_rect(fill = "transparent"),
            plot.background = element_rect(fill = "transparent", color = NA),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.border = element_rect(color = "black", fill=NA),
            legend.position = "none"
        ) +
        scale_shape_manual(values=c("circle" = 21)) +
        scale_fill_manual(values=c("solid" = "white"))
}

#' Save plot with some default parameters
#'
#' @param plot ggplot object
#' @param name file name
save_figure <- function(plot, name, wmult=1, hmult=1) {
    ggsave(
        name,
        plot,
        bg='transparent',
        width = 5*wmult,
        height = 5*hmult
    )
}
