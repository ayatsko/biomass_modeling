x <- read.csv("/Volumes/BAMspace/6_staff_folders/Abbey/multiscale_lidar_ms/output_files/others/RE_clipped.csv")
unique(x$RE1)

# sum SHAPE_area of each unique RE1
x$RE1 <- as.factor(x$RE1)
x %>% group_by(RE1) %>% summarise(sum_area = sum(SHAPE_Area)) -> RE_sum_area

# plot RE1 vs sum_area
ggplot(RE_sum_area, aes(x = reorder(RE1, -sum_area), y = sum_area)) + 
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

wd <- read.csv("/Volumes/BAMspace/6_staff_folders/Abbey/multiscale_lidar_ms/output_files/others/RE_species_WD.csv")

wd %>% select(RE1, avg_wd) -> out

left_join(x, out, by = "RE1") -> test

write.csv(test, "/Volumes/BAMspace/6_staff_folders/Abbey/multiscale_lidar_ms/output_files/others/RE_clipped_wd_added.csv", row.names = FALSE)
