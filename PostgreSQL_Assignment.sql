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

-- data insertion

-- renger data
INSERT INTO ranger VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range')

-- species data
INSERT INTO specie VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- sightings Table
INSERT INTO sighting ("sighting_id", "species_id", "ranger_id", "location", "sighting_time", "notes") VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

