library(ggplot2)
library(gridExtra)

# Upload the data to plot frequencies

frequencies <- read.table(file.choose(), header = T, sep = "\t")

# Divide the data into seven data frames according to language

BG <- frequencies[frequencies$Language == "BG",]
CR <- frequencies[frequencies$Language == "CR",]
CZ <- frequencies[frequencies$Language == "CZ",]
PL <- frequencies[frequencies$Language == "PL",]
RU <- frequencies[frequencies$Language == "RU",]
UK <- frequencies[frequencies$Language == "UK",]
SL <- frequencies[frequencies$Language == "SL",]

# Create a bar plot for each language

barplot_BG <- ggplot(BG, aes(x = reorder(Verb, -Sorting), y = Relative, fill = Verb)) +
  geom_bar(stat = "identity") +  # Use identity to plot actual values
  coord_flip() +  # Make bars horizontal
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none") +  # Hide legend
  theme(
    axis.text = element_text(color = "black", size = 13),   # Make axis tick labels black
    axis.title = element_text(color = "black")   # Make axis titles black
  ) +
  labs(title = "Bulgarian", x = "Verb", y = "Relative frequency") +
  ylim(0, 620)

barplot_BG

barplot_CR <- ggplot(CR, aes(x = reorder(Verb, -Sorting), y = Relative, fill = Verb)) +
  geom_bar(stat = "identity") +  # Use identity to plot actual values
  coord_flip() +  # Make bars horizontal
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none") +  # Hide legend
  theme(
    axis.text = element_text(color = "black", size = 13),   # Make axis tick labels black
    axis.title = element_text(color = "black")   # Make axis titles black
  ) +
  labs(title = "Croatian", x = "Verb", y = "Relative frequency") +
  ylim(0, 620)

barplot_CR

barplot_SL <- ggplot(SL, aes(x = reorder(Verb, -Sorting), y = Relative, fill = Verb)) +
  geom_bar(stat = "identity") +  # Use identity to plot actual values
  coord_flip() +  # Make bars horizontal
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none") +  # Hide legend
  theme(
    axis.text = element_text(color = "black", size = 13),   # Make axis tick labels black
    axis.title = element_text(color = "black")   # Make axis titles black
  ) +
  labs(title = "Slovenian", x = "Verb", y = "Relative frequency") +
  ylim(0, 620)

barplot_SL

barplot_CZ <- ggplot(CZ, aes(x = reorder(Verb, -Sorting), y = Relative, fill = Verb)) +
  geom_bar(stat = "identity") +  # Use identity to plot actual values
  coord_flip() +  # Make bars horizontal
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none") +  # Hide legend
  theme(
    axis.text = element_text(color = "black", size = 13),   # Make axis tick labels black
    axis.title = element_text(color = "black")   # Make axis titles black
  ) +
  labs(title = "Czech", x = "Verb", y = "Relative frequency") +
  ylim(0, 620)

barplot_CZ

barplot_PL <- ggplot(PL, aes(x = reorder(Verb, -Sorting), y = Relative, fill = Verb)) +
  geom_bar(stat = "identity") +  # Use identity to plot actual values
  coord_flip() +  # Make bars horizontal
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none") +  # Hide legend
  theme(
    axis.text = element_text(color = "black", size = 13),   # Make axis tick labels black
    axis.title = element_text(color = "black")   # Make axis titles black
  ) +
  labs(title = "Polish", x = "Verb", y = "Relative frequency") +
  ylim(0, 620)

barplot_PL

barplot_RU <- ggplot(RU, aes(x = reorder(Verb, -Sorting), y = Relative, fill = Verb)) +
  geom_bar(stat = "identity") +  # Use identity to plot actual values
  coord_flip() +  # Make bars horizontal
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none") +  # Hide legend
  theme(
    axis.text = element_text(color = "black", size = 13),   # Make axis tick labels black
    axis.title = element_text(color = "black")   # Make axis titles black
  ) +
  labs(title = "Russian", x = "Verb", y = "Relative frequency") +
  ylim(0, 620)

barplot_RU

barplot_UK <- ggplot(UK, aes(x = reorder(Verb, -Sorting), y = Relative, fill = Verb)) +
  geom_bar(stat = "identity") +  # Use identity to plot actual values
  coord_flip() +  # Make bars horizontal
  theme_minimal() +  # Use a clean theme
  theme(legend.position = "none") +  # Hide legend
  theme(
    axis.text = element_text(color = "black", size = 13),   # Make axis tick labels black
    axis.title = element_text(color = "black")   # Make axis titles black
  ) +
  labs(title = "Ukrainian", x = "Verb", y = "Relative frequency") +
  ylim(0, 620)

barplot_UK

# Plot these bar plots in one file

tiff("Fig_1_Frequencies_verbs_barplots.tiff", width = 16, height = 8, units = 'in', res = 300)
grid.arrange(barplot_BG, barplot_CR, barplot_SL, barplot_CZ, barplot_PL, barplot_RU, barplot_UK, nrow = 2)
dev.off()