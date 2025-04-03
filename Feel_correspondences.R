# Upload data and save the frequencies as a matrix
feel <- read.table(file.choose(), header = T, sep = "\t")

mfeel <- as.matrix(feel[1:50, 2:51])
rownames(mfeel) <- feel[, 1]
colnames(mfeel) <- names(feel[,2:51])

# Compute the cosine distances and save them in a matrix with the same row- and column names
library(lsa)

distances <- matrix(nrow = 50, ncol = 50)
rownames(distances) <- feel[, 1]
colnames(distances) <- names(feel[,2:51])

for(i in 1:50) {
  for (j in 1:50) {
    valid_elements <- mfeel[i,] == mfeel[j,]
    valid_elements <- which(valid_elements != "NA")
    distances[i,j] <- 1 - cosine(mfeel[i,][valid_elements], mfeel[j,][valid_elements])
  } }

# fuzzy clustering
install.packages("cluster")  # If not already installed

library(cluster)

fanny_result <- fanny(distances_mod, k = 4, diss = TRUE)

# View membership matrix (words belong to multiple clusters)
print(fanny_result$membership)

# Assign words to the cluster with the highest membership score
word_clusters <- apply(fanny_result$membership, 1, which.max)

# Print word-cluster assignments
data.frame(Word = rownames(distances_mod), Cluster = word_clusters)

# Visualize the distances using MDS
library(smacof)
library(ggplot2)
library(ggrepel)
library(RColorBrewer)

# Define bright, high-contrast colors
bright_colors <- c("#E41A1C", "#377EB8", "#4DAF4A", "#000000")  # Red, Blue, Green, Black

# Perform MDS for 2D visualization
mds_result <- cmdscale(distances_mod, k = 2)  # Convert to 2D

# Create a dataframe for plotting
plot_data <- data.frame(X = mds_result[,1], 
                        Y = mds_result[,2], 
                        Cluster = factor(word_clusters), 
                        Word = rownames(distances_mod))

# Plot the fuzzy clusters
mds_clustering_plot <- ggplot(plot_data, aes(x = X, y = Y, color = Cluster, shape = Cluster, label = Word)) +
  geom_point(size = 3) +
  geom_text_repel(size = 3.5, max.overlaps = 25, box.padding = 0.5) +  # Prevent overlapping labels
  scale_color_manual(values = bright_colors) +  # Apply bright colors to clusters
  theme_minimal() +
  theme(legend.position = "right")  # Place legend on the right

# Plot the upper left corner of the graph
mds_clustering_plot_frag <- ggplot(plot_data, aes(x = X, y = Y, color = Cluster, shape = Cluster, label = Word)) +
  geom_point(size = 3) +
  geom_text_repel(size = 3.5, max.overlaps = 25, box.padding = 0.5) +  # Prevent overlapping labels
  scale_color_manual(values = bright_colors) +  # Apply bright colors to clusters
  theme_minimal() +
  theme(legend.position = "none") +
  ylim(0,0.3) + xlim(-0.35, 0)

tiff("Fig_2_MDS_clustering.tiff", width = 16, height = 8, units = 'in', res = 300)
grid.arrange(mds_clustering_plot, mds_clustering_plot_frag, nrow = 1)
dev.off()
