-- Active: 1747402851514@@127.0.0.1@3001@conservation_db

                        -------------- Table schema -----------------

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
    "sighting_time" TIMESTAMPTZ,
    "location" VARCHAR(62) NOT NULL,
    "notes" TEXT,

    PRIMARY KEY ("sighting_id"),
    FOREIGN KEY ("ranger_id") REFERENCES ranger ("ranger_id"),
    FOREIGN KEY ("species_id") REFERENCES specie ("species_id")
);

                    -------------- data insertion ----------------

-- renger data
INSERT INTO ranger ("ranger_id", "name", "region") VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range')

-- species data
INSERT INTO specie ("species_id", "common_name", "scientific_name", "discovery_date", "conservation_status") VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- sightings data
INSERT INTO sighting ("sighting_id", "species_id", "ranger_id", "location", "sighting_time", "notes") VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

                            -------------- qureies ---------------

-- problem-1
INSERT INTO ranger ("ranger_id" ,"name", "region") VALUES
(4, 'Derek Fox', 'Coastal Plains');

-- problem-2
SELECT COUNT(DISTINCT "species_id") as "unique_species_count" FROM sighting;

-- problem-3
SELECT * FROM sighting
WHERE "location" ILIKE '%pass';

-- problem-4
SELECT ranger."name", COUNT(sighting."sighting_id") as "total_sightings" from ranger
LEFT JOIN sighting on ranger."ranger_id" = sighting."ranger_id"
GROUP BY ranger."ranger_id";

-- problem-5
SELECT "common_name" FROM specie
LEFT JOIN sighting on specie."species_id" = sighting."species_id"
WHERE sighting."sighting_id" IS NULL;

-- problem-6
SELECT "common_name", "sighting_time", "name" FROM sighting as si
JOIN ranger as rn ON rn."ranger_id" = si."ranger_id"
JOIN specie as sp ON sp."species_id" = si."species_id"
ORDER BY si."sighting_time" DESC
LIMIT 2;

-- problem-7
UPDATE specie
SET "conservation_status" = 'Historic'
WHERE EXTRACT(YEAR FROM "discovery_date") < 1800;

-- problem-8
CREATE OR REPLACE FUNCTION check_time(twz TIMESTAMPTZ)
RETURNS TEXT 
AS
$$
    DECLARE
        time_of_day TEXT;
    BEGIN
        IF EXTRACT(HOUR from twz) BETWEEN 6 AND 11 THEN
            time_of_day := 'Morning';
        ELSEIF EXTRACT(HOUR from twz) BETWEEN 12 AND 17 THEN
            time_of_day := 'Afternoon';
        ELSEIF EXTRACT(HOUR from twz) >= 18 THEN
            time_of_day := 'Evening';
        END IF;
        RETURN time_of_day;
    END;
$$ LANGUAGE PLPGSQL;

SELECT "sighting_id", check_time("sighting_time") as "time_of_day" FROM sighting;

-- problem-9
DELETE FROM ranger
WHERE "ranger_id" NOT IN (
    SELECT "ranger_id" FROM sighting
);
