# ============================================================================ #
# 2. Operações Lógicas, If-Else, For Loops, Funções e Apply       #
# Autor: Felippe Lazar Neto, 2023-2                                            #
# ============================================================================ #

# O conhecimento da lógica de verdadeiro ou falso permite uma série de ações no R
# Para realizar uma condição, é necessário saber os operadores lógicos que são utilizados no R

# 2.1 Operadores Lógicos
num <- 5 # Assinalando valor de 5 para a variável 'num' que será utilizada após para testar condições

## Comparações de vetores únicos em que o resultado é um vetor único
num > 10 # '>' maior a
num >= 5 # '>=' maior ou igual a
num == 5 # '==' igual a
num != 5 # '!=' diferente de

## Condição de checagem de objeto dentro de um outro vetor
num %in% 1:10 # condição: objeto 'num' está dentro do vetor c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

## Comparações com vetores de > 1 elemento (ou comparador, ou o próprio objeto)
## Resultado será do tamanho do vetor de maior elemento
num > 1:10 # objeto num maior que c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
1:10 > num # c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10) maior que objeto num 
# NOTA: O vetor resultante será sempre do valor do objeto de maior valor nessas comparações mais simples

## Comparações de Condições ('E') ou ('|')
num > 2 & num < 10 # & ('E') - resultado é a combinação das duas condições (ambas devem ser verdadeiras)
num > 2 | num > 10 # | ('OU') - resultado é a combinação de uma ou outra condição (apenas uma precisa ser verdadeira)

## Condição de vetor único para múltiplas comparações (função any ou all)
num > 1:10 # objeto num > 1:10 terá como resultado vetor de 10 elementos
any(num > 1:10)  # condição para checar se pelo menos uma das comparações ('any') é verdadeira
all(num > 1:10)  # condição para checar se todas as condições são verdadeiras ('all')

## Condição Oposta
!c(TRUE) # o sinal '!' inverte o valor booleano 
!(num > 1:10) # o sinal '!' inverte o valor booleano (único ou múltiplo)
!any(num > 1:10) # !any = todos serem falsos (inverso do 'any' que seria pelo menos um verdadeiro)
!all(num > 1:10) # !all = pelo menos um falso

# 2.2 Condição If/Else 
# São condições muito utilizadas para realizar operações de acordo com condicionais
# O formato padrão é: if(condição){operação caso satisfeita}else{operação caso condição não satisfeita}
num <- 10 # assinalando o valor de 10 ao objeto 'num'

if(num == 5){ # Se valor do objeto num for igual a 5, print 'O número é 5', caso contrário, print 'O número não é 5'.
      
  print('O número é 5')
      
}else{
      
  print('O número não é 5')
}

# Pode havar mais de uma condição com o uso do else if. Apenas a primeira condição satisfeita é a realizada (!!)
if(num == 5){
      
  print('O número é 5')
  
}else if(num > 1){
      
  print('O número é maior do que 1')
      
}else{
      
  print('O número não é 5')
  
}

# 2.3 For Looping - Iteração entre elementos de um vetor, lista, ou data-frame (no caso de data-frame, colunas)
obj_um_a_dez <- 1:10 # criação de um vetor único de obj de 1 a 10

# No exemplo a seguir, o for looping vai iterar de 1 a 10 (vetor 1:10) e criar um objeto temporário chamado elemento
# em cada iteração. Ele então irá realizar as ações que estipularmos dentro do looping com o objeto.

for(elemento in obj_um_a_dez){ # Início da iteração de cada um dos elementos de 1 a 10. 
                               # Reparem que precisamos nomear o objeto temporário da iteração (no caso, 'elemento')
      print(elemento) # 1 coisa é printar o valor do elemento
      
      if(elemento < 5){ # Podemos colocar dentro desse 'looping' condições que nos interessem
        
            print('Menor do que 5') # Nesse caso, se o elemento de iteração for mentor que 5, ele print a mensagem 'Menor que 5'
        
      }

}

# Nesse próximo exemplo iremos iterar sobre uma lista de três elementos (três vetores randomicos de 10 elementos)
lista_random <- list(sample(1:100, 10), sample(1:100, 10), sample(1:100, 10)) # criação da lista

# Para cada elemento da lista, assinalaremos o objeto 'elemento_lista' o qual printaremos o valor 
# e printaremos quantos são maior que 20 (a partir da soma do resultado de uma condição)
for(elemento_lista in lista_random){
      print(elemento_lista)
      print(sum(elemento_lista > 20))
}

# No próximo exemplo criaremos uma lista com elementos que correspondem a jogos da mega-sena (6 números, de 1 a 60)
lista_mega_sena <- list() # criando uma lista VAZIA que preencheremos com o código

# Criamos o objeto de iteração no momento do próprio looping
for(i in 1:100){ # o elemento temporário daremos o nome de 'i' (poderia ser qualquer coisa)
      lista_mega_sena[[i]] <- sample(1:60, 6) # para cada número 'i', ele criará uma lista com indexador de número 'i' com um jogo da mega-sena
}

lista_mega_sena # resultado da lista com 100 jogos da mega-sena que criamos

# No próximo exemplo compararemos o valor dos jogos criados com um resultado aleatório
resultado_mega <- sample(1:60, 6) # criação de resultado aleatório único

for(jogos in lista_mega_sena){ # elemento temporário chamado de 'jogos'
      print(sum(jogos %in% resultado_mega)) # comparação de quantos acertos houve nesse jogos comparado ao resultado
      if(sum(jogos %in% resultado_mega) >= 1){ # condição se o jogo havia pelo menos um acerto
            print('Parabéns, você acertou algum dos jogos') # caso >= 1 acerto, print mensagem 'Parabéns, você acertou algum dos jogos'
      }
}

# 2.4 Criação de Funções
# Funções são muito importantes para nos ajudar a determinar certos valores
# O modelo básico de função é: function(argumentos){função propriamente dita a partir dos elementos}
calc_imc <- function(peso, alt){ # função para cálculo do IMC a partir do peso e altura
      imc <- peso/(alt*alt)
      return(imc)
}

imc <- calc_imc(60, 1.65) # cálculo do IMC de um peso de 60kg e altura de 1,65m
peso <- sample(50:90, 10) # criação de pesos aleatórios
alt <- sample(150:200, 10)/100 # criação de alturas aleatórias

calc_imc(peso, alt) # cálculo de elemento IMC com dez números (a partir de 10 pesos e 10 alturas)

# 2.5 Funções do Grupo 'Apply' (sapply e lapply)
# Funções mais avanaçadas, que basicamente são 'for' looping de maneira simplificada
df_peso_alt <- as.data.frame(cbind(peso, alt)) # Criação de um dataframe basico com peso e altura (duas colunas)
class(cbind(peso, alt)) # Checagem do tipo ('dataframe')

obj_lapply <- lapply(df_peso_alt, mean) # média para cada coluna de um data-frame (for looping for coluna) - resultado em lista (!!)
obj_sapply <- sapply(df_peso_alt, mean) # mesmo resultado anterior, só que em vetor (e não lista)
class(obj_lapply) # classe do objeto - lista
class(obj_sapply) # classe do objeto - vetor

# Exemplo da facilidade do for looping e apply
# Exemplo com for looping
for(i in 1:100){
      lista_mega_sena[[i]] <- sample(1:60, 6)
}
# Exemplo com apply
# IMPORTANTE: reparem que defini (criei) uma função dentro do próprio apply por meio de: function(x){}
# Reparem também coloquei um argumento x na função que não utilizei para nada (o resultado da função não depende de X)
# Isso foi utilizado para criar um processo de iteração parecido com o anterior. 
lapply(1:100, function(x) sample(1:60, 6))

