DROP DATABASE IF EXISTS digital_twin_ponte;
CREATE DATABASE digital_twin_ponte;
USE digital_twin_ponte;
CREATE TABLE PONTE (
    id_ponte INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    localita VARCHAR(150) NOT NULL,
    lunghezza DECIMAL(8,2) NOT NULL,
    data_costruzione DATE DEFAULT NULL,
    materiale VARCHAR(50) DEFAULT NULL,
    numero_campate INT DEFAULT NULL,
    stato VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_ponte)
);
CREATE TABLE TIPOLOGIA_SENSORE (
    id_tipologia INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descrizione TEXT DEFAULT NULL,
    grandezza_fisica VARCHAR(80) DEFAULT NULL,
    unita_misura_standard VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (id_tipologia),
    UNIQUE KEY (nome)
);
CREATE TABLE TECNICO (
    id_tecnico INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) DEFAULT NULL,
    cognome VARCHAR(50) DEFAULT NULL,
    email VARCHAR(100) DEFAULT NULL,
    telefono VARCHAR(20) DEFAULT NULL,
    ruolo VARCHAR(50) DEFAULT NULL,
    specializzazione VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (id_tecnico)
);
CREATE TABLE SENSORE (
    id_sensore INT NOT NULL AUTO_INCREMENT,
    codice VARCHAR(50) DEFAULT NULL,
    posizione VARCHAR(150) DEFAULT NULL,
    unita_misura VARCHAR(20) DEFAULT NULL,
    data_installazione DATE DEFAULT NULL,
    stato VARCHAR(30) DEFAULT NULL,
    frequenza INT DEFAULT NULL,
    id_ponte INT NOT NULL,
    id_tipologia INT NOT NULL,
    PRIMARY KEY (id_sensore),
    UNIQUE KEY (codice),
    FOREIGN KEY (id_ponte) REFERENCES PONTE (id_ponte)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_tipologia) REFERENCES TIPOLOGIA_SENSORE (id_tipologia)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE MISURAZIONE (
    id_misurazione BIGINT NOT NULL AUTO_INCREMENT,
    `timestamp` DATETIME DEFAULT NULL,
    valore DECIMAL(15,6) DEFAULT NULL,
    qualita_dato VARCHAR(20) DEFAULT NULL,
    errore VARCHAR(255) DEFAULT NULL,
    id_sensore INT NOT NULL,
    PRIMARY KEY (id_misurazione),
    FOREIGN KEY (id_sensore) REFERENCES SENSORE (id_sensore)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE SOGLIA (
    id_soglia INT NOT NULL AUTO_INCREMENT,
    valore_minimo DECIMAL(15,6) DEFAULT NULL,
    valore_massimo DECIMAL(15,6) DEFAULT NULL,
    livello_criticita VARCHAR(30) DEFAULT NULL,
    data_inizio DATETIME DEFAULT NULL,
    data_fine DATETIME DEFAULT NULL,
    id_sensore INT NOT NULL,
    PRIMARY KEY (id_soglia),
    FOREIGN KEY (id_sensore) REFERENCES SENSORE (id_sensore)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE ALLARME (
    id_allarme INT NOT NULL AUTO_INCREMENT,
    data_ora DATETIME DEFAULT NULL,
    tipologia VARCHAR(50) DEFAULT NULL,
    gravita VARCHAR(30) DEFAULT NULL,
    descrizione TEXT DEFAULT NULL,
    stato VARCHAR(30) DEFAULT NULL,
    data_risoluzione DATETIME DEFAULT NULL,
    id_misurazione BIGINT NOT NULL,
    id_soglia INT DEFAULT NULL,
    id_tecnico INT DEFAULT NULL,
    PRIMARY KEY (id_allarme),
    FOREIGN KEY (id_misurazione) REFERENCES MISURAZIONE (id_misurazione)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_soglia) REFERENCES SOGLIA (id_soglia)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_tecnico) REFERENCES TECNICO (id_tecnico)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE INTERVENTO (
    id_intervento INT NOT NULL AUTO_INCREMENT,
    data_apertura DATE DEFAULT NULL,
    data_esecuzione DATE DEFAULT NULL,
    tipologia VARCHAR(50) DEFAULT NULL,
    descrizione TEXT DEFAULT NULL,
    esito TEXT DEFAULT NULL,
    stato VARCHAR(30) DEFAULT NULL,
    id_ponte INT NOT NULL,
    id_tecnico INT NOT NULL,
    PRIMARY KEY (id_intervento),
    FOREIGN KEY (id_ponte) REFERENCES PONTE (id_ponte)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_tecnico) REFERENCES TECNICO (id_tecnico)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE INTERVENTO_SENSORE (
    id_intervento INT NOT NULL,
    id_sensore INT NOT NULL,
    descrizione_intervento TEXT DEFAULT NULL,
    esito_sensore VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (id_intervento, id_sensore),
    FOREIGN KEY (id_intervento) REFERENCES INTERVENTO (id_intervento)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_sensore) REFERENCES SENSORE (id_sensore)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE REPORT (
    id_report INT NOT NULL AUTO_INCREMENT,
    data_generazione DATETIME DEFAULT NULL,
    periodo_inizio DATETIME DEFAULT NULL,
    periodo_fine DATETIME DEFAULT NULL,
    tipologia VARCHAR(50) DEFAULT NULL,
    percorso_file VARCHAR(255) DEFAULT NULL,
    id_ponte INT NOT NULL,
    id_tecnico INT NOT NULL,
    PRIMARY KEY (id_report),
    FOREIGN KEY (id_ponte) REFERENCES PONTE (id_ponte)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_tecnico) REFERENCES TECNICO (id_tecnico)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
SHOW TABLES;
DESCRIBE PONTE;
DESCRIBE TIPOLOGIA_SENSORE;
DESCRIBE TECNICO;
DESCRIBE SENSORE;
DESCRIBE MISURAZIONE;
DESCRIBE SOGLIA;
DESCRIBE ALLARME;
DESCRIBE INTERVENTO;
DESCRIBE INTERVENTO_SENSORE;
DESCRIBE REPORT;

USE digital_twin_ponte;
INSERT INTO PONTE
    (id_ponte, nome, localita, lunghezza, data_costruzione, materiale, numero_campate, stato)
VALUES
    (1, 'Ponte ferroviario di prova', 'Sito dimostrativo', 125.50, '1998-05-15', 'Acciaio', 3, 'monitorato');
INSERT INTO TIPOLOGIA_SENSORE
    (id_tipologia, nome, descrizione, grandezza_fisica, unita_misura_standard)
VALUES
    (1, 'Accelerometro', 'Rileva le vibrazioni della struttura', 'accelerazione', 'm/s2'),
    (2, 'Estensimetro', 'Rileva la deformazione del materiale', 'deformazione', 'microstrain'),
    (3, 'Termometro', 'Rileva la temperatura del ponte', 'temperatura', '°C');
INSERT INTO TECNICO
    (id_tecnico, nome, cognome, email, telefono, ruolo, specializzazione)
VALUES
    (1, 'Ada', 'Collaudo', 'ada.collaudo@example.test', '000000001', 'tecnico sensori', 'analisi vibrazioni'),
    (2, 'Luca', 'Verifica', 'luca.verifica@example.test', '000000002', 'tecnico manutenzione', 'strutture ferroviarie');
INSERT INTO SENSORE
    (id_sensore, codice, posizione, unita_misura, data_installazione, stato, frequenza, id_ponte, id_tipologia)
VALUES
    (1, 'ACC-PROVA-01', 'Campata 1, appoggio nord', 'm/s2', '2025-09-01', 'attivo', 100, 1, 1),
    (2, 'EST-PROVA-01', 'Campata 2, trave centrale', 'microstrain', '2025-09-01', 'attivo', 10, 1, 2),
    (3, 'TMP-PROVA-01', 'Campata 3, lato est', '°C', '2025-09-01', 'attivo', 1, 1, 3);
INSERT INTO MISURAZIONE
    (id_misurazione, `timestamp`, valore, qualita_dato, errore, id_sensore)
VALUES
    (1, '2026-11-20 09:00:00', 0.125000, 'valido', NULL, 1),
    (2, '2026-11-20 09:05:00', 0.148000, 'valido', NULL, 1),
    (3, '2026-11-20 09:00:00', 120.200000, 'valido', NULL, 2),
    (4, '2026-11-20 09:05:00', 450.000000, 'valido', NULL, 2),
    (5, '2026-11-20 09:00:00', 14.500000, 'valido', NULL, 3),
    (6, '2026-11-20 09:05:00', 15.000000, 'valido', NULL, 3);
INSERT INTO SOGLIA
    (id_soglia, valore_minimo, valore_massimo, livello_criticita, data_inizio, data_fine, id_sensore)
VALUES
    (1, -1.000000, 1.000000, 'attenzione', '2025-09-01 00:00:00', NULL, 1),
    (2, -300.000000, 400.000000, 'critica', '2025-09-01 00:00:00', NULL, 2),
    (3, -20.000000, 50.000000, 'attenzione', '2025-09-01 00:00:00', NULL, 3);
INSERT INTO ALLARME
    (id_allarme, data_ora, tipologia, gravita, descrizione, stato, data_risoluzione,
     id_misurazione, id_soglia, id_tecnico)
VALUES
    (1, '2026-11-20 09:05:10', 'superamento soglia', 'alta',
     'Deformazione oltre il limite massimo impostato', 'aperto', NULL, 4, 2, 1),
    (2, '2026-11-20 09:05:20', 'anomalia temporanea', 'bassa',
     'Segnalazione di prova senza soglia e tecnico assegnati', 'in verifica', NULL, 2, NULL, NULL);
INSERT INTO INTERVENTO
    (id_intervento, data_apertura, data_esecuzione, tipologia, descrizione, esito, stato, id_ponte, id_tecnico)
VALUES
    (1, '2026-11-20', '2026-11-21', 'ispezione',
     'Controllo di prova dopo il superamento della soglia', 'Sensore verificato', 'concluso', 1, 2);
INSERT INTO INTERVENTO_SENSORE
    (id_intervento, id_sensore, descrizione_intervento, esito_sensore)
VALUES
    (1, 2, 'Verifica estensimetro della campata centrale', 'funzionante'),
    (1, 3, 'Controllo del sensore di temperatura', 'funzionante');
INSERT INTO REPORT
    (id_report, data_generazione, periodo_inizio, periodo_fine, tipologia, percorso_file, id_ponte, id_tecnico)
VALUES
    (1, '2026-11-21 12:00:00', '2026-11-20 00:00:00', '2026-11-21 00:00:00',
     'giornaliero', 'report/prova_ponte_20261121.pdf', 1, 2);

SELECT * FROM PONTE;
SELECT * FROM TIPOLOGIA_SENSORE;
SELECT * FROM TECNICO;
SELECT * FROM SENSORE;
SELECT * FROM MISURAZIONE;
SELECT * FROM SOGLIA;
SELECT * FROM ALLARME;
SELECT * FROM INTERVENTO;
SELECT * FROM INTERVENTO_SENSORE;
SELECT * FROM REPORT;
