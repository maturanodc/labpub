rm(list = ls())
gc()

library(boot)
library(dplyr)
library(data.table)
library(tictoc)
library(haven)
library(questionr)     
library(tidyverse)
library(data.table)
library(ggplot2)
library(ggthemes)
library(cowplot)
library(Hmisc)
library(questionr)
library(stargazer)
library(ggpubr)
library(summarytools)
library(kableExtra)
library(psych)
library(survey)
library('FinCal')
library(readr)
library(xlsx)

setwd("C:/Users/Dimitri/Desktop/mvpf_ESF")
set.seed(12345)


# Tratamento do censo

dicio_p <- readr::fwf_positions(
  start     = c(1,3,8,21,29,45,46,48,51,53,54,56,58,59,62,65,67,68,69,70,71,72,73,74,75,76,77,81,82,89,96,99,102,103,110,117,124,125,132,139,146,147,148,150,152,153,154,156,157,158,159,162,165,168,169,176,183,190,191,193,194,195,196,197,198,199,200,204,209,210,211,212,213,219,225,231,232,238,247,254,263,270,279,286,296,304,313,316,317,318,319,320,321,322,328,329,336,343,350,351,352,353,355,357,359,360,362,364,366,367,370,371,372,373,375,379,380,382,384,386,388,389,391,392,393,394,395,396,399,400,402,404,406,414,423,427,432,433,434,435,436,437,438,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540),
  end       = c(2,7,20,28,44,45,47,50,52,53,55,57,58,61,64,66,67,68,69,70,71,72,73,74,75,76,80,81,88,95,98,101,102,109,116,123,124,131,138,145,146,147,149,151,152,153,155,156,157,158,161,164,167,168,175,182,189,190,192,193,194,195,196,197,198,199,203,208,209,210,211,212,218,224,230,231,237,246,253,262,269,278,285,295,303,312,315,316,317,318,319,320,321,327,328,335,342,349,350,351,352,354,356,358,359,361,363,365,366,369,370,371,372,374,378,379,381,383,385,387,388,390,391,392,393,394,395,398,399,401,403,405,413,422,426,431,432,433,434,435,436,437,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540),
  col_names = c("V0001","V0002","V0011","V0300","V0010","V1001","V1002","V1003","V1004","V1006","V0502","V0504","V0601","V6033","V6036","V6037","V6040","V0606","V0613","V0614","V0615","V0616","V0617","V0618","V0619","V0620","V0621","V0622","V6222","V6224","V0623","V0624","V0625","V6252","V6254","V6256","V0626","V6262","V6264","V6266","V0627","V0628","V0629","V0630","V0631","V0632","V0633","V0634","V0635","V6400","V6352","V6354","V6356","V0636","V6362","V6364","V6366","V0637","V0638","V0639","V0640","V0641","V0642","V0643","V0644","V0645","V6461","V6471","V0648","V0649","V0650","V0651","V6511","V6513","V6514","V0652","V6521","V6524","V6525","V6526","V6527","V6528","V6529","V6530","V6531","V6532","V0653","V0654","V0655","V0656","V0657","V0658","V0659","V6591","V0660","V6602","V6604","V6606","V0661","V0662","V0663","V6631","V6632","V6633","V0664","V6641","V6642","V6643","V0665","V6660","V6664","V0667","V0668","V6681","V6682","V0669","V6691","V6692","V6693","V6800","V0670","V0671","V6900","V6910","V6920","V6930","V6940","V6121","V0604","V0605","V5020","V5060","V5070","V5080","V6462","V6472","V5110","V5120","V5030","V5040","V5090","V5100","V5130","M0502","M0601","M6033","M0606","M0613","M0614","M0615","M0616","M0617","M0618","M0619","M0620","M0621","M0622","M6222","M6224","M0623","M0624","M0625","M6252","M6254","M6256","M0626","M6262","M6264","M6266","M0627","M0628","M0629","M0630","M0631","M0632","M0633","M0634","M0635","M6352","M6354","M6356","M0636","M6362","M6364","M6366","M0637","M0638","M0639","M0640","M0641","M0642","M0643","M0644","M0645","M6461","M6471","M0648","M0649","M0650","M0651","M6511","M0652","M6521","M0653","M0654","M0655","M0656","M0657","M0658","M0659","M6591","M0660","M6602","M6604","M6606","M0661","M0662","M0663","M6631","M6632","M6633","M0664","M6641","M6642","M6643","M0665","M6660","M0667","M0668","M6681","M6682","M0669","M6691","M6692","M6693","M0670","M0671","M6800","M6121","M0604","M0605","M6462","M6472","V1005")
)
numlist <- list("11","12","13","14","15","16","17","21","22","23","24","25","26","27","28","29","31","32","33","35_RMSP","35_outras","41","42","43","50","51","52","53")

for(i in numlist){
  
  name <- readr::read_fwf(
    paste("censo/Amostra_Pessoas_",i,".txt", sep = ""),
    col_positions = dicio_p
  ) %>% mutate(
    codmun7 = as.numeric(paste(as.character(V0001),V0002,sep = "")),
    rendi_dom_pc = as.numeric(V6531) / 100,
    reg_N_NE = ifelse(floor(V0001/10) == 1 | floor(V0001/10) == 2, 1,0),
    peso = as.numeric(V0010),
    fx.etaria_1 = ifelse(as.numeric(V6036) < 1, 1, 0),
    fx.etaria_2 = ifelse(as.numeric(V6036) >= 1 & as.numeric(V6036) < 4, 1, 0),
    fx.etaria_3 = ifelse(as.numeric(V6036) >= 15 & as.numeric(V6036) < 59, 1, 0),
    fx.etaria_4 = ifelse(as.numeric(V6036) >= 59, 1, 0)
  ) %>% select(
    codmun7,
    uf = V0001,
    reg_N_NE,
    rendi_dom_pc,
    fx.etaria_1,
    fx.etaria_2,
    fx.etaria_3,
    fx.etaria_4,
    peso
  )
  
  assign(paste("df",i,sep=""),name)
  
}

df <- bind_rows(
  df11, df12, df13, df14, df15, df16, df17,df21, df22, df23, df24, df25, df26, df27, df28, df29,df31, df32, df33, df35_outras, df35_RMSP,df41, df42, df43, df50, df51, df52, df53
) %>% mutate(
  beneficiario = ifelse(
    rendi_dom_pc <= npreg::wtd.quantile(
      rendi_dom_pc,
      weights = peso,
      probs = .5131,
      na.rm = TRUE
    ) , 1 , 0
  )
)

frac_N_NE <- weighted.mean(df$reg_N_NE, df$peso, na.rm = TRUE)  # Fracao de habitantes do norte e nordeste
frac_0a1 <- weighted.mean(df$fx.etaria_1, df$peso, na.rm = TRUE) # Fracao de pessoas entre 0|-1 anos de idade
frac_1a4 <- weighted.mean(df$fx.etaria_2, df$peso, na.rm = TRUE) # Fracao de pessoas entre 1|-4 anos de idade
frac_15a59 <- weighted.mean(df$fx.etaria_3, df$peso, na.rm = TRUE) # Fracao de pessoas entre 15|-59 anos de idade
frac_59mais <- weighted.mean(df$fx.etaria_4, df$peso, na.rm = TRUE) # Fracao de pessoas 59+ anos de idade
rend_benef <- weighted.mean(
  subset(df,beneficiario == 1)$rendi_dom_pc,
  subset(df,beneficiario == 1)$peso,
  na.rm = TRUE
) # Renda media de beneficiarios do ESF

alq_trib <- 0.22  # Aliquota tributaria de beneficiarios
ret_ed <- 0.17  # Retorno da educação para beneficiarios
delta <- 0.03 # Taxa de desconto intertemporal aa
vsl <- 3294000  # Valor Estatistico da vida
cobertura <- 98270806  # Estimativa de brasileiros cobertos
equipes <- 31107  # Numero de equipes atuantes
custo_eq <- 58411 # Custo mensal por equipe
custo <- equipes * custo_eq * 12 / cobertura # Custo anual / beneficiario

censo <- df

rm(df, df11, df12, df13, df14, df15, df16, df17, df21, df22, df23,
   df24, df25, df26, df27, df28, df29, df31, df32, df33, df35_outras,
   df35_RMSP, df41, df42, df43, df50, df51, df52, df53, dicio_p,
   name, numlist, i)

# Montagem de dataframe de impactos

mort_0a1 <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 3:11, colIndex = 1:3) %>% 
  rename(est_0a1 = Estimativa, ep_0a1 = Erro.padrão)
mort_1a4 <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 3:11, colIndex = 5:6) %>% 
  rename(est_1a4 = Estimativa, ep_1a4 = Erro.padrão)
mort_15a59 <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 3:11, colIndex = 8:9) %>% 
  rename(est_15a59 = Estimativa, ep_15a59 = Erro.padrão)
mort_59mais <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 3:11, colIndex = 11:12) %>% 
  rename(est_59mais = Estimativa, ep_59mais = Erro.padrão)
mortalidade <- cbind(mort_0a1, mort_1a4,mort_15a59,mort_59mais)

crowdout <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 14:27, colIndex = 1:3) %>% 
  rename(est_crowdout = Estimativa, ep_crowdout = Erro.padrão)

matricula <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 30:38, colIndex = 1:3) %>% 
  rename(est_matricula = Estimativa, ep_matricula = Erro.Padrão)

oferta <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 42:50, colIndex = 1:3) %>% 
  rename(est_oferta = Estimativa, ep_oferta = Erro.Padrão)

emprego <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 42:50, colIndex = c(1,5:6)) %>% 
  rename(est_emprego = Estimativa, ep_emprego = Erro.Padrão)

natalidade <- read.xlsx("ESF_v2.xlsx", "Dados", rowIndex = 53:61, colIndex = 1:3) %>% 
  rename(est_natalidade = Estimativa, ep_natalidade = Erro.Padrão)

df <- merge(mortalidade, crowdout, by = "t")
df <- merge(df, emprego, by = "t")
df <- merge(df, matricula, by = "t")
df <- merge(df, natalidade, by = "t")
df <- merge(df, oferta, by = "t")

rm(crowdout,emprego,matricula,mortalidade,natalidade,oferta,mort_0a1,mort_1a4,mort_15a59,mort_59mais)

# Montagem da funcao MVPF para o ESF. Admite como argumentos:

mvpf <- function(
    mort0a1,      # Um vetor de impactos sobre mortalidade 0 a 1 ano
    mort1a4,      # Um vetor de impactos sobre mortalidade 1 a 4 anos
    mort15a59,    # Um vetor de impactos sobre mortalidade 15 a 59 anos
    mort59mais,   # Um vetor de impactos sobre mortalidade 59+ anos
    crowdout,     # Um vetor de impactos sobre crowding out da cobertura de saude privada
    emprego,      # Um vetor de impactos sobre emprego
    matricula     # Um vetor de impactos sobre matricula escolar
) {
  
  WTP <- 0
  Costs <- 0
  
  for (t in 1:8) {      # Para calcular o MVPF para um período mais longo,
                        # completar as estimativas para outros períodos
                        # em df e aumentar o período de análise nas 
                        # linhas 179, 210, e 245
    
    WTP <- WTP + assign(paste("wtp",t,sep = "_"),
           ( (- (  mort0a1[t] * frac_0a1 +
                   mort1a4[t] * frac_1a4 + 
                   mort15a59[t] * frac_15a59 +
                   mort59mais[t] * frac_59mais) * vsl / 1000 ) -
               crowdout[t] * custo +
               emprego[t] * rend_benef * frac_N_NE * (1 - alq_trib) +
               matricula[t] * rend_benef * frac_N_NE * (1 - alq_trib) * ret_ed
           ) / (1 + delta)^t
    )
    
    Costs <- Costs + assign(paste("cst",t,sep = "_"),
           (custo - emprego[t] * rend_benef * frac_N_NE * alq_trib -
              matricula[t] * rend_benef * frac_N_NE * alq_trib * ret_ed
           ) / (1 + delta)^t
    )
    
  }
  
  return(
    WTP / Costs
  )
  
}

# Estimativa de ponto
for (t in 1:8) {
  
  x <- df[t,2]; assign(paste("v1",t,sep="_"),x)
  x <- df[t,4]; assign(paste("v2",t,sep="_"),x)
  x <- df[t,6]; assign(paste("v3",t,sep="_"),x)
  x <- df[t,8]; assign(paste("v4",t,sep="_"),x)
  x <- df[t,10]; assign(paste("c",t,sep="_"),x)
  x <- df[t,12]; assign(paste("e",t,sep="_"),x)
  x <- df[t,14]; assign(paste("m",t,sep="_"),x)
  
  rm(x,t)
}

mort0a1 <- c(v1_1, v1_2, v1_3, v1_4, v1_5, v1_6, v1_7, v1_8)
mort1a4 <- c(v2_1, v2_2, v2_3, v2_4, v2_5, v2_6, v2_7, v2_8)
mort15a59 <- c(v3_1, v3_2, v3_3, v3_4, v3_5, v3_6, v3_7, v3_8)
mort59mais <- c(v4_1, v4_2, v4_3, v4_4, v4_5, v4_6, v4_7, v4_8)
crowdout <- c(c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8)
emprego <- c(e_1, e_2, e_3, e_4, e_5, e_6, e_7, e_8)
matricula <- c(m_1, m_2, m_3, m_4, m_5, m_6, m_7, m_8)

rm(v1_1, v1_2, v1_3, v1_4, v1_5, v1_6, v1_7, v1_8,
v2_1, v2_2, v2_3, v2_4, v2_5, v2_6, v2_7, v2_8,
v3_1, v3_2, v3_3, v3_4, v3_5, v3_6, v3_7, v3_8,
v4_1, v4_2, v4_3, v4_4, v4_5, v4_6, v4_7, v4_8,
c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8,
e_1, e_2, e_3, e_4, e_5, e_6, e_7, e_8,
m_1, m_2, m_3, m_4, m_5, m_6, m_7, m_8)
  
mvpf(mort0a1, mort1a4, mort15a59, mort59mais, crowdout, emprego, matricula)

# CI por bootstrapping

resultado <- list()

for (i in 1:1000) {

for (t in 1:8) {
  
  x <- rnorm(1, df[t,2], df[t,3]) ; assign(paste("v1",t,sep="_"),x)
  x <- rnorm(1, df[t,4], df[t,5]) ; assign(paste("v2",t,sep="_"),x)
  x <- rnorm(1, df[t,6], df[t,7]) ; assign(paste("v3",t,sep="_"),x)
  x <- rnorm(1, df[t,8], df[t,9]) ; assign(paste("v4",t,sep="_"),x)
  x <- rnorm(1, df[t,10], df[t,11]); assign(paste("c",t,sep="_"),x)
  x <- rnorm(1, df[t,12], df[t,13]); assign(paste("e",t,sep="_"),x)
  x <- rnorm(1, df[t,14], df[t,15]); assign(paste("m",t,sep="_"),x)
  
  rm(x,t)
}

  mort0a1 <- c(v1_1, v1_2, v1_3, v1_4, v1_5, v1_6, v1_7, v1_8)
  mort1a4 <- c(v2_1, v2_2, v2_3, v2_4, v2_5, v2_6, v2_7, v2_8)
  mort15a59 <- c(v3_1, v3_2, v3_3, v3_4, v3_5, v3_6, v3_7, v3_8)
  mort59mais <- c(v4_1, v4_2, v4_3, v4_4, v4_5, v4_6, v4_7, v4_8)
  crowdout <- c(c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8)
  emprego <- c(e_1, e_2, e_3, e_4, e_5, e_6, e_7, e_8)
  matricula <- c(m_1, m_2, m_3, m_4, m_5, m_6, m_7, m_8)
  
rm(v1_1, v1_2, v1_3, v1_4, v1_5, v1_6, v1_7, v1_8,
   v2_1, v2_2, v2_3, v2_4, v2_5, v2_6, v2_7, v2_8,
   v3_1, v3_2, v3_3, v3_4, v3_5, v3_6, v3_7, v3_8,
   v4_1, v4_2, v4_3, v4_4, v4_5, v4_6, v4_7, v4_8,
   c_1, c_2, c_3, c_4, c_5, c_6, c_7, c_8,
   e_1, e_2, e_3, e_4, e_5, e_6, e_7, e_8,
   m_1, m_2, m_3, m_4, m_5, m_6, m_7, m_8)

resultado[i] <- mvpf(mort0a1, mort1a4, mort15a59, mort59mais, crowdout, emprego, matricula)

}

hist(as.numeric(resultado))
quantile(as.numeric(resultado), probs = c(0.05, 0.95))
