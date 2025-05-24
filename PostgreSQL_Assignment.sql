-- Active: 1747402851514@@127.0.0.1@3001@conservation_db

-- Table schema

-- rengers table
CREATE TABLE ranger (
    "ranger_id" SERIAL,
    "name" VARCHAR(32) NOT NULL,
    "region" VARCHAR(64) NOT NULL,

    PRIMARY KEY ("ranger_id")
);

-- species table
CREATE TABLE specie (
    "species_id" SERIAL,
    "common_name" VARCHAR(62),
    "scientific_name" VARCHAR(62) NOT NULL,
    "discovery_date" TIMESTAMP,
    "conservation_status" VARCHAR(20),

    PRIMARY KEY ("species_id")
);

-- sighting table
CREATE TABLE sighting (
    "sighting_id" SERIAL,
    "ranger_id" INT NOT NULL,
    "species_id" INT NOT NULL,
    "sighting_time" TIMESTAMP,
    "location" VARCHAR(62) NOT NULL,
    "notes" TEXT,

    PRIMARY KEY ("sighting_id"),
    FOREIGN KEY ("ranger_id") REFERENCES ranger ("ranger_id"),
    FOREIGN KEY ("species_id") REFERENCES specie ("species_id")
);

