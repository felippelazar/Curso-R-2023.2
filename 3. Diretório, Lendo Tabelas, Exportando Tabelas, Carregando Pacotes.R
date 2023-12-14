# ============================================================================ #
# 3. Diretório, Lendo Tabelas, Exportando Tabelas, Carregando Pacotes          #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# 1. Diretórios de Arquivos
getwd() # Função para indicar onde qual é o diretório que estamos trabalhando
list.files() # Listagem de arquivos do diretório
setwd(path = '') # Função para mudar o diretório de trabalho

# 2. Instalação de Pacotes em R
install.packages('tidyverse') # função de instalação de pacotes, no caso o tidyverse
install.packages('readxl') # função para instalação de pacotes - no caso o readxl

# 3. Leitura de Tabelas
## 3.1 Arquivos CSV (comma-separated values) # CSV = ',' | # CSV2 = ';'
df_csv1 <- read.table(file = 'datasets/acmg/acmg_sample_csv_example.csv', sep = ',', header = TRUE,  # Header = Se a 1L são os nomes das colunas
                      stringsAsFactors = FALSE, na.strings = c('')) # StringAsFactors = argumento para definir todos strings (character) como fator
?read.table # checar argumentos da função

df_csv2 <- read.table(file = 'datasets/acmg/acmg_sample_csv2_example.csv', sep = ';', header = TRUE)

## 3.2 Arquivos TSV (tab-separated values) # TSV = '\t'
df_tsv <- read.table(file = 'datasets/acmg/acmg_sample_tsv_example.tsv', sep = '\t', header = TRUE)

## 3.3 Arquivos TXT (texto) # Exemplo para demonstrar que qualquer separador pode ser usado! No caso '|'
df_txt <- read.table(file = 'datasets/acmg/acmg_sample_txt_example.txt', sep = '|', header = TRUE)

## 3.4 Arquivos Excel - O R não tem como ler excel de maneira habitual, precisa de pacotes extras.
library(readxl)
df_excel <- readxl::read_excel(path = 'datasets/acmg/acmg_sample_excel_example.xlsx') 
df_excel2 <- read_excel(path = 'datasets/acmg/acmg_sample_excel_example.xlsx') # Se voce carregar a 'library' com a função acima, não precisa colocar o nome do pacote antes

# 4. Exportação de Tabelas
?write.table # Exportação de tabela segue a mesma lógica da leitura, veja os argumentos
write.table(df_csv1, file = 'datasets/acmg/acmg_export_aula_tres.tsv', sep = '\t')

# 5. Início de Manipulação de Tabelas
df_csv1
head(df_csv1) # Primerias linhas do dataset
tail(df_csv1) # Últimas linhas do dataset
str(df_csv1) # Estrutura do dataset (colunas e tipo de colunas)
dim(df_csv1) # Número de linhas e colunas

# Correção de Missing Value (importação com especificação)
df_csv1$NACIONALIDADE # Nacionalidade vem com campos em '' porém sem NA (missing) se você não especificar na leitura que '' é NA (nastrings)
table(df_csv1$NACIONALIDADE) # Checando informação acima
sum(is.na(df_csv1$NACIONALIDADE)) # Contando quantos NA
length(c('A', 'B', 'C')) # Contando número de elementos de um vetor - função lenght

# Tranformação em Númerico
df_csv1$GEO.CARRO.DISTANCIA <- as.numeric(df_csv1$GEO.TPUBLICO.DISTANCIA) # Transformação númerico de uma coluna
df_csv1$GEO.TPUBLICO.TEMPO <- as.numeric(df_csv1$GEO.TPUBLICO.TEMPO) # Transformação número de uma coluna

prop_missing <- function(coluna){ # Criação de uma função para checar quantos NA (missing) existem
      return(sum(is.na(coluna))/length(coluna))
}

prop_missing(df_csv1$GEO.CARRO.DISTANCIA) # Exemplo com uma coluna só

colnames(df_csv1) # Nomes dsa colunas

for(i in 1:16){ # Criando um looping para checar a proporção de missing por coluna
      #print(i)
      print(colnames(df_csv1)[i])
      print(prop_missing(df_csv1[ , i]))
}

lapply(df_csv1, prop_missing) # Mesma coisa que o looping, porém com apenas uma função (lapply)
