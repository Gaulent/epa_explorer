fichero<-readLines("datos_old_full")


  # ----CONTROL
  CICLO<-factor(gsub(" ","",substr(fichero, 1,3)),exclude="")
  # ----IDEN
  CCAA<-factor(gsub(" ","",substr(fichero, 4,5)),exclude="")
  PROV<-factor(gsub(" ","",substr(fichero, 6,7)),exclude="")
  NVIVI<-factor(gsub(" ","",substr(fichero, 8,12)),exclude="")
  NIVEL<-factor(gsub(" ","",substr(fichero, 13,13)),exclude="")
  NPERS<-factor(gsub(" ","",substr(fichero, 14,15)),exclude="")
  # ----A
  EDAD5<-factor(gsub(" ","",substr(fichero, 16,17)),exclude="")
  RELPP1<-factor(gsub(" ","",substr(fichero, 18,18)),exclude="")
  SEXO1<-factor(gsub(" ","",substr(fichero, 19,19)),exclude="")
  NCONY<-factor(gsub(" ","",substr(fichero, 20,21)),exclude="")
  NPADRE<-factor(gsub(" ","",substr(fichero, 22,23)),exclude="")
  NMADRE<-factor(gsub(" ","",substr(fichero, 24,25)),exclude="")
  RELLMILI<-factor(gsub(" ","",substr(fichero, 26,26)),exclude="")
  ECIV1<-factor(gsub(" ","",substr(fichero, 27,27)),exclude="")
  # ----NACIM
  PRONA1<-factor(gsub(" ","",substr(fichero, 28,29)),exclude="")
  REGNA1<-factor(gsub(" ","",substr(fichero, 30,32)),exclude="")
  NAC1<-factor(gsub(" ","",substr(fichero, 33,33)),exclude="")
  EXREGNA1<-factor(gsub(" ","",substr(fichero, 34,36)),exclude="")
  ANORE1<-factor(gsub(" ","",substr(fichero, 37,38)),exclude="")
  # ----B
  NFORMA<-factor(gsub(" ","",substr(fichero, 39,40)),exclude="")
  RELLB<-factor(gsub(" ","",substr(fichero, 41,42)),exclude="")
  EDADEST<-factor(gsub(" ","",substr(fichero, 43,45)),exclude="")
  CURSR<-factor(gsub(" ","",substr(fichero, 46,46)),exclude="")
  NCURSR<-factor(gsub(" ","",substr(fichero, 47,48)),exclude="")
  CURSNR<-factor(gsub(" ","",substr(fichero, 49,49)),exclude="")
  NCURNR<-factor(gsub(" ","",substr(fichero, 50,51)),exclude="")
  HCURNR<-factor(gsub(" ","",substr(fichero, 52,54)),exclude="")
  RELLB<-factor(gsub(" ","",substr(fichero, 55,56)),exclude="")
  # ----C
  TRAREM<-factor(gsub(" ","",substr(fichero, 57,57)),exclude="")
  AYUDFA<-factor(gsub(" ","",substr(fichero, 58,58)),exclude="")
  AUSENT<-factor(gsub(" ","",substr(fichero, 59,59)),exclude="")
  RZNOTB<-factor(gsub(" ","",substr(fichero, 60,61)),exclude="")
  VINCUL<-factor(gsub(" ","",substr(fichero, 62,63)),exclude="")
  NUEVEM<-factor(gsub(" ","",substr(fichero, 64,64)),exclude="")
  # ----D
  OCUP1<-factor(gsub(" ","",substr(fichero, 65,65)),exclude="")
  ACT11<-factor(gsub(" ","",substr(fichero, 66,66)),exclude="")
  SITU<-factor(gsub(" ","",substr(fichero, 67,68)),exclude="")
  SP<-factor(gsub(" ","",substr(fichero, 69,69)),exclude="")
  DUCON1<-factor(gsub(" ","",substr(fichero, 70,70)),exclude="")
  DUCON2<-factor(gsub(" ","",substr(fichero, 71,71)),exclude="")
  DUCON3<-factor(gsub(" ","",substr(fichero, 72,73)),exclude="")
  # ----TCONT
  TCONTM<-factor(gsub(" ","",substr(fichero, 74,75)),exclude="")
  TCONTD<-factor(gsub(" ","",substr(fichero, 76,77)),exclude="")
  DREN<-factor(gsub(" ","",substr(fichero, 78,80)),exclude="")
  DCOM<-factor(gsub(" ","",substr(fichero, 81,83)),exclude="")
  # ----UBICA
  PROEST<-factor(gsub(" ","",substr(fichero, 84,85)),exclude="")
  REGEST<-factor(gsub(" ","",substr(fichero, 86,88)),exclude="")
  PARCO1<-factor(gsub(" ","",substr(fichero, 89,89)),exclude="")
  PARCO2<-factor(gsub(" ","",substr(fichero, 90,91)),exclude="")
  HORASP<-factor(gsub(" ","",substr(fichero, 92,95)),exclude="")
  HORASH<-factor(gsub(" ","",substr(fichero, 96,99)),exclude="")
  HORASE<-factor(gsub(" ","",substr(fichero, 100,103)),exclude="")
  EXTRA<-factor(gsub(" ","",substr(fichero, 104,104)),exclude="")
  EXTPAG<-factor(gsub(" ","",substr(fichero, 105,108)),exclude="")
  EXTNPG<-factor(gsub(" ","",substr(fichero, 109,112)),exclude="")
  RZDIFH<-factor(gsub(" ","",substr(fichero, 113,114)),exclude="")
  TRAPLU<-factor(gsub(" ","",substr(fichero, 115,115)),exclude="")
  OCUPLU1<-factor(gsub(" ","",substr(fichero, 116,116)),exclude="")
  ACTPLU1<-factor(gsub(" ","",substr(fichero, 117,117)),exclude="")
  SITPLU<-factor(gsub(" ","",substr(fichero, 118,119)),exclude="")
  HORPLU<-factor(gsub(" ","",substr(fichero, 120,123)),exclude="")
  MASHOR<-factor(gsub(" ","",substr(fichero, 124,124)),exclude="")
  DISMAS<-factor(gsub(" ","",substr(fichero, 125,125)),exclude="")
  RZNDISH<-factor(gsub(" ","",substr(fichero, 126,127)),exclude="")
  HORDES<-factor(gsub(" ","",substr(fichero, 128,129)),exclude="")
  BUSOTR<-factor(gsub(" ","",substr(fichero, 130,130)),exclude="")
  # ----E
  BUSCA<-factor(gsub(" ","",substr(fichero, 131,131)),exclude="")
  DESEA<-factor(gsub(" ","",substr(fichero, 132,132)),exclude="")
  FOBACT<-factor(gsub(" ","",substr(fichero, 133,133)),exclude="")
  NBUSCA<-factor(gsub(" ","",substr(fichero, 134,135)),exclude="")
  ASALA<-factor(gsub(" ","",substr(fichero, 136,136)),exclude="")
  EMBUS<-factor(gsub(" ","",substr(fichero, 137,137)),exclude="")
  ITBU<-factor(gsub(" ","",substr(fichero, 138,139)),exclude="")
  DISP<-factor(gsub(" ","",substr(fichero, 140,140)),exclude="")
  RZNDIS<-factor(gsub(" ","",substr(fichero, 141,141)),exclude="")
  # ----F
  EMPANT<-factor(gsub(" ","",substr(fichero, 142,142)),exclude="")
  DTANT<-factor(gsub(" ","",substr(fichero, 143,145)),exclude="")
  OCUPA<-factor(gsub(" ","",substr(fichero, 146,146)),exclude="")
  ACTA<-factor(gsub(" ","",substr(fichero, 147,147)),exclude="")
  SITUA<-factor(gsub(" ","",substr(fichero, 148,149)),exclude="")
  # ----G
  OFEMP<-factor(gsub(" ","",substr(fichero, 150,150)),exclude="")
  # ----H
  SIDI1<-factor(gsub(" ","",substr(fichero, 151,152)),exclude="")
  SIDI2<-factor(gsub(" ","",substr(fichero, 153,154)),exclude="")
  SIDI3<-factor(gsub(" ","",substr(fichero, 155,156)),exclude="")
  SIDAC1<-factor(gsub(" ","",substr(fichero, 157,157)),exclude="")
  SIDAC2<-factor(gsub(" ","",substr(fichero, 158,158)),exclude="")
  # ----I
  MUN1<-factor(gsub(" ","",substr(fichero, 159,159)),exclude="")
  PRORE1<-factor(gsub(" ","",substr(fichero, 160,161)),exclude="")
  REPAIRE1<-factor(gsub(" ","",substr(fichero, 162,164)),exclude="")
  # ----J
  TRAANT<-factor(gsub(" ","",substr(fichero, 165,165)),exclude="")
  # ----VARDER1
  AOI<-factor(gsub(" ","",substr(fichero, 166,167)),exclude="")
  CSE<-factor(gsub(" ","",substr(fichero, 168,169)),exclude="")
  # ----VARDERC
  FACTOREL<-factor(gsub(" ","",substr(fichero, 170,176)),exclude="")
  
  result_frame <-
    data.frame(
      CICLO,
      CCAA,
      PROV,
      NVIVI,
      NIVEL,
      NPERS,
      EDAD5,
      RELPP1,
      SEXO1,
      NCONY,
      NPADRE,
      NMADRE,
      RELLMILI,
      ECIV1,
      PRONA1,
      REGNA1,
      NAC1,
      EXREGNA1,
      ANORE1,
      NFORMA,
      RELLB,
      EDADEST,
      CURSR,
      NCURSR,
      CURSNR,
      NCURNR,
      HCURNR,
      RELLB,
      TRAREM,
      AYUDFA,
      AUSENT,
      RZNOTB,
      VINCUL,
      NUEVEM,
      OCUP1,
      ACT11,
      SITU,
      SP,
      DUCON1,
      DUCON2,
      DUCON3,
      TCONTM,
      TCONTD,
      DREN,
      DCOM,
      PROEST,
      REGEST,
      PARCO1,
      PARCO2,
      HORASP,
      HORASH,
      HORASE,
      EXTRA,
      EXTPAG,
      EXTNPG,
      RZDIFH,
      TRAPLU,
      OCUPLU1,
      ACTPLU1,
      SITPLU,
      HORPLU,
      MASHOR,
      DISMAS,
      RZNDISH,
      HORDES,
      BUSOTR,
      BUSCA,
      DESEA,
      FOBACT,
      NBUSCA,
      ASALA,
      EMBUS,
      ITBU,
      DISP,
      RZNDIS,
      EMPANT,
      DTANT,
      OCUPA,
      ACTA,
      SITUA,
      OFEMP,
      SIDI1,
      SIDI2,
      SIDI3,
      SIDAC1,
      SIDAC2,
      MUN1,
      PRORE1,
      REPAIRE1,
      TRAANT,
      AOI,
      CSE,
      FACTOREL
    )

  saveRDS(result_frame,file="dframe_old.Rda")
  setwd("D:/workarea")
  dframe<-readRDS(file="dframe_new.Rda")