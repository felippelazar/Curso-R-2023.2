# ============================================================================ #
# 4. Introdução ao Tidyverse - Select, Filter, Mutate, Rename, Pivot, Join     #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# Working Directory
getwd()
list.files()
setwd("/Users/felippelazarneto/PycharmProjects/Curso-R-2023.2")

# Opening Packages
# https://r4ds.had.co.nz/ (R for Data Science)
library(tidyverse)

# Loading data-frames
dfb <- read.table(file = 'datasets/acmg/acmg_sample_sociodem.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                      stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# %>%  = PIPE
# function(primeiro_arg, segundo_arg, ..._arg)
# %>% o primeiro argumento, será o objeto anterior
str(dfb)
colnames(dfb)
# 1. Select
dfb %>%
      select(ID, SEXO, DATA.NASC, IDADE) %>%
      select(ID, SEXO)

# select(dfb, ID, SEXO, DATA.NASC, IDADE)

dfb %>%
      select(-SEXO, -DATA.NASC)

dfb %>%
      select(ID:ANOS.ESCOLA)

dfb %>%
      select(ID, starts_with('GEO'))

# 2. Filter
dfb %>%
      filter(!IDADE > 65) %>%
      select(ID, ANOS.ESCOLA)

df_baixa_escolaridade <- dfb %>%
      filter(ANOS.ESCOLA == '0-8 anos') # Exclusão dos Faltantes

df_baixa_escolaridade2 <- dfb %>%
      filter(ANOS.ESCOLA == '0-8 anos' | is.na(ANOS.ESCOLA)) # Exclusão dos Faltantes

# 3. Mutate
colnames(dfb)
str(dfb)

df_new <- dfb %>%
      mutate(GEO.CARRO.DISTANCIA.KM = GEO.CARRO.DISTANCIA/1000) %>%
      mutate(IDOSO = ifelse(IDADE > 65, 'IDOSO', 'JOVEM')) %>%
      mutate(GEO.IDH.2010.CAT = case_when(
            GEO.IDH.2010 <= 0.80 ~ '<= 0.80',
            GEO.IDH.2010 > 0.80 & GEO.IDH.2010 < 0.90 ~ '0.80 - 0.90',
            GEO.IDH.2010 >= 0.90 ~ '>= 0.90'
      )) %>%
      mutate(GEO.IDH.2010.CAT = factor(GEO.IDH.2010.CAT, levels = c('<= 0.80', '0.80 - 0.90', '>= 0.90')))  %>%
      filter(IDOSO == 'IDOSO')

table(df_new$GEO.IDH.2010.CAT)
as.numeric(df_new$GEO.IDH.2010.CAT)
# 4. Rename
dfb %>%
      rename(GENERO = SEXO) %>%
      select(ID, GENERO)

# 5. Join
df_ssvv <- read.table(file = 'datasets/acmg/acmg_sample_ssvv.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                  stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

df_ssvv <- df_ssvv %>%
      rename(PAC.ID = ID)

df_left_join <- dfb %>%
      left_join(df_ssvv, by = c('ID' = 'PAC.ID'))

df_ssvv_filtered <- df_ssvv %>%
      filter(!is.na(SSVV.PAS))

df_left_join_2 <- dfb %>%
      left_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))

df_right_join <- dfb %>%
      right_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))
dim(df_right_join)

df_inner_join <- dfb %>%
      filter(!is.na(ANOS.ESCOLA)) %>%
      inner_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))

dim(df_inner_join)

df_anti_join <- dfb %>%
      filter(!is.na(ANOS.ESCOLA)) %>%
      anti_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))

# 6. Pivot Wider and Pivot Longer
df_lab <- read.table(file = 'datasets/acmg/acmg_sample_lab.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                  stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

dfb_lab <- dfb %>%
      left_join(df_lab)

head(df_lab)

df_lab_wide <- df_lab %>%
      pivot_wider(id_cols = c('ID'), names_from = 'LAB.NOME', values_from = 'LAB.RESULTADO')

dfb_lab <- dfb %>%
      left_join(df_lab_wide)

str(dfb_lab)

hist(dfb_lab$LAB.HB)

df_comorb <- read.table(file = 'datasets/acmg/acmg_sample_comorb.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                     stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

df_comorb_long <- df_comorb %>%
      pivot_longer(cols = starts_with('COMORB'),
                   names_to = 'COMORBIDADES.NAME',
                   values_to = 'COMORBIDADES.VALUE') %>%
      filter(COMORBIDADES.VALUE == 1)

table(df_comorb_long$COMORBIDADES.NAME)

