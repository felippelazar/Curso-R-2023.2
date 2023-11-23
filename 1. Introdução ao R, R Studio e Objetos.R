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
x <- 2 # Criação de um vetor de único elemento e assinalando o valor dele a x

x <- c(0, 1, 2, 3, 4) # Criação de um vetor número de 1 a 4 simples e assinalando o vetor ao objeto x
mode(x) # Checando qual o tipo de vetor criado

1:20 # Criação de um vetor de 1 a 20 por meio do uso de ':'. Reparem que aqui não assinalei o valor a nenhum objeto. 

seq_meio_a_meio <- seq(from = 1, to = 20, by = 0.5) # Uso de uma função ('seq') para criar um vetor de 1 a 20, de 0.5 a 0.5
seq_meio_a_meio + 1 # Adição do valor de 1 em todos os números do vetor criado (o R realiza contas matemáticas vetorialmente)

peso <- seq(from = 60, to = 90, by = 1) # Criação de um vetor chamado 'peso' de 60 a 90
alt <- seq(from = 170, to = 200, by = 1) # Criação de um vetor chamado 'alt' de 170 a 200

peso * alt # Demonstração de múltiplicação de vetores
peso * (alt/100*alt/100) # Cálculo do IMC por meio da multiplicação de vetores

# 1.2 Vetores de Caracteres (String)
frutas <- c('banana', 'abacaxi', 'uva') # Criação de um vetor de caracteres com nome de frutas ('string')
frutas # Checagem do valor contido no vetor criado
mode(frutas) # Checando qual o tipo de vetor criado (no caso, caracter)

# 1.3 Vetores Booleanos (Verdadeiro ou Falso)
# TRUE or FALSE
boolean_vec <- c(TRUE, FALSE, TRUE, FALSE) # Criando um vetor booleano (logical) de verdadeiro ou falso
boolean_vec # Checando o valor criado

boolean_peso_maior70 <- peso > 70 # Criando um vetor booleano a partir de uma condição de outro vetor (vetor peso)
boolean_peso_maior70

# O fato de o R ler o vetor TRUE como 1 e o FALSE como 0 faz com que ele apresente propriedades interessantes
sum(boolean_peso_maior70) # numero absoluto de contagem
mean(boolean_peso_maior70) # porcentagem da contagem total 

# 1.4 Vetores de Fator (factor) (variável nominal de R - representação número/caracter)
sexo_amostra_num <- c(0, 1, 1, 1, 0, 1, 0, 1) # Criação de vetor númerico 
sexo_amostra_chr <- c('F', 'M', 'M', 'M', 'F', 'M', 'F', 'M') # Criação de vetor caracter

mode(sexo_amostra_num) # Checagem tipo de vetor
mode(sexo_amostra_chr) # Checagem tipo de vetor

sexo_amostra_fct <- factor(sexo_amostra_num, levels = c(0, 1), labels = c('F', 'M')) # Criação de um vetor fator a partir de um vetor num
sexo_amostra_fct <- factor(sexo_amostra_chr, levels = c('F', 'M')) # Criação de um vetor fator a partir de um vetor character

mode(sexo_amostra_fct) # Checando tipo de vetor (! reparem no tipo)
sexo_amostra_fct # Checando variável criada

# Apresentando possibilidade de conversão de vetores por meio de funções (as.*****)
as.numeric(sexo_amostra_chr) # character para número (! reparem que apresenta erro já que é impossível fazer essa conversão)
as.numeric(sexo_amostra_fct) # fator para número (possível, diferentemente do exemplo acima)
as.factor(sexo_amostra_chr) # character para fator (reparem como é similar aos exemplos que fizemos acima)
as.numeric(as.factor(sexo_amostra_chr)) # character para fator para numerico depois (comparem com o primeiro exemplo de conversão)

# 2.1 Matrizes são elementos em array com mais de uma dimensão, com componentes do mesmo tipo
?matrix # Página de ajuda sobre a função matrix
matrix_numerico <- matrix(1:20, nrow=5, ncol=4) # Criação de uma matrix por meio de função

# 3.1 Listas são coletâneas, conjuntos de objetos, não necessariamente de mesmo tipo
lista_vars <- list(lista_peso = peso,  # Criação de uma lista com as variáveis criadas anteriormente (diferentes tipos de vetor)
                   lista_alt = alt, 
                   lista_sexo = sexo_amostra_fct, 
                   lista_matrix = matrix_numerico)

lista_vars # Checando a lista criada

lista_vars$lista_peso # Selecionando o objeto 'lista_peso' dentro da lista criada

# 4.1 Dataframes são conjunto de objetos dispostos em colunas e linhas, não necessariamente do mesmo tipo
?sample # Checando a documentação da função 'sample' (usada para criar aleatoriamente vetores a partir de outros vetores)

# Criando uma dataframe do zero e utilizando vetores existentes
df_mix <- data.frame(nome = sample(c('Joao', 'Maria', 'Gabriel'), 50, replace = TRUE), # Vetor de 50 elementos do vetor de nomes 
                     altura = sample(alt, 50, replace = TRUE), # Vetor de 50 elementos do vetor de altura
                     peso = sample(peso, 50, replace = TRUE)) # Vetor de 50 elementos do vetor de peso

df_mix # Checando o dataframe criado

str(df_mix) # Checando a estrutura das colunas desse dataframe

df_mix$nome # Selecionando a coluna nome
df_mix$altura # Selecionando a coluna altura
df_mix$peso # Selecionando a coluna pusa

df_mix$imc <- df_mix$peso/(df_mix$altura/100*df_mix$altura/100) # Criando uma coluna numerica do IMC
df_mix$imc_maior_25 <- df_mix$imc > 25 # Criando uma coluna booleana a partir de um corte de IMC
df_mix$imc_maior_25 <- as.numeric(df_mix$imc > 25) # Criando a mesma coluna acima porém númerica

mean(df_mix$imc_maior_25) # Exemplo de cálculo de uma estatística de uma coluna (no caso, a média)

?ifelse # Abrindo documentação da função ifelse
df_mix$sobrepeso_obesidade <- ifelse(df_mix$imc > 25, 'sobrepeso', 'normal') # Criando uma coluna a partir da função ifelse

# 2. Subsetting (selecionando a parte de um todo)
# A realização de subsetting se dá principalmente pelo uso de polchetes ('[]')
# Vector
alt[5:10] # Selecionando do quinto ao décimo elemento do vetor alt
alt[alt > 197] # Selecionando todos os elementos que cumprem a condição lógica criada (reparem que é um vetor booleano!)
alt[1] <- 200 # Mudando o valor do elemento posicionado na posição 1 para o valor de '200'

alt # Checando o valor do vetor alt

# Lista
lista_vars[['lista_peso']] # Realizando subsetting de uma lista por meio do nome do objeto
lista_vars[[1]] # Realizando subsetting de uma lista por meio de um número (nesse caso, a ordem de criação importa)

# Dataframe
# df_mix[linhas, colunas] é a estrutura básica de subsetting de dataframes

df_mix[1, ] # Selecionando a primeira linha e todas as colunas (em branco significa todos)
df_mix[1, 'peso'] # Selecionando a primeira linha e a coluna peso
df_mix[1, c('nome', 'altura')] # Selecionando a primeira linha e as colunas nome e altura

df_mix$peso[df_mix$imc > 25] # Selecionando de uma coluna de uma dataframe apenas os que preenchem uma condição

df_mix_maria <- df_mix[df_mix$nome == 'Maria', ] # Selecionando apenas as linhas que preenchem o critério e todas as colunas
