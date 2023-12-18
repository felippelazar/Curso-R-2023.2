# ============================================================================ #
# 4. Introdução ao Tidyverse - Select, Filter, Mutate, Rename, Pivot, Join     #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# Working Directory
getwd()

# Opening Packages
library(tidyverse)

# Loading data-frames
dfb <- read.table(file = 'datasets/acmg/acmg_sample_csv_example.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                      stringsAsFactors = FALSE, na.strings = c('')) # StringAsFactors = argumento para definir todos strings (character) como fator

# 1. Select


# 2. Filter


# 3. Mutate


# 4. Rename


# 5. Join


# 6. Pivot Wider and Pivot Longer


