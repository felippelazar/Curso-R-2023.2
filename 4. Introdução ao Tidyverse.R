# ============================================================================ #
# 4. Introdução ao Tidyverse - Select, Filter, Mutate, Rename, Pivot, Join     #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# Working Directory
getwd() # Mostra qual o diretório em uso atualmente
list.files() # Função que lista os arquivos do diretório
setwd("/Users/felippelazarneto/PycharmProjects/Curso-R-2023.2")

# Opening Packages
# https://r4ds.had.co.nz/ (R for Data Science)
library(tidyverse) # Library com os principais pacotes de manipulação em R

# Loading data-frames
dfb <- read.table(file = 'datasets/acmg/acmg_sample_sociodem.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                      stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# %>%  = PIPE
# function(primeiro_arg, segundo_arg, ..._arg)
# %>% o primeiro argumento, será o objeto anterior
str(dfb) # Mostrando a estrutura do data-frame carregado
colnames(dfb) # Mostrando o nome das colunas do data-frame carregado

# 1. Select 
# Função utilizada para selecionar apenas as colunas (mantém apenas elas)
dfb %>%
      select(ID, SEXO, DATA.NASC, IDADE) %>% # Selecionando colunas ID, sexo, data de nascimento e idade
      select(ID, SEXO) # Selecionando então só id e idade

# A função select também pode apenas 'de-selecionar' colunas usando o '-' antes do nome da coluna
dfb %>%
      select(-SEXO, -DATA.NASC) # Todas colunas menos sexo e data de nascimento

# O ':' seleciona todas as colunas entre duas colunas escolhidas
dfb %>%
      select(ID:ANOS.ESCOLA)  # Todas as colunas entre ID e ANOS.ESCOLA

# Existem funções chamadas 'tidy_select' que nos ajudam a selecionar colunas
# Por exemplo, starts_with, ends_with, nos ajudam a selecionar as colunas que começam ou terminam com algum termo
dfb %>%
      select(ID, starts_with('GEO')) # Apenas as colunas que começam com 'GEO' 

# 2. Filter
# A função filter irá selecionar as colunas baseadas em filtros de 'linha'. 
# Os filtros devem usar o condicional para a seleção (BOOLEAN)
dfb %>%
      filter(!IDADE > 65) %>% # Filtrando apenas aquelas pessoas quem a idade é maior que 65 anos
      select(ID, ANOS.ESCOLA) # Selecionando então apenas o ID e a coluna ANOS.ESCOLA

df_baixa_escolaridade <- dfb %>%
      filter(ANOS.ESCOLA == '0-8 anos') # Exclusão dos Faltantes

# Você pode juntar duas ou mais condições booleanas 
# O importante é que a expressão dentro do filter seja um VETOR BOOLEANO
df_baixa_escolaridade2 <- dfb %>%
      filter(ANOS.ESCOLA == '0-8 anos' | is.na(ANOS.ESCOLA)) # Exclusão dos Faltantes

# 3. Mutate
# Mutate é uma das mais importantes funções do tidyverse
# O mutate possibilita a CRIAÇÃO de colunas baseados em novas funções
colnames(dfb)
str(dfb)

df_new <- dfb %>%
      mutate(GEO.CARRO.DISTANCIA.KM = GEO.CARRO.DISTANCIA/1000) %>% # Criando uma nova variável da distância em metros (dividindo por 1000)
      mutate(IDOSO = ifelse(IDADE > 65, 'IDOSO', 'JOVEM')) %>% # Usando a função ifelse para criar uma nova variável
      mutate(GEO.IDH.2010.CAT = case_when( # Usando a função case_when para criar uma nova variável
            GEO.IDH.2010 <= 0.80 ~ '<= 0.80',
            GEO.IDH.2010 > 0.80 & GEO.IDH.2010 < 0.90 ~ '0.80 - 0.90',
            GEO.IDH.2010 >= 0.90 ~ '>= 0.90'
      )) %>%
      mutate(GEO.IDH.2010.CAT = factor(GEO.IDH.2010.CAT, levels = c('<= 0.80', '0.80 - 0.90', '>= 0.90')))  %>%
      filter(IDOSO == 'IDOSO')

table(df_new$GEO.IDH.2010.CAT)
as.numeric(df_new$GEO.IDH.2010.CAT)
# 4. Rename
# A função rename apenas renomeia as colunas do data-frame
# Você consegue renomear utilizando o novo nome da coluna a direita da expressão
dfb %>%
      rename(GENERO = SEXO) %>% # Renomear a coluna sexo para genero
      select(ID, GENERO)

# 5. Join
# Uma das funções mais importantes porque permite integrar duas ou mais data-frames
# left_join = apenas as variáveis da esquerda se mantém obrigatoriamente
# righ_join = apenas as variáveis da direita se mantém obrigatoriamente
# inner_join = apenas as variáveis presentes em ambos (direita e esquerda) se mantém obrigatoriamente
# anti_join = apenas as variáveis da esquerda que não estão a direita se mantém obrigatoriamente
# Carregando a coluna de sinais vitais
df_ssvv <- read.table(file = 'datasets/acmg/acmg_sample_ssvv.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                  stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# Renomeando ID para PAC.ID (deixando diferente a variável chave)
df_ssvv <- df_ssvv %>%
      rename(PAC.ID = ID)

# Juntando a data-frame baseline com sinais vitais pela esquerda (LEFT-JOIN)
df_left_join <- dfb %>%
      left_join(df_ssvv, by = c('ID' = 'PAC.ID'))

df_ssvv_filtered <- df_ssvv %>%
      filter(!is.na(SSVV.PAS))

df_left_join_2 <- dfb %>%
      left_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))

# Juntando a data-frame baseline com sinais vitais pela direita (RIGHT-JOIN)
df_right_join <- dfb %>%
      right_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))
dim(df_right_join)

# Juntando a data-frame baseline com sinais vitais pelas presentes em ambos (INNER-JOIN)
df_inner_join <- dfb %>%
      filter(!is.na(ANOS.ESCOLA)) %>%
      inner_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))

dim(df_inner_join)

# Juntando a data-frame baseline com sinais vitais pelas baseline que não estão na direita (sinais vitais) (OUTER-JOIN)
df_anti_join <- dfb %>%
      filter(!is.na(ANOS.ESCOLA)) %>%
      anti_join(df_ssvv_filtered, by = c('ID' = 'PAC.ID'))

# 6. Pivot Wider and Pivot Longer
# Funções de manipulação para tornar o data-frame mais longo ou mais largo
# Importantes durante a manipulação de data-frames
# Carregando data-frame de laboratoriais
df_lab <- read.table(file = 'datasets/acmg/acmg_sample_lab.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                  stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

dfb_lab <- dfb %>%
      left_join(df_lab)

head(df_lab)

# Transformando os exames laboratoriais em colunas (PIVOT-WIDER)
df_lab_wide <- df_lab %>%
      pivot_wider(id_cols = c('ID'), names_from = 'LAB.NOME', values_from = 'LAB.RESULTADO')

dfb_lab <- dfb %>%
      left_join(df_lab_wide)

str(dfb_lab)

hist(dfb_lab$LAB.HB)

# Carregando data-frame de comorbidades
df_comorb <- read.table(file = 'datasets/acmg/acmg_sample_comorb.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                     stringsAsFactors = FALSE, na.strings = c('', 'NA')) # StringAsFactors = argumento para definir todos strings (character) como fator

# Transformando data-frame de comorbidades no formato longo (PIVOT-LONGER)
df_comorb_long <- df_comorb %>%
      pivot_longer(cols = starts_with('COMORB'),
                   names_to = 'COMORBIDADES.NAME',
                   values_to = 'COMORBIDADES.VALUE') %>%
      filter(COMORBIDADES.VALUE == 1)

table(df_comorb_long$COMORBIDADES.NAME)

