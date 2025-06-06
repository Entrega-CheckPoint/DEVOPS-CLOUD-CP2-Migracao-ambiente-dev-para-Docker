CREATE TABLE T_CM_FILIAL
(
  ID_FILIAL INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  NM_FILIAL VARCHAR(100) NOT NULL,
  DS_ENDERECO VARCHAR(255) NOT NULL,
  DS_CIDADE VARCHAR(100) NOT NULL,
  DS_ESTADO VARCHAR(50) NOT NULL,
  DS_PAIS VARCHAR(50) NOT NULL,
  CD_CEP VARCHAR(20),
  DS_TELEFONE VARCHAR(20),
  DT_INAUGURACAO DATE
);

CREATE TABLE T_CM_PATIO
(
  ID_PATIO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_FILIAL INT NOT NULL,
  NM_PATIO VARCHAR(100) NOT NULL,
  NR_CAP_MAX INT,
  VL_AREA_PATIO DECIMAL(6,2),
  DS_OBS TEXT,
  CONSTRAINT FK_PATIO_FILIAL FOREIGN KEY (ID_FILIAL)
      REFERENCES T_CM_FILIAL(ID_FILIAL)
      ON DELETE CASCADE
);
