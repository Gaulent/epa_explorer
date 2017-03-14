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
