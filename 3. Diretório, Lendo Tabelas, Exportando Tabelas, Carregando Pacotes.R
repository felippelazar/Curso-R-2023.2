# ============================================================================ #
# 3. Diretório, Lendo Tabelas, Exportando Tabelas, Carregando Pacotes          #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# 1. Diretórios de Arquivos
getwd()
list.files()

# 2. Instalação de Pacotes em R
install.packages('tidyverse')
install.packages('readxl')

# 3. Leitura de Tabelas
## 3.1 Arquivos CSV (comma-separated values) # CSV = ',' | # CSV2 = ';'
df_csv1 <- read.table(file = 'datasets/acmg/acmg_sample_csv_example.csv', sep = ',', header = TRUE, 
                      stringsAsFactors = FALSE, na.strings = c(''))
?read.table
df_csv2 <- read.table(file = 'datasets/acmg/acmg_sample_csv2_example.csv', sep = ';', header = TRUE)

## 3.2 Arquivos TSV (tab-separated values) # TSV = '\t'
df_tsv <- read.table(file = 'datasets/acmg/acmg_sample_tsv_example.tsv', sep = '\t', header = TRUE)

## 3.3 Arquivos TXT (texto)
df_txt <- read.table(file = 'datasets/acmg/acmg_sample_txt_example.txt', sep = '|', header = TRUE)

## 3.4 Arquivos Excel
library(readxl)
df_excel <- readxl::read_excel(path = 'datasets/acmg/acmg_sample_excel_example.xlsx')
df_excel2 <- read_excel(path = 'datasets/acmg/acmg_sample_excel_example.xlsx')

# 4. Exportação de Tabelas
?write.table
write.table(df_csv1, file = 'datasets/acmg/acmg_export_aula_tres.tsv', sep = '\t')

# 5. Início de Manipulação de Tabelas
df_csv1
head(df_csv1)
tail(df_csv1)
str(df_csv1)

# Correção de Missing Value (importação com especificação)
df_csv1$NACIONALIDADE
table(df_csv1$NACIONALIDADE)
sum(is.na(df_csv1$NACIONALIDADE))
length(c('A', 'B', 'C'))

# Tranformação em Númerico
df_csv1$GEO.CARRO.DISTANCIA <- as.numeric(df_csv1$GEO.TPUBLICO.DISTANCIA)
df_csv1$GEO.TPUBLICO.TEMPO <- as.numeric(df_csv1$GEO.TPUBLICO.TEMPO)

prop_missing <- function(coluna){
      return(sum(is.na(coluna))/length(coluna))
}

prop_missing(df_csv1$GEO.CARRO.DISTANCIA)
dim(df_csv1)
colnames(df_csv1)

for(i in 1:16){
      #print(i)
      print(colnames(df_csv1)[i])
      print(prop_missing(df_csv1[ , i]))
}

lapply(df_csv1, prop_missing)
