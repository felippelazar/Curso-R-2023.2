# ============================================================================ #
# 1. Introdução ao R, R Studio e Objetos em R  #
# Autor: Felippe Lazar Neto, 2023-2            #
# ============================================================================ #

# R é uma linguagem de programação derivada de uma outra linguagem chamada S
# A base de uma linguagem de programação são objetos e funções. 
# Objetos são unidades de informação criadas durante o ato de programar (a partir do sinal <-)
# As funções funcionam como criadores ou modificadores ou executores de ações a partir de objetos
# As funções possuem argumentos (informações necessárias para realizar determinada ação) - orientações de programar
# As instruções para cada função podem ser acessadas com o '?' antes do nome da função

# Unidades Basicas de Programação - Tipos de Objetos

# Vetores são o objeto mais básico de R - são uma coletânea de componentes de mesmo tipo
# criados a partir da função c()

# 1.1 Vetores Numéricos
x <- c(0, 1, 2, 3, 4)

mode(x)

1:20

seq_meio_a_meio <- seq(from = 1, to = 20, by = 0.5)

seq_meio_a_meio + 1

peso <- seq(from = 60, to = 90, by = 1)
alt <- seq(from = 170, to = 200, by = 1)

peso * alt

x <- 2

# 1.2 Vetores de Caracteres (String)
frutas <- c('banana', 'abacaxi', 'uva')
frutas
mode(frutas)

# 1.3 Vetores Booleanos (Verdadeiro ou Falso)
# TRUE or FALSE
boolean_vec <- c(TRUE, FALSE, TRUE, FALSE)
boolean_vec

boolean_peso_maior70 <- peso > 70
boolean_peso_maior70

sum(boolean_peso_maior70) # numero absoluto de contagem
mean(boolean_peso_maior70) # porcentagem da contagem total 

# 1.4 Vetores de Fator (factor) (variável nominal de R - representação número/caracter)
sexo_amostra_num <- c(0, 1, 1, 1, 0, 1, 0, 1)
sexo_amostra_chr <- c('F', 'M', 'M', 'M', 'F', 'M', 'F', 'M')

mode(sexo_amostra_num)
mode(sexo_amostra_chr)

sexo_amostra_fct <- factor(sexo_amostra_num, levels = c(0, 1), labels = c('F', 'M'))
sexo_amostra_fct <- factor(sexo_amostra_chr, levels = c('F', 'M'))

mode(sexo_amostra_fct)
sexo_amostra_fct

as.numeric(sexo_amostra_chr)
as.numeric(sexo_amostra_fct)
as.factor(sexo_amostra_chr)
as.numeric(as.factor(sexo_amostra_chr))

# 2.1 Matrizes são elementos em array com mais de uma dimensão, com componentes do mesmo tipo
?matrix
matrix_numerico <- matrix(1:20, nrow=5, ncol=4)

# 3.1 Listas são coletâneas, conjuntos de objetos, não necessariamente de mesmo tipo
lista_vars <- list(lista_peso = peso, lista_alt = alt, lista_sexo = sexo_amostra_fct, lista_matrix = matrix_numerico)
lista_vars

lista_vars$lista_peso

# 4.1 Dataframes são conjunto de objetos dispostos em colunas e linhas, não necessariamente do mesmo tipo
?sample
df_mix <- data.frame(nome = sample(c('Joao', 'Maria', 'Gabriel'), 50, replace = TRUE), 
                     altura = sample(alt, 50, replace = TRUE),
                     peso = sample(peso, 50, replace = TRUE))

df_mix

str(df_mix)

df_mix$nome
df_mix$altura
df_mix$peso

df_mix$imc <- df_mix$peso/(df_mix$altura/100*df_mix$altura/100)
df_mix$imc_maior_25 <- df_mix$imc > 25
df_mix$imc_maior_25 <- as.numeric(df_mix$imc > 25)
mean(df_mix$imc_maior_25)
?ifelse
df_mix$sobrepeso_obesidade <- ifelse(df_mix$imc > 25, 'sobrepeso', 'normal')

# Subsetting 
# Vector
alt[5:10]
alt[alt > 197]
alt[1] <- 200
alt

# Lista
lista_vars[['lista_peso']]

# Dataframe
df_mix$peso[df_mix$imc > 25]
# df_mix[ linhas, colunas]
df_mix[1, ]
df_mix[1, 'peso']
df_mix[1, c('nome', 'altura')]

df_mix_maria <- df_mix[df_mix$nome == 'Maria', ]
