# ============================================================================ #
# 5. Group_by, Summarise e Introdução a gráficos em R (ggplot2)                #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# Carrengado tidyverse
library(tidyverse)

# Carregando data-frame
dfb <- read.table(file = 'datasets/acmg/acmg_sample_sociodem.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                  stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# Carregando exames laboratoriais
df_lab <- read.table(file = 'datasets/acmg/acmg_sample_lab.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                     stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# Carregando sinais vitais
df_ssvv <- read.table(file = 'datasets/acmg/acmg_sample_ssvv.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                      stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# Juntando as três data-frames

# 1. Group By e Summarise - Computação de novas variáveis por grupos


# 2. Introdução ao ggplot2
# Instalando e carregando a library
install.packages('ggplot2')
library(ggplot2)

# O ggplot2 (grammar of graphics) pacote se baseia em CAMADAS para representação gráfica
# Cada camada gráfica vai fornecer uma informação nova sobre o gráfico adicionando sobre
# a camada anterior as informações

# 2.1 Histogramas

# 2.2 Barras

# 2.3 Scatter Plot

# 2.4 Adicionado complexidade ao gráficos


