
-- Tabela Cliente CREATE TABLE CLIENTE(
COD_CLIENTE INT PRIMARY KEY IDENTITY, CNPJ CHAR(14),
 

RAZAO_SOCIAL VARCHAR(100), CONTATO_PRINCIPAL VARCHAR(50), RAMO_ATIVIDADE VARCHAR(100)
)
-- tabela maquina


CREATE TABLE MAQUINA (
COD_MAQUINA INT PRIMARY KEY IDENTITY, TIPO_MAQUINA VARCHAR(100), TEMPO_NECESSARIO INT
)
-- tabela produto
CREATE TABLE PRODUTO (
COD_PRODUTO INT PRIMARY KEY IDENTITY, NOME VARCHAR(100),
COR VARCHAR(100), DIMENSOES VARCHAR(100), PESO FLOAT,
PRECO FLOAT, VALIDADE DATE,
TEMPO_MEDIO_FABR FLOAT, DESENHO_PRODUTO VARCHAR(100)
)
-- tabela materia prima
 

CREATE TABLE MATERIA_PRIMA (
COD_MATERIA_PRIMA INT PRIMARY KEY IDENTITY, TIPO VARCHAR(100),
UNIDADE_MEDIDA FLOAT, COD_COMPONENTE_FK INT
)


--	tabela materiais diversos


CREATE TABLE MATERIAIS_DIVERSOS( COD_MATERIAL INT PRIMARY KEY IDENTITY, TIPO VARCHAR(100),
UNIDADE_MEDIDA FLOAT, COD_COMPONENTE_FK INT
)





-- tabela componentes
CREATE TABLE COMPONENTES ( COD_COMPONENTE INT PRIMARY KEY IDENTITY, COD_MATERIAL_FK INT, COD_MATERI_PRIMA_FK INT, COD_MAQUINA_FK INT,
 

COD_PRODUTO_COMPONENTES_FK INT, QTD_NECESS_MATERIAL INT, QTD_NESS_MAT_DIV INT,
PESO FLOAT, PRECO FLOAT, VALIDADE DATE,
TEMPO_MEDIO_FABR FLOAT, DESENHO_PRODUTO VARCHAR(100),
CONSTRAINT COD_MATERIAL_FK FOREIGN KEY(COD_MATERIAL_FK) REFERENCES MATERIAIS_DIVERSOS(COD_MATERIAL),
CONSTRAINT COD_MATERI_PRIMA_FK FOREIGN KEY(COD_MATERI_PRIMA_FK) REFERENCES MATERIA_PRIMA(COD_MATERIA_PRIMA),
CONSTRAINT COD_MAQUINA_FK FOREIGN KEY(COD_MAQUINA_FK) REFERENCES MAQUINA (COD_MAQUINA),
CONSTRAINT COD_PRODUTO_COMPONENTES_FK FOREIGN KEY(COD_PRODUTO_COMPONENTES_FK) REFERENCES PRODUTO(COD_PRODUTO)
)
 








-- Tabela endere�o cobranca
CREATE TABLE ENDERECO_COBRANCA ( COD_ENDERECO INT PRIMARY KEY IDENTITY, RUA VARCHAR(100),
NUMERO INT,
BAIRRO VARCHAR(100), UF CHAR(2),
CEP CHAR(8), COD_CLIENTE_FK INT,
CONSTRAINT COD_CLIENTE_FK FOREIGN KEY(COD_CLIENTE_FK) REFERENCES CLIENTE(COD_CLIENTE)
)


-- Tabela endereco correspondencia


CREATE TABLE ENDERECO_CORRESPONDENCIA ( COD_ENDERECO_CORRESP INT PRIMARY KEY IDENTITY, RUA VARCHAR(100),
NUMERO INT,
BAIRRO VARCHAR(100),
 

UF CHAR(2), CEP CHAR(8),
COD_CLIENTE_ENDERECO_CORRESP_FK INT,
CONSTRAINT COD_CLIENTE_ENDERECO_CORRESP_FK FOREIGN KEY(COD_CLIENTE_ENDERECO_CORRESP_FK) REFERENCES CLIENTE(COD_CLIENTE)
)


-- tabela forma_pagamento
CREATE TABLE FORMA_PAGAMENTO( COD_FORMA_PAGAMENTO INT PRIMARY KEY IDENTITY, TIPO_PAGAMENTO VARCHAR(100)
)
-- Tabela encomendas


CREATE TABLE ENCOMENDA (
COD_ENCOMENDA INT PRIMARY KEY IDENTITY, DATA_INCLUSAO DATE,
DATA_NECESSODADE DATE, DESCONTO FLOAT, VALOR_LIQUIDO FLOAT, VALOR_TOTAL FLOAT, QTD_PARCELAS INT,
COD_CLIENTE_ENCOMENDA_FK INT, COD_FORMA_PAGAMENTO_FK INT
 

CONSTRAINT COD_CLIENTE_ENCOMENDA_FK FOREIGN KEY(COD_CLIENTE_ENCOMENDA_FK) REFERENCES CLIENTE(COD_CLIENTE),
CONSTRAINT COD_FORMA_PAGAMENTO_FK FOREIGN KEY(COD_FORMA_PAGAMENTO_FK) REFERENCES FORMA_PAGAMENTO(COD_FORMA_PAGAMENTO)
)




-- tabela endereco entrega


CREATE TABLE ENDERECO_ENTREGA ( COD_ENDERECO INT PRIMARY KEY IDENTITY, RUA VARCHAR(100),
NUMERO INT,
BAIRRO VARCHAR(100), UF CHAR(2),
CEP CHAR(8), COD_CLIENTE_ENDERECO_ENTREGA_FK INT,
CONSTRAINT COD_CLIENTE_ENDERECO_ENTREGA_FK FOREIGN KEY(COD_CLIENTE_ENDERECO_ENTREGA_FK) REFERENCES CLIENTE(COD_CLIENTE)
)


-- tabela telefone cliente


CREATE TABLE TELEFONE_CLIENTE (
COD_TELEFONE_CLIENTE INT PRIMARY KEY IDENTITY,
 

DDD CHAR(2), NUMERO CHAR(9), TIPO VARCHAR(50),
COD_CLIENTE_TELEFONE_FK INT,
CONSTRAINT COD_CLIENTE_TELEFONE_FK FOREIGN KEY(COD_CLIENTE_TELEFONE_FK) REFERENCES CLIENTE(COD_CLIENTE)
)




-- tabela manutencao


CREATE TABLE MANUTENCAO(
COD_MANUTENCAO INT PRIMARY KEY IDENTITY, CNPJ_EMPRESA_MANUTENCAO CHAR(14), RAZAO_SOCIAL VARCHAR(100), DATA_MANUTENCAO DATE, DESCRICAO_MANUTENCAO VARCHAR(100), COD_MAQUINA_FK_MANUTENCAO INT,
CONSTRAINT COD_MAQUINA_FK_MANUTENCAO FOREIGN KEY(COD_MAQUINA_FK_MANUTENCAO) REFERENCES MAQUINA(COD_MAQUINA)
)


-- tabela telefone manutencao
CREATE TABLE TELEFONE_MANUTENCAO (
 

COD_TELEFONE_MANUTENCAO INT PRIMARY KEY IDENTITY, DDD CHAR(2),
NUMERO CHAR(9), TIPO VARCHAR(50),
COD_MANUTENCAO_TELEFONE_FK INT,
CONSTRAINT COD_MANUTENCAO_TELEFONE_FK FOREIGN KEY(COD_MANUTENCAO_TELEFONE_FK) REFERENCES MANUTENCAO(COD_MANUTENCAO)
)


-- tabela endereco manutencao
CREATE TABLE ENDERECO_MANUTENCAO( COD_ENDERECO INT PRIMARY KEY IDENTITY, RUA VARCHAR(100),
NUMERO INT,
BAIRRO VARCHAR(100), UF CHAR(2),
CEP CHAR(8), COD_MANUTENCAO_ENDERECO_FK INT,
CONSTRAINT COD_MANUTENCAO_ENDERECO_FK FOREIGN KEY(COD_MANUTENCAO_ENDERECO_FK) REFERENCES MANUTENCAO(COD_MANUTENCAO)
)
 





-- tabela estoque produtos


CREATE TABLE ESTOQUE_PRODUTOS ( COD_ESTOQUE INT PRIMARY KEY IDENTITY, QUANTIDADE INT, COD_PRODUTO_ESTOQUE_FK INT, COD_ENCOMENDA_ESTOQUE_FK INT,
CONSTRAINT COD_PRODUTO_ESTOQUE_FK FOREIGN KEY(COD_PRODUTO_ESTOQUE_FK) REFERENCES PRODUTO(COD_PRODUTO),
CONSTRAINT COD_ENCOMENDA_ESTOQUE_FK FOREIGN KEY(COD_ENCOMENDA_ESTOQUE_FK) REFERENCES ENCOMENDA(COD_ENCOMENDA)
)


-- tabela fornecedor


CREATE TABLE FORNECEDOR (
COD_FORNECEDOR INT PRIMARY KEY IDENTITY, CNPJ_FORNECEDOR CHAR(14), RAZAO_SOCIAL_FORNECEDOR VARCHAR(100)
)
 






-- tabela hierarquia


CREATE TABLE HIERARQUIA ( COD_HIERARQUIA INT PRIMARY KEY IDENTITY, HIERARQUIA VARCHAR(100)
)
-- tabela mao de obra


CREATE TABLE MAO_DE_OBRA (
MATRICULA INT PRIMARY KEY IDENTITY, NOME VARCHAR(100),
CARGO VARCHAR(100), SALARIO FLOAT, DATA_DEMISSAO DATE,
DESCRICAO_QUALIFICACAO VARCHAR(100), COD_HIERARQUIA_FK INT, COD_PRODUTO_MAO_DE_OBRA_FK INT,
CONSTRAINT COD_HIERARQUIA_FK FOREIGN KEY(COD_HIERARQUIA_FK) REFERENCES HIERARQUIA(COD_HIERARQUIA),
CONSTRAINT COD_PRODUTO_MAO_DE_OBRA_FK FOREIGN KEY (COD_PRODUTO_MAO_DE_OBRA_FK) REFERENCES PRODUTO(COD_PRODUTO)
 

)




-- tabela endereco mao de obra
CREATE TABLE ENDERECO_MAO_DE_OBRA ( COD_ENDERECO INT PRIMARY KEY IDENTITY, RUA VARCHAR(100),
NUMERO INT,
BAIRRO VARCHAR(100), UF CHAR(2),
CEP CHAR(8), MATRICULA_FK INT,
CONSTRAINT MATRICULA_FK FOREIGN KEY(MATRICULA_FK) REFERENCES MAO_DE_OBRA(MATRICULA)
)
-- tabela telefone mao de obra
CREATE TABLE TELEFONE_MAO_DE_OBRA ( COD_TELEFONE_MAO_DE_OBRA INT PRIMARY KEY IDENTITY, DDD CHAR(2),
NUMERO CHAR(9), TIPO VARCHAR(50),
MATRICULA_TELEFONE_FK INT,
CONSTRAINT MATRICULA_TELEFONE_FK FOREIGN KEY(MATRICULA_TELEFONE_FK) REFERENCES MAO_DE_OBRA(MATRICULA)
 

)




CREATE TABLE ENDERECO_FORNECEDOR ( COD_ENDERECO INT PRIMARY KEY IDENTITY, RUA VARCHAR(100),
NUMERO INT,
BAIRRO VARCHAR(100), UF CHAR(2),
CEP CHAR(8), COD_FORNECEDOR_ENDERECO_FK INT,
CONSTRAINT COD_FORNECEDOR_ENDERECO_FK FOREIGN KEY(COD_FORNECEDOR_ENDERECO_FK) REFERENCES FORNECEDOR(COD_FORNECEDOR)
)
-- tabela telefone mao de obra
CREATE TABLE TELEFONE_FORNECEDOR ( COD_TELEFONE_FORNECEDOR INT PRIMARY KEY IDENTITY, DDD CHAR(2),
NUMERO CHAR(9), TIPO VARCHAR(50),
COD_FORNECEDOR_TELEFONE_FK INT,
CONSTRAINT COD_FORNECEDOR_TELEFONE_FK FOREIGN KEY(COD_FORNECEDOR_TELEFONE_FK) REFERENCES FORNECEDOR(COD_FORNECEDOR)
)
 



-- tabela estoque componentes


CREATE TABLE ESTOQUE_COMPONENTES ( COD_ESTOQUE INT PRIMARY KEY IDENTITY, TIPO VARCHAR(100), QUANTIDADE_ESTOQUE FLOAT, UNIDADE_MEDIDA_ESTOQUE FLOAT, COD_FORNECEDOR_ESTOQUE_FK INT, COD_MATERIA_PRIMA_ESTOQUE_FK INT, COD_MATERIAL_DIVERSO_FK INT,
CONSTRAINT COD_FORNECEDOR_ESTOQUE_FK FOREIGN KEY(COD_FORNECEDOR_ESTOQUE_FK) REFERENCES FORNECEDOR(COD_FORNECEDOR),
CONSTRAINT COD_MATERIA_PRIMA_ESTOQUE_FK FOREIGN KEY(COD_MATERIA_PRIMA_ESTOQUE_FK) REFERENCES MATERIA_PRIMA(COD_MATERIA_PRIMA))