CREATE TABLE epa_table (
    CICLO    INTEGER,
    CCAA     TEXT,
    PROV     TEXT,
    NIVEL    TEXT,
    EDAD5    INTEGER,
    SEXO     TEXT,
    ECIV     TEXT,
    REGNA    TEXT,
    NAC      TEXT,
    EXREGNA  TEXT,
    ANORE    INTEGER,
    NFORMA   TEXT,
    EDADEST  INTEGER,
    CURSR    TEXT,
    NCURSR   TEXT,
    CURSNR   TEXT,
    NCURNR   TEXT,
    HCURNR   INTEGER,
    TRAREM   TEXT,
    AYUDFA   TEXT,
    AUSENT   TEXT,
    RZNOTB   TEXT,
    VINCUL   TEXT,
    NUEVEM   TEXT,
    OCUP     TEXT,
    ACT      TEXT,
    SITU     TEXT,
    SP       TEXT,
    DUCON1   TEXT,
    DUCON2   TEXT,
    DUCON3   TEXT,
    TCONT    REAL,
    DREN     INTEGER,
    DCOM     INTEGER,
    REGEST   TEXT,
    PARCO1   TEXT,
    PARCO2   TEXT,
    HORASP   REAL,
    HORASH   REAL,
    HORASE   REAL,
    EXTRA    TEXT,
    EXTPAG   REAL,
    EXTNPG   REAL,
    RZDIFH   TEXT,
    TRAPLU   TEXT,
    OCUPLU   TEXT,
    ACTPLU   TEXT,
    SITPLU   TEXT,
    HORPLU   REAL,
    MASHOR   TEXT,
    DISMAS   TEXT,
    RZNDISH  TEXT,
    HORDES   REAL,
    BUSOTR   TEXT,
    BUSCA    TEXT,
    DESEA    TEXT,
    FOBACT   TEXT,
    NBUSCA   TEXT,
    ASALA    TEXT,
    EMBUS    TEXT,
    ITBU     TEXT,
    DISP     TEXT,
    RZNDIS   TEXT,
    EMPANT   TEXT,
    DTANT    INTEGER,
    OCUPA    TEXT,
    ACTA     TEXT,
    SITUA    TEXT,
    OFEMP    TEXT,
    SIDI1    INTEGER,
    SIDI2    INTEGER,
    SIDI3    INTEGER,
    SIDI4    INTEGER,
    SIDI5    INTEGER,
    SIDI6    INTEGER,
    SIDI7    INTEGER,
    SIDAC1   INTEGER,
    SIDAC2   INTEGER,
    MUN      TEXT,
    REPAIRE  TEXT,
    AOI      TEXT,
    CSE      TEXT,
    FACTOREL REAL
);



CREATE INDEX CICLO ON epa_table (
    CICLO
);



CREATE INDEX [CICLO-NIVEL] ON epa_table (
    CICLO,
    NIVEL
);


CREATE INDEX [CICLO-NIVEL-SITU] ON epa_table (
    CICLO,
    NIVEL,
    SITU
);


CREATE INDEX NIVEL ON epa_table (
    NIVEL
);


CREATE INDEX [NIVEL-SITU] ON epa_table (
    NIVEL,
    SITU
);


CREATE INDEX SITU ON epa_table (
    SITU
);


CREATE TABLE db_updates (
    Name TEXT UNIQUE
            NOT NULL
            PRIMARY KEY
);


CREATE TABLE list_attrdef (name TEXT, type TEXT, description TEXT);
INSERT INTO list_attrdef (name, type, description) VALUES ('CICLO', NULL, 'Período de referencia');
INSERT INTO list_attrdef (name, type, description) VALUES ('CCAA', 'FACTOR', 'Comunidad autónoma');
INSERT INTO list_attrdef (name, type, description) VALUES ('PROV', 'FACTOR', 'Provincia');
INSERT INTO list_attrdef (name, type, description) VALUES ('NIVEL', 'FACTOR', 'Nivel del registro');
INSERT INTO list_attrdef (name, type, description) VALUES ('EDAD5', 'NUMERIC', 'Edad');
INSERT INTO list_attrdef (name, type, description) VALUES ('SEXO', 'FACTOR', 'Sexo');
INSERT INTO list_attrdef (name, type, description) VALUES ('ECIV', 'FACTOR', 'Estado civil');
INSERT INTO list_attrdef (name, type, description) VALUES ('REGNA', 'FACTOR', 'Provincia/Región de Nacimiento');
INSERT INTO list_attrdef (name, type, description) VALUES ('NAC', 'FACTOR', 'Nacionalidad');
INSERT INTO list_attrdef (name, type, description) VALUES ('EXREGNA', 'FACTOR', 'Reg de nacionalidad extranjera');
INSERT INTO list_attrdef (name, type, description) VALUES ('ANORE', 'NUMERIC', 'Años de residencia en España');
INSERT INTO list_attrdef (name, type, description) VALUES ('NFORMA', 'FACTOR', 'Nivel de estudios');
INSERT INTO list_attrdef (name, type, description) VALUES ('EDADEST', 'NUMERIC', 'Edad fin de estudios');
INSERT INTO list_attrdef (name, type, description) VALUES ('CURSR', 'FACTOR', 'Cursa estudios reglados');
INSERT INTO list_attrdef (name, type, description) VALUES ('NCURSR', 'FACTOR', 'Nivel de estudios reglados');
INSERT INTO list_attrdef (name, type, description) VALUES ('CURSNR', 'FACTOR', 'Cursa formación no reglada');
INSERT INTO list_attrdef (name, type, description) VALUES ('NCURNR', 'FACTOR', 'Nivel de estudios no reglados');
INSERT INTO list_attrdef (name, type, description) VALUES ('HCURNR', 'NUMERIC', 'Horas de estudios no reglados');
INSERT INTO list_attrdef (name, type, description) VALUES ('TRAREM', 'FACTOR', 'Trabajo remunerado');
INSERT INTO list_attrdef (name, type, description) VALUES ('AYUDFA', 'FACTOR', 'Ayuda familiar');
INSERT INTO list_attrdef (name, type, description) VALUES ('AUSENT', 'FACTOR', 'Ausente al trabajo?');
INSERT INTO list_attrdef (name, type, description) VALUES ('RZNOTB', 'FACTOR', 'Razones por las que no trabajo');
INSERT INTO list_attrdef (name, type, description) VALUES ('VINCUL', 'FACTOR', 'Vinculación con el empleo ausentes');
INSERT INTO list_attrdef (name, type, description) VALUES ('NUEVEM', 'FACTOR', 'Ha encontrado empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('OCUP', 'FACTOR', 'Ocupación principal');
INSERT INTO list_attrdef (name, type, description) VALUES ('ACT', 'FACTOR', 'Actividad principal');
INSERT INTO list_attrdef (name, type, description) VALUES ('SITU', 'FACTOR', 'Situación profesional');
INSERT INTO list_attrdef (name, type, description) VALUES ('SP', 'FACTOR', 'Tipo de administración');
INSERT INTO list_attrdef (name, type, description) VALUES ('DUCON1', 'FACTOR', 'Contrato indefinido o temporal');
INSERT INTO list_attrdef (name, type, description) VALUES ('DUCON2', 'FACTOR', 'Relación laboral perm. o discont.');
INSERT INTO list_attrdef (name, type, description) VALUES ('DUCON3', 'FACTOR', 'Tipo de contrato de carácter temporal');
INSERT INTO list_attrdef (name, type, description) VALUES ('TCONT', 'NUMERIC', 'Duración del contrato o rel. lab.');
INSERT INTO list_attrdef (name, type, description) VALUES ('DREN', 'NUMERIC', 'Meses desde la renovación del contrato');
INSERT INTO list_attrdef (name, type, description) VALUES ('DCOM', 'NUMERIC', 'Meses en la empresa');
INSERT INTO list_attrdef (name, type, description) VALUES ('REGEST', 'FACTOR', 'Provincia/Región donde está ubicado');
INSERT INTO list_attrdef (name, type, description) VALUES ('PARCO1', 'FACTOR', 'Jornada completa o parcial');
INSERT INTO list_attrdef (name, type, description) VALUES ('PARCO2', 'FACTOR', 'Motivo de tener jornada parcial');
INSERT INTO list_attrdef (name, type, description) VALUES ('HORASP', 'NUMERIC', 'Horas pactadas en contrato');
INSERT INTO list_attrdef (name, type, description) VALUES ('HORASH', 'NUMERIC', 'Horas semanales habituales');
INSERT INTO list_attrdef (name, type, description) VALUES ('HORASE', 'NUMERIC', 'Horas dedicadas la semana pasada');
INSERT INTO list_attrdef (name, type, description) VALUES ('EXTRA', 'FACTOR', 'Realizó horas extraordinarias');
INSERT INTO list_attrdef (name, type, description) VALUES ('EXTPAG', 'NUMERIC', 'Horas extraordinarias pagadas');
INSERT INTO list_attrdef (name, type, description) VALUES ('EXTNPG', 'NUMERIC', 'Horas extraordinarias no pagadas');
INSERT INTO list_attrdef (name, type, description) VALUES ('RZDIFH', 'FACTOR', 'Razón de la diferencia de horas');
INSERT INTO list_attrdef (name, type, description) VALUES ('TRAPLU', 'FACTOR', 'Tiene otro u otros empleos');
INSERT INTO list_attrdef (name, type, description) VALUES ('OCUPLU', 'FACTOR', 'Ocupación en el segundo empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('ACTPLU', 'FACTOR', 'Actividad del segundo empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('SITPLU', 'FACTOR', 'Situación profesional segundo empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('HORPLU', 'NUMERIC', 'Horas efectivas en el segundo empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('MASHOR', 'FACTOR', 'Desearía trabajar más horas');
INSERT INTO list_attrdef (name, type, description) VALUES ('DISMAS', 'FACTOR', 'Disponibilidad para trabajar más horas');
INSERT INTO list_attrdef (name, type, description) VALUES ('RZNDISH', 'FACTOR', 'Razon para no trabajar más horas');
INSERT INTO list_attrdef (name, type, description) VALUES ('HORDES', 'NUMERIC', 'Número de horas que desearía trabajar');
INSERT INTO list_attrdef (name, type, description) VALUES ('BUSOTR', 'FACTOR', 'Busca otro empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('BUSCA', 'FACTOR', 'Buscado empleo las últimas 4 semanas');
INSERT INTO list_attrdef (name, type, description) VALUES ('DESEA', 'FACTOR', 'Desearía tener un empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('FOBACT', 'FACTOR', 'Métodos de encontrar empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('NBUSCA', 'FACTOR', 'Razones por las  que no busca empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('ASALA', 'FACTOR', 'El empleo que busca es asalariado');
INSERT INTO list_attrdef (name, type, description) VALUES ('EMBUS', 'FACTOR', 'Tipo de jornada en el empleo buscado');
INSERT INTO list_attrdef (name, type, description) VALUES ('ITBU', 'FACTOR', 'Tiempo que lleva buscando empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('DISP', 'FACTOR', 'Disponible para trabajar en 15 días');
INSERT INTO list_attrdef (name, type, description) VALUES ('RZNDIS', 'FACTOR', 'Razones para no trabajar en 15 días');
INSERT INTO list_attrdef (name, type, description) VALUES ('EMPANT', 'FACTOR', 'Si ha realizado antes algún trabajo');
INSERT INTO list_attrdef (name, type, description) VALUES ('DTANT', 'NUMERIC', 'Meses desde que dejó su último empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('OCUPA', 'FACTOR', 'Ocupación en su último empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('ACTA', 'FACTOR', 'Actividad donde trabajaba');
INSERT INTO list_attrdef (name, type, description) VALUES ('SITUA', 'FACTOR', 'Situación en su anterior trabajo');
INSERT INTO list_attrdef (name, type, description) VALUES ('OFEMP', 'FACTOR', 'Inscrito en of. Empleo de la admon.');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDI1', 'FACTOR', 'Estudiante');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDI2', 'FACTOR', 'Jubilado');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDI3', 'FACTOR', 'Labores del hogar');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDI4', 'FACTOR', 'Incapacitado permanente');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDI5', 'FACTOR', 'Pensión distinta a la de jubilación');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDI6', 'FACTOR', 'Actividad no remunerada');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDI7', 'FACTOR', 'Otras situaciones');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDAC1', 'FACTOR', 'Trabajando');
INSERT INTO list_attrdef (name, type, description) VALUES ('SIDAC2', 'FACTOR', 'Buscando empleo');
INSERT INTO list_attrdef (name, type, description) VALUES ('MUN', 'FACTOR', 'Lugar de residencia hace un año');
INSERT INTO list_attrdef (name, type, description) VALUES ('REPAIRE', 'FACTOR', 'Provincia/Región de residencia anterior');
INSERT INTO list_attrdef (name, type, description) VALUES ('AOI', 'FACTOR', 'Actividad económica OIT');
INSERT INTO list_attrdef (name, type, description) VALUES ('CSE', 'FACTOR', 'Condición socioeconómica');
INSERT INTO list_attrdef (name, type, description) VALUES ('FACTOREL', NULL, 'Factor de elevación');