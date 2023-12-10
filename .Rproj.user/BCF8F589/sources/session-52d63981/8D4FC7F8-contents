# ============================================================================ #
# 2. Operações Lógicas, If-Else, For Loops, While Loops, Funções e Apply       #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# O conhecimento da lógica de verdadeiro ou falso permite uma série de ações no R
# Para realizar uma condição, é necessário saber os operadores lógicos que são utilizados no R

# 2.1 Operadores Lógicos
num <- 5

# Vetores Unicos
num > 10
num >= 5
num == 5
num != 5

# Condição de Objeto E dentro de Objeto D
num %in% 1:10

# Vetores com > 1 elemento
num > 1:10
1:10 > num

# Comparando mais de uma condição
num > 2 & num < 10 # & ('E')
num > 2 | num > 10 # | ('OU')

# Condição Oposta
!(num > 1:10) # ! = Oposto da Condições que foi Realizada

# Funções All ou Any
num > 1:10
any(num > 1:10) 
all(num > 1:10) 
!any(num > 1:10) # !any = todos serem falsos
!all(num > 1:10) # !all = any (qualquer um verdadeiro)

# 2.2 Condição If/Else
num
num <- 10
if(num == 5){ # Condição de resultado único (vetor de único elemento)
      
      print('O número é 5')
      
}else{
      print('O número não é 5')
      
}

if(num == 5){
      
      print('O número é 5')
      
}else if(num > 1){
      
      print('O número é maior do que 1')
      
}else{
      
      print('O número não é 5')
      
}

# 2.3 For Looping - Iteração
obj_um_a_dez <- 1:10

for(elemento in obj_um_a_dez){
      print(elemento) # 1 coisa é printar o valor do elemento
      
      if(elemento < 5){
            print('Menor do que 5')
      }

}

lista_random <- list(sample(1:100, 10), sample(1:100, 10), sample(1:100, 10))

for(elemento_lista in lista_random){
      print(elemento_lista)
      print(sum(elemento_lista > 20))
}

# Criar uma Lista
lista_mega_sena <- list()

# Iteração para Criar um Objeto
for(i in 1:100){
      lista_mega_sena[[i]] <- sample(1:60, 6)
}

lista_mega_sena

resultado_mega <- sample(1:60, 6)

for(jogos in lista_mega_sena){
      print(sum(jogos %in% resultado_mega))
      if(sum(jogos %in% resultado_mega) >= 1){
            print('Parabéns, você acertou algum dos jogos')
      }
}

# 2.4 Criação de Funções
calc_imc <- function(peso, alt){
      imc <- peso/(alt*alt)
      return(imc)
}

imc <- calc_imc(60, 1.65)
peso <- sample(50:90, 10)
alt <- sample(150:200, 10)/100

calc_imc(peso, alt)

# 2.5 Funções do Grupo 'Apply' (sapply e lapply)
df_peso_alt <- as.data.frame(cbind(peso, alt))
class(cbind(peso, alt))

obj_lapply <- lapply(df_peso_alt, mean)
obj_sapply <- sapply(df_peso_alt, mean)
class(obj_lapply)
class(obj_sapply)

for(i in 1:100){
      lista_mega_sena[[i]] <- sample(1:60, 6)
}

lapply(1:100, function(x) sample(1:60, 6))

