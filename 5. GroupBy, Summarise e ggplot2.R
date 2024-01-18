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

df_lab_wide <- df_lab %>%
      pivot_wider(id_cols = c('ID'), names_from = 'LAB.NOME', values_from = 'LAB.RESULTADO')

# Carregando sinais vitais
df_ssvv <- read.table(file = 'datasets/acmg/acmg_sample_ssvv.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                      stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# Carregando Comorbidades
df_comorb <- read.table(file = 'datasets/acmg/acmg_sample_comorb.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                        stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# Juntando as três data-frames
df_all <- dfb %>%
      left_join(df_ssvv) %>%
      left_join(df_lab_wide) %>%
      left_join(df_comorb)
      
# 1. Group By e Summarise - Computação de novas variáveis por grupos
# group_by
# summarise
df_all %>%
      group_by(SEXO) %>%
      summarise(num_obs = n(), idade_media = mean(IDADE), glicada_media = mean(LAB.HB.GLICADA, na.rm = TRUE))

df_all %>%
      group_by(SEXO, COMORB.DIABETES2) %>%
      summarise(num_obs = n(), idade_media = mean(IDADE), glicada_media = mean(LAB.HB.GLICADA, na.rm = TRUE))

df_all %>%
      group_by(SEXO, COMORB.DIABETES2) %>%
      summarise(min_glicada = min(LAB.HB.GLICADA, na.rm = TRUE), 
                max_glicada = max(LAB.HB.GLICADA, na.rm = TRUE),
                median_glicada = median(LAB.HB.GLICADA, na.rm = TRUE), 
                mean_glicada = mean(LAB.HB.GLICADA, na.rm = TRUE))

df_all %>%
      group_by(SEXO) %>%
      mutate(idade_media = mean(IDADE)) %>%
      select(ID, SEXO, idade_media) %>%
      ungroup()

mean(df_all$LAB.HB.GLICADA)
?mean
# 2. Introdução ao ggplot2
# Instalando e carregando a library
install.packages('ggplot2')
library(ggplot2)

# O ggplot2 (grammar of graphics) pacote se baseia em CAMADAS para representação gráfica
# Cada camada gráfica vai fornecer uma informação nova sobre o gráfico adicionando sobre
# a camada anterior as informações

# Tipos de Informação que São Mapeáveis
# Eixo X
# Eixo Y
# Cor (contorno) - color
# Cor (preenchimento) - fill
# Shape (Forma)

# 2.1 Histogramas
ggplot(data = df_all, aes(x = LAB.HB.GLICADA, color = as.factor(COMORB.DIABETES2))) + 
      geom_density()

# 2.2 Barras
df_temp <- df_all %>%
      group_by(SEXO, COMORB.HAS, COMORB.DIABETES2) %>%
      summarise(min_glicada = min(LAB.HB.GLICADA, na.rm = TRUE), 
                max_glicada = max(LAB.HB.GLICADA, na.rm = TRUE),
                median_glicada = median(LAB.HB.GLICADA, na.rm = TRUE), 
                mean_glicada = mean(LAB.HB.GLICADA, na.rm = TRUE))

# Faceting
ggplot(data = df_temp, aes(x = as.factor(COMORB.DIABETES2), y = mean_glicada, fill = as.factor(COMORB.DIABETES2))) + 
      geom_col(color = 'black') +
      labs(x = 'Diabetes', y = 'Média Hb Glicada') +
      facet_wrap(COMORB.HAS~SEXO) +
      theme_bw() + theme(legend.position = 'top')

# 2.3 Scatter Plot
ggplot(data = df_all, aes(x = GEO.CARRO.DISTANCIA, y = GEO.IDH.2010, color = RACA,
                          size = IDADE, shape = SEXO)) +
      geom_point(alpha = 0.6) +
      xlim(c(0, 20000)) +
      facet_wrap(COMORB.HAS~.) + 
      labs(x = 'Distancia Carro (m)', y = 'IDH 2010', color = 'Raça',
           shape = 'Sexo', size = 'Idade')

# 2.4 Adicionado complexidade ao gráficos

colnames(df_all)
