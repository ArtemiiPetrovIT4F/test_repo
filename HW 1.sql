-- Задание 1.  
-- Загружаем таблицы. Задания будут выполнены в новой схеме bonds. 
-- 1.1 Создаём таблицу listing_task, в качестве ключа используем уникальный ID.

DROP TABLE if exists bonds.listing;

CREATE TABLE bonds.listing
(
    "ID" bigint NOT NULL,
    "ISIN" text COLLATE pg_catalog."default",
    "Platform" text COLLATE pg_catalog."default" NOT NULL,
    "Section" text COLLATE pg_catalog."default",
    CONSTRAINT listing_pkey PRIMARY KEY ("ID")
	
)
TABLESPACE pg_default;
ALTER DATABASE postgres SET datestyle TO "ISO, DMY";
ALTER TABLE bonds.listing
    OWNER to postgres;
    
-- Подготовка данных:
-- Исходные данные сохраняем в формате .csv, разделитель по дефолту ";"
-- Можно удалить лист fields
-- Далее загружаем данные

COPY  bonds.listing
FROM 'C:\Users\Public\listing.csv' 
	DELIMITERS ';' CSV HEADER ENCODING 'UTF8';

-- 1.2 Создаём таблицу quotes_task, в качестве ключей используем ID и TIME.

DROP TABLE if exists bonds.quotes;

CREATE TABLE bonds.quotes
(
    "ID" bigint NOT NULL,
    "TIME" date NOT NULL,
    "ACCRUEDINT" real,
    "ASK" real,
    "ASK_SIZE" real,
    "ASK_SIZE_TOTAL" bigint,
    "AVGE_PRCE" real,
    "BID" real,
    "BID_SIZE" real,
    "BID_SIZE_TOTAL" bigint,
    "BOARDID" text COLLATE pg_catalog."default",
    "BOARDNAME" text COLLATE pg_catalog."default",
    "BUYBACKDATE" date,
    "BUYBACKPRICE" real,
    "CBR_LOMBARD" real,
    "CBR_PLEDGE" real,
    "CLOSE" real,
    "CPN" real,
    "CPN_DATE" date,
    "CPN_PERIOD" bigint,
    "DEAL_ACC" bigint,
    "FACEVALUE" real,
    "ISIN" text COLLATE pg_catalog."default",
    "ISSUER" text COLLATE pg_catalog."default",
    "ISSUESIZE" bigint,
    "MAT_DATE" date,
    "MPRICE" real,
    "MPRICE2" real,
    "SPREAD" real,
    "VOL_ACC" bigint,
    "Y2O_ASK" real,
    "Y2O_BID" real,
	"YIELD_ASK" real,
    "YIELD_BID" real,
    CONSTRAINT quotes_pkey PRIMARY KEY ("ID", "TIME")
)

TABLESPACE pg_default;

ALTER TABLE bonds.quotes
    OWNER to postgres;
    
    
    -- Подготовка данных:
    -- меняем разделитель с запятой на точку и сохраняем в формате .csv
    -- в столбце М формат ячеек дата и выбираем тип «дд.мм.гг чч.мм» 
    -- в столбце Y формат данных меняем на числовой и скрываем появившиеся запятые
    -- в столбце AD формат данных меняем на числовой и скрываем появившиеся запятые
    -- можно удалить лист fields
    
COPY bonds.quotes
FROM 'C:\Users\Public\quotes.csv'
DELIMITERS ';' CSV HEADER ENCODING 'UTF8';
    
 -- 1.3 Создаём таблицу bonds.bond_description, в качестве ключей используем ISIN, RegCode, NRD Code.
 
 DROP TABLE if exists bonds.bond_description;

CREATE TABLE bonds.bond_description
(
    "ISIN, RegCode, NRDCode" text COLLATE pg_catalog."default" NOT NULL,
    "FinToolType" text COLLATE pg_catalog."default",
    "SecurityType" text COLLATE pg_catalog."default",
    "SecurityKind" text COLLATE pg_catalog."default",
    "CouponType" text COLLATE pg_catalog."default",
    "RateTypeNameRus_NRD" text COLLATE pg_catalog."default",
    "CouponTypeName_NRD" text COLLATE pg_catalog."default",
    "HaveOffer" boolean,
    "AmortisedMty" boolean,
    "MaturityGroup" text COLLATE pg_catalog."default",
    "IsConvertible" boolean,
    "ISINCode" text COLLATE pg_catalog."default",
    "Status" text COLLATE pg_catalog."default",
    "HaveDefault" boolean,
    "IsLombardCBR_NRD" boolean,
    "IsQualified_NRD" boolean,
    "ForMarketBonds_NRD" boolean,
    "MicexList_NRD" text COLLATE pg_catalog."default",
    "Basis" text COLLATE pg_catalog."default",
    "Basis_NRD" text COLLATE pg_catalog."default",
    "Base_Month" text COLLATE pg_catalog."default",
    "Base_Year" text COLLATE pg_catalog."default",
    "Coupon_Period_Base_ID" bigint,
    "AccruedintCalcType" boolean,
    "IsGuaranteed" boolean,
    "GuaranteeType" text COLLATE pg_catalog."default",
    "GuaranteeAmount" text COLLATE pg_catalog."default",
	"GuarantVal" bigint,
    "Securitization" text COLLATE pg_catalog."default",
    "CouponPerYear" integer,
    "Cp_Type_ID" integer,
    "NumCoupons" integer,
    "NumCoupons_M" integer,
    "NumCoupons_NRD" integer,
    "Country" text COLLATE pg_catalog."default",
    "FaceFTName" text COLLATE pg_catalog."default",
    "FaceFTName_M" integer,
    "FaceFTName_NRD" text COLLATE pg_catalog."default",
    "FaceValue" real,
    "FaceValue_M" integer,
    "FaceValue_NRD" real,
    "CurrentFaceValue_NRD" real,
    "BorrowerName" text COLLATE pg_catalog."default",
    "BorrowerOKPO" bigint,
    "BorrowerSector" text COLLATE pg_catalog."default",
    "BorrowerUID" bigint,
    "IssuerName" text COLLATE pg_catalog."default",
    "IssuerName_NRD" text COLLATE pg_catalog."default",
    "IssuerOKPO" bigint,
    "NumGuarantors" integer,
    "EndMtyDate" date,
    CONSTRAINT bond_description_pkey PRIMARY KEY ("ISIN, RegCode, NRDCode")
)
TABLESPACE pg_default;
	ALTER TABLE bonds.bond_description
    OWNER to postgres;
    
    -- Подготовка данных:
    -- меняем разделитель с запятой на точку и сохраняем в формате .csv
    -- в столбцах H, I, K формат данных меняем на "общий"
    -- в столбце AB формат данных меняем на числовой и скрываем появившиеся запятые
    -- в столбце AM формат данных меняем на числовой и скрываем появившиеся запятые
    -- в столбце AY формат данных меняем на краткий формат даты
    
COPY bonds.bond_description
FROM 'C:\Users\Public\bond_description.csv'
DELIMITERS ';' CSV HEADER ENCODING 'UTF8';

-- Задание 2. Выносим необходимую информацию в таблицу listing.
-- Создаём столбцы в таблице listing
ALTER TABLE bonds.listing
ADD COLUMN "IssuerName" text, 
ADD COLUMN "IssuerName_NRD" text, 
ADD COLUMN "IssuerOKPO" bigint;

-- Заполняем созданные столбцы данными

UPDATE bonds.listing
SET "IssuerName" = bonds.bond_description."IssuerName",
"IssuerName_NRD" = bonds.bond_description."IssuerName_NRD",
"IssuerOKPO" = bonds.bond_description."IssuerOKPO"
FROM bonds.bond_description
WHERE bonds.listing."ISIN" = bonds.bond_description."ISINCode";

-- Создаём столбцы для внесения информации о площадке

ALTER TABLE bonds.listing
ADD COLUMN "BOARDID" text, 
ADD COLUMN "BOARDNAME" text;

-- Заполняем их данными

UPDATE bonds.listing
SET "BOARDID" = bonds.quotes."BOARDID",
"BOARDNAME" = bonds.quotes."BOARDNAME"
FROM bonds.quotes
WHERE bonds.listing."ISIN" = bonds.quotes."ISIN";

-- Задание 3. В данном задании главной таблицей является listing, дочерней будет bond_description
-- Создаём столбец-идентификатор эмитента и заполняем его данными

ALTER TABLE bonds.bond_description
ADD COLUMN "Issuer_ID" bigint;
UPDATE bonds.bond_description
SET "Issuer_ID" = bonds.listing."ID"
FROM bonds.listing
WHERE bonds.listing."ISIN" = bonds.bond_description."ISINCode";

-- Задаём внешний ключ для таблицы bond_description

ALTER TABLE bonds.bond_description
ADD CONSTRAINT for_key_1 FOREIGN KEY ("Issuer_ID") REFERENCES bonds.listing ("ID");

-- добавляем уникальный ID

INSERT INTO bonds.listing
SELECT b."ID", b."ISIN", b."BOARDNAME", b."BOARDID"
FROM (SELECT DISTINCT bonds.quotes."ID", bonds.quotes."ISIN", bonds.quotes."BOARDNAME", bonds.quotes."BOARDID"
	  FROM bonds.quotes
	  WHERE bonds.quotes."ID" NOT IN (SELECT "ID" 
	       FROM bonds.listing)) as b;
                                      
-- добавляем внешний ключ для связи listing и quotes

ALTER TABLE bonds.quotes
ADD FOREIGN KEY ("ID") REFERENCES bonds.listing ("ID"); 

-- Задание 4. 

-- 1) подсчёт bidов 
SELECT "ISIN", count(*) as "num_bid"
FROM bonds.quotes
GROUP BY "ISIN";

-- 2) подсчёт not null bidов
SELECT "ISIN", count(*) AS "not_null_bid"
FROM bonds.quotes
WHERE "BID" IS NOT NULL
GROUP BY "ISIN";

-- 3) подсчёт доли not_null_bids
SELECT DISTINCT a."ISIN", b."not_null_bid"::float / a."num_bid"::float as "nun_ratio"
FROM (
	SELECT "ISIN", count(*) as "num_bid"
	FROM bonds.quotes
	GROUP BY "ISIN"
) as a
INNER JOIN (SELECT "ISIN", count(*) AS "not_null_bid"
			FROM bonds.quotes
			WHERE "BID" IS NOT NULL
			GROUP BY "ISIN"
) as b
ON a."ISIN"=b."ISIN"
WHERE (b."not_null_bid"::float / a."num_bid"::float) >= 0.9;

-- 4) платформа и режим торгов

SELECT "ISIN", "IssuerName"
FROM bonds.listing
WHERE "Platform" = 'Московская Биржа ' AND "Section" = ' Основной';


-- 5) итоговый запрос

SELECT DISTINCT c."ISIN", c."nun_ratio", d."IssuerName" as "Issuer"
FROM (SELECT DISTINCT a."ISIN", b."not_null_bid"::float / a."num_bid"::float as "nun_ratio"
	FROM (
	SELECT "ISIN", count(*) as "num_bid"
	FROM bonds.quotes
	GROUP BY "ISIN"
) as a
INNER JOIN (SELECT "ISIN", count(*) AS "not_null_bid"
			FROM bonds.quotes
			WHERE "BID" IS NOT NULL
			GROUP BY "ISIN"
) as b
ON a."ISIN"=b."ISIN"
WHERE (b."not_null_bid"::float / a."num_bid"::float) >= 0.9) as c
INNER JOIN (SELECT "ISIN", "IssuerName"
FROM bonds.listing
WHERE "Platform" = 'Московская Биржа ' AND "Section" = ' Основной'
) as d
ON c."ISIN" = d."ISIN";
