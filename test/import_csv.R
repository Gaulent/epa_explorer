read_epa <- function(fichero)
{
  # ----CONTROL
  temp <- substr(fichero, 1, 3)
  result_frame <- data.frame(CICLO = temp)
  # ----IDEN
  temp <- substr(fichero, 4, 5)
  result_frame$CCAA<-temp
  temp <- substr(fichero, 6, 7)
  result_frame$PROV<-temp
  temp <- substr(fichero, 8, 12)
  result_frame$NVIVI<-temp
  temp <- substr(fichero, 13, 13)
  result_frame$NIVEL<-temp
  temp <- substr(fichero, 14, 15)
  result_frame$NPERS<-temp
  # ----A
  temp <- substr(fichero, 16, 17)
  result_frame$EDAD5<-temp
  temp <- substr(fichero, 18, 18)
  result_frame$RELPP1<-temp
  temp <- substr(fichero, 19, 19)
  result_frame$SEXO1<-temp
  temp <- substr(fichero, 20, 21)
  result_frame$NCONY<-temp
  temp <- substr(fichero, 22, 23)
  result_frame$NPADRE<-temp
  temp <- substr(fichero, 24, 25)
  result_frame$NMADRE<-temp
  temp <- substr(fichero, 26, 26)
  result_frame$RELLMILI<-temp
  temp <- substr(fichero, 27, 27)
  result_frame$ECIV1<-temp
  # ----NACIM
  temp <- substr(fichero, 28, 29)
  result_frame$PRONA1<-temp
  temp <- substr(fichero, 30, 32)
  result_frame$REGNA1<-temp
  temp <- substr(fichero, 33, 33)
  result_frame$NAC1<-temp
  temp <- substr(fichero, 34, 36)
  result_frame$EXREGNA1<-temp
  temp <- substr(fichero, 37, 38)
  result_frame$ANORE1<-temp
  # ----B
  temp <- substr(fichero, 39, 40)
  result_frame$NFORMA<-temp
  temp <- substr(fichero, 41, 42)
  result_frame$RELLB<-temp
  temp <- substr(fichero, 43, 45)
  result_frame$EDADEST<-temp
  temp <- substr(fichero, 46, 46)
  result_frame$CURSR<-temp
  temp <- substr(fichero, 47, 48)
  result_frame$NCURSR<-temp
  temp <- substr(fichero, 49, 49)
  result_frame$CURSNR<-temp
  temp <- substr(fichero, 50, 51)
  result_frame$NCURNR<-temp
  temp <- substr(fichero, 52, 54)
  result_frame$HCURNR<-temp
  temp <- substr(fichero, 55, 56)
  result_frame$RELLB<-temp
  # ----C
  temp <- substr(fichero, 57, 57)
  result_frame$TRAREM<-temp
  temp <- substr(fichero, 58, 58)
  result_frame$AYUDFA<-temp
  temp <- substr(fichero, 59, 59)
  result_frame$AUSENT<-temp
  temp <- substr(fichero, 60, 61)
  result_frame$RZNOTB<-temp
  temp <- substr(fichero, 62, 63)
  result_frame$VINCUL<-temp
  temp <- substr(fichero, 64, 64)
  result_frame$NUEVEM<-temp
  # ----D
  temp <- substr(fichero, 65, 65)
  result_frame$OCUP1<-temp
  temp <- substr(fichero, 66, 66)
  result_frame$ACT1<-temp
  temp <- substr(fichero, 67, 68)
  result_frame$SITU<-temp
  temp <- substr(fichero, 69, 69)
  result_frame$SP<-temp
  temp <- substr(fichero, 70, 70)
  result_frame$DUCON1<-temp
  temp <- substr(fichero, 71, 71)
  result_frame$DUCON2<-temp
  temp <- substr(fichero, 72, 73)
  result_frame$DUCON3<-temp
  # ----TCONT
  temp <- substr(fichero, 74, 75)
  result_frame$TCONTM<-temp
  temp <- substr(fichero, 76, 77)
  result_frame$TCONTD<-temp
  temp <- substr(fichero, 78, 80)
  result_frame$DREN<-temp
  temp <- substr(fichero, 81, 83)
  result_frame$DCOM<-temp
  # ----UBICA
  temp <- substr(fichero, 84, 85)
  result_frame$PROEST<-temp
  temp <- substr(fichero, 86, 88)
  result_frame$REGEST<-temp
  temp <- substr(fichero, 89, 89)
  result_frame$PARCO1<-temp
  temp <- substr(fichero, 90, 91)
  result_frame$PARCO2<-temp
  temp <- substr(fichero, 92, 95)
  result_frame$HORASP<-temp
  temp <- substr(fichero, 96, 99)
  result_frame$HORASH<-temp
  temp <- substr(fichero, 100, 103)
  result_frame$HORASE<-temp
  temp <- substr(fichero, 104, 104)
  result_frame$EXTRA<-temp
  temp <- substr(fichero, 105, 108)
  result_frame$EXTPAG<-temp
  temp <- substr(fichero, 109, 112)
  result_frame$EXTNPG<-temp
  temp <- substr(fichero, 113, 114)
  result_frame$RZDIFH<-temp
  temp <- substr(fichero, 115, 115)
  result_frame$TRAPLU<-temp
  temp <- substr(fichero, 116, 116)
  result_frame$OCUPLU1<-temp
  temp <- substr(fichero, 117, 117)
  result_frame$ACTPLU1<-temp
  temp <- substr(fichero, 118, 119)
  result_frame$SITPLU<-temp
  temp <- substr(fichero, 120, 123)
  result_frame$HORPLU<-temp
  temp <- substr(fichero, 124, 124)
  result_frame$MASHOR<-temp
  temp <- substr(fichero, 125, 125)
  result_frame$DISMAS<-temp
  temp <- substr(fichero, 126, 127)
  result_frame$RZNDISH<-temp
  temp <- substr(fichero, 128, 129)
  result_frame$HORDES<-temp
  temp <- substr(fichero, 130, 130)
  result_frame$BUSOTR<-temp
  # ----E
  temp <- substr(fichero, 131, 131)
  result_frame$BUSCA<-temp
  temp <- substr(fichero, 132, 132)
  result_frame$DESEA<-temp
  temp <- substr(fichero, 133, 133)
  result_frame$FOBACT<-temp
  temp <- substr(fichero, 134, 135)
  result_frame$NBUSCA<-temp
  temp <- substr(fichero, 136, 136)
  result_frame$ASALA<-temp
  temp <- substr(fichero, 137, 137)
  result_frame$EMBUS<-temp
  temp <- substr(fichero, 138, 139)
  result_frame$ITBU<-temp
  temp <- substr(fichero, 140, 140)
  result_frame$DISP<-temp
  temp <- substr(fichero, 141, 141)
  result_frame$RZNDIS<-temp
  # ----F
  temp <- substr(fichero, 142, 142)
  result_frame$EMPANT<-temp
  temp <- substr(fichero, 143, 145)
  result_frame$DTANT<-temp
  temp <- substr(fichero, 146, 146)
  result_frame$OCUPA<-temp
  temp <- substr(fichero, 147, 147)
  result_frame$ACTA<-temp
  temp <- substr(fichero, 148, 149)
  result_frame$SITUA<-temp
  # ----G
  temp <- substr(fichero, 150, 150)
  result_frame$OFEMP<-temp
  # ----H
  temp <- substr(fichero, 151, 152)
  result_frame$SIDI1<-temp
  temp <- substr(fichero, 153, 154)
  result_frame$SIDI2<-temp
  temp <- substr(fichero, 155, 156)
  result_frame$SIDI3<-temp
  temp <- substr(fichero, 157, 157)
  result_frame$SIDAC1<-temp
  temp <- substr(fichero, 158, 158)
  result_frame$SIDAC2<-temp
  # ----I
  temp <- substr(fichero, 159, 159)
  result_frame$MUN1<-temp
  temp <- substr(fichero, 160, 161)
  result_frame$PRORE1<-temp
  temp <- substr(fichero, 162, 164)
  result_frame$REPAIRE1<-temp
  # ----J
  temp <- substr(fichero, 165, 165)
  result_frame$TRAANT<-temp
  # ----VARDER1
  temp <- substr(fichero, 166, 167)
  result_frame$AOI<-temp
  temp <- substr(fichero, 168, 169)
  result_frame$CSE<-temp
  # ----VARDERC
  temp <- substr(fichero, 170, 176)
  result_frame$FACTOREL<-temp
  

  return(result_frame)
}
