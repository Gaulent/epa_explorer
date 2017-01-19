read_epa <- function(x)
{
  # ----CONTROL
  CICLO <- as.numeric(substr(fichero, 1, 3))
  # ----IDEN
  CCAA <- substr(fichero, 4, 5)
  PROV <- substr(fichero, 6, 7)
  NVIVI <- substr(fichero, 8, 12)
  NIVEL <- substr(fichero, 13, 13)
  NPERS <- substr(fichero, 14, 15)
  # ----A
  EDAD5 <- substr(fichero, 16, 17)
  RELPP1 <- substr(fichero, 18, 18)
  SEXO1 <- factor(substr(fichero, 19, 19),c(1,6),c("Hombre", "Mujer"))
  NCONY <- substr(fichero, 20, 21)
  NPADRE <- substr(fichero, 22, 23)
  NMADRE <- substr(fichero, 24, 25)
  RELLMILI <- substr(fichero, 26, 26)
  ECIV1 <- substr(fichero, 27, 27)
  # ----NACIM
  PRONA1 <- substr(fichero, 28, 29)
  REGNA1 <- substr(fichero, 30, 32)
  NAC1 <- substr(fichero, 33, 33)
  EXREGNA1 <- substr(fichero, 34, 36)
  ANORE1 <- substr(fichero, 37, 38)
  # ----B
  NFORMA <- substr(fichero, 39, 40)
  RELLB <- substr(fichero, 41, 42)
  EDADEST <- substr(fichero, 43, 45)
  CURSR <- substr(fichero, 46, 46)
  NCURSR <- substr(fichero, 47, 48)
  CURSNR <- substr(fichero, 49, 49)
  NCURNR <- substr(fichero, 50, 51)
  HCURNR <- substr(fichero, 52, 54)
  RELLB <- substr(fichero, 55, 56)
  # ----C
  TRAREM <- substr(fichero, 57, 57)
  AYUDFA <- substr(fichero, 58, 58)
  AUSENT <- substr(fichero, 59, 59)
  RZNOTB <- substr(fichero, 60, 61)
  VINCUL <- substr(fichero, 62, 63)
  NUEVEM <- substr(fichero, 64, 64)
  # ----D
  OCUP1 <- substr(fichero, 65, 65)
  ACT1 <- substr(fichero, 66, 66)
  SITU <- substr(fichero, 67, 68)
  SP <- substr(fichero, 69, 69)
  DUCON1 <- substr(fichero, 70, 70)
  DUCON2 <- substr(fichero, 71, 71)
  DUCON3 <- substr(fichero, 72, 73)
  # ----TCONT
  TCONTM <- substr(fichero, 74, 75)
  TCONTD <- substr(fichero, 76, 77)
  DREN <- substr(fichero, 78, 80)
  DCOM <- substr(fichero, 81, 83)
  # ----UBICA
  PROEST <- factor(gsub(" ","",substr(fichero, 84, 85)),exclude="")
  REGEST <- substr(fichero, 86, 88)
  PARCO1 <- substr(fichero, 89, 89)
  PARCO2 <- substr(fichero, 90, 91)
  HORASP <- substr(fichero, 92, 95)
  HORASH <- substr(fichero, 96, 99)
  HORASE <- substr(fichero, 100, 103)
  EXTRA <- substr(fichero, 104, 104)
  EXTPAG <- substr(fichero, 105, 108)
  EXTNPG <- substr(fichero, 109, 112)
  RZDIFH <- substr(fichero, 113, 114)
  TRAPLU <- substr(fichero, 115, 115)
  OCUPLU1 <- substr(fichero, 116, 116)
  ACTPLU1 <- substr(fichero, 117, 117)
  SITPLU <- substr(fichero, 118, 119)
  HORPLU <- substr(fichero, 120, 123)
  MASHOR <- substr(fichero, 124, 124)
  DISMAS <- substr(fichero, 125, 125)
  RZNDISH <- substr(fichero, 126, 127)
  HORDES <- substr(fichero, 128, 129)
  BUSOTR <- substr(fichero, 130, 130)
  # ----E
  BUSCA <- substr(fichero, 131, 131)
  DESEA <- substr(fichero, 132, 132)
  FOBACT <- substr(fichero, 133, 133)
  NBUSCA <- substr(fichero, 134, 135)
  ASALA <- substr(fichero, 136, 136)
  EMBUS <- substr(fichero, 137, 137)
  ITBU <- substr(fichero, 138, 139)
  DISP <- substr(fichero, 140, 140)
  RZNDIS <- substr(fichero, 141, 141)
  # ----F
  EMPANT <- substr(fichero, 142, 142)
  DTANT <- substr(fichero, 143, 145)
  OCUPA <- substr(fichero, 146, 146)
  ACTA <- substr(fichero, 147, 147)
  SITUA <- substr(fichero, 148, 149)
  # ----G
  OFEMP <- substr(fichero, 150, 150)
  # ----H
  SIDI1 <- substr(fichero, 151, 152)
  SIDI2 <- substr(fichero, 153, 154)
  SIDI3 <- substr(fichero, 155, 156)
  SIDAC1 <- substr(fichero, 157, 157)
  SIDAC2 <- substr(fichero, 158, 158)
  # ----I
  MUN1 <- substr(fichero, 159, 159)
  PRORE1 <- substr(fichero, 160, 161)
  REPAIRE1 <- substr(fichero, 162, 164)
  # ----J
  TRAANT <- substr(fichero, 165, 165)
  # ----VARDER1
  AOI <- substr(fichero, 166, 167)
  CSE <- substr(fichero, 168, 169)
  # ----VARDERC
  FACTOREL <- substr(fichero, 170, 176)

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
      ACT1,
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
  return(result_frame)
}
