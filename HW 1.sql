DROP TABLE if exists bonds.listing_task;

CREATE TABLE bonds.listing_task
(
    "ID" bigint NOT NULL,
    "ISIN" text COLLATE pg_catalog."default",
    "Platform" text COLLATE pg_catalog."default" NOT NULL,
    "Section" text COLLATE pg_catalog."default",
    CONSTRAINT listing_task_pkey PRIMARY KEY ("ID")
)
TABLESPACE pg_default;
ALTER TABLE bonds.listing_task
    OWNER to postgres;
