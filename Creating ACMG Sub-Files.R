# Criação Dados ACMG
df_acmg <- read.table('dfACMGFinal2601.csv', sep = ',', header = T)
set.seed(123)
ids_sample <- sample(df_acmg$ID, 300)
colnames(df_acmg)

# Criando Banco de Dados com todos as variáveis
df_acmg %>%
      filter(ID %in% ids_sample) %>%
      write.table('datasets/acmg/acmg_sample_all_vars.csv', sep = ',', row.names = F)

# Criação Tipos de Arquivos Diferentes
df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, SEXO:GEO.CARRO.TEMPO.COM.TRANSITO) %>%
      select(-GEO.CIDADE.MUNICIPIO, -NATURAL.DE) %>%
      write.table('datasets/acmg/acmg_sample_csv_example.csv', sep = ',', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, SEXO:GEO.CARRO.TEMPO.COM.TRANSITO) %>%
      select(-GEO.CIDADE.MUNICIPIO, -NATURAL.DE) %>%
      write.table('datasets/acmg/acmg_sample_csv2_example.csv', sep = ';', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, SEXO:GEO.CARRO.TEMPO.COM.TRANSITO) %>%
      select(-GEO.CIDADE.MUNICIPIO, -NATURAL.DE) %>%
      write.table('datasets/acmg/acmg_sample_tsv_example.tsv', sep = '\t', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, SEXO:GEO.CARRO.TEMPO.COM.TRANSITO) %>%
      select(-GEO.CIDADE.MUNICIPIO, -NATURAL.DE) %>%
      write.table('datasets/acmg/acmg_sample_txt_example.txt', sep = '|', row.names = F)

# Criação Múltiplos Arquivos
df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, SEXO:GEO.CARRO.TEMPO.COM.TRANSITO) %>%
      select(-GEO.CIDADE.MUNICIPIO, -NATURAL.DE) %>%
      write.table('datasets/acmg/acmg_sample_sociodem.csv', sep = ',', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, starts_with('COMORB')) %>%
      write.table('datasets/acmg/acmg_sample_comorb.csv', sep = ',', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, starts_with('MED')) %>%
      pivot_longer(starts_with('MED'), names_to = 'MED.NOME', values_to = 'MED.RESULTADO') %>%
      filter(MED.RESULTADO == 1) %>%
      select(-MED.RESULTADO) %>%
      write.table('datasets/acmg/acmg_sample_med.csv', sep = ',', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, starts_with('LAB')) %>%
      pivot_longer(starts_with('LAB'), names_to = 'LAB.NOME', values_to = 'LAB.RESULTADO') %>%
      filter(!is.na(LAB.RESULTADO)) %>%
      write.table('datasets/acmg/acmg_sample_lab.csv', sep = ',', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, starts_with('SSVV')) %>%
      write.table('datasets/acmg/acmg_sample_ssvv.csv', sep = ',', row.names = F)

df_acmg %>%
      filter(ID %in% ids_sample) %>%
      select(ID, starts_with('CONS.BIN')) %>%
      write.table('datasets/acmg/acmg_sample_cons_bin.csv', sep = ',', row.names = F)
