    SELECT * FROM animals WHERE name LIKE '%mon';
    SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-12-31';
    SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
    SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
    SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
    SELECT * FROM animals WHERE neutered;
    SELECT * FROM animals WHERE name != 'Gabumon';
    SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

    BEGIN;
    UPDATE animals
    SET species = 'unspecified';
    ROLLBACK;
    SELECT * FROM animals;

    BEGIN;
    UPDATE animals
    SET species = 'digimon'
    WHERE name LIKE '%mon';
    UPDATE animals
    SET species = 'pokemon'
    WHERE species IS NULL;
    COMMIT;
    SELECT * FROM animals;

    BEGIN;
    DELETE FROM animals;
    ROLLBACK;
    SELECT * FROM animals;

    BEGIN;
    DELETE FROM animals
    WHERE date_of_birth > '2022-1-1';
    SAVEPOINT point_1;
    UPDATE animals
    SET weight_kg = weight_kg * -1;
    ROLLBACK TO point_1;
    UPDATE animals
    SET weight_kg = weight_kg * -1
    WHERE weight_kg < 0;
    COMMIT;
    SELECT * FROM animals;

    -- Total animals
    SELECT COUNT(*) FROM animals;
    -- Animals that don't escape
    SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
    -- Average weight
    SELECT AVG(weight_kg) FROM animals;
    -- Escapes by neutered and not neutered
    SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
    -- Max and Min weight of each species
    SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
    -- Avg escapes per type of those born between 1990 and 2000
    SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-12-31' GROUP BY species;

    SELECT animals.name FROM owners
    JOIN animals ON owners.id = animals.owner_id
    WHERE owners.full_name = 'Melody Pond';

    SELECT animals.name FROM animals
    JOIN species on animals.species_id = species.id
    WHERE species.name = 'Pokemon';

    SELECT owners.full_name, animals.name FROM owners
    LEFT JOIN animals on animals.owner_id = owners.id;

    SELECT species.name, COUNT(*) FROM animals
    JOIN species ON species.id = animals.species_id
    GROUP BY species.name;
    -- Digimons owned by Jennifer Orwell
    SELECT animals.name FROM animals
    JOIN owners ON owners.id = animals.owner_id
    JOIN species ON species.id = animals.species_id
    WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
    -- Animals owned by Dean that haven't tried to escape
    SELECT animals.name FROM animals
    JOIN owners ON owners.id = animals.owner_id
    WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
    -- Owner with most animals
    SELECT owners.full_name, COUNT(*) FROM owners
    JOIN animals ON animals.owner_id = owners.id
    GROUP BY owners.full_name ORDER BY COUNT(*) DESC
    LIMIT 1;

    -- Last animal seen by William
    SELECT a.name, v.date_of_visit FROM visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN vets b ON v.vet_id = b.id
    WHERE b.name = 'William Tatcher'
    ORDER BY v.date_of_visit DESC
    LIMIT 1;

    SELECT COUNT(*) FROM visits v
    JOIN animals a ON v.animal_id = a.id
    JOIN vets b ON v.vet_id = b.id
    WHERE b.name = 'Stephanie Mendez';

    SELECT v.name, t.name FROM vets v
    LEFT JOIN specializations s ON v.id = s.vet_id
    LEFT JOIN species t ON t.id = s.species_id;

    SELECT a.name, j.date_of_visit FROM animals a
    JOIN visits j ON j.animal_id = a.id
    JOIN vets v ON j.vet_id = v.id
    WHERE v.name = 'Stephanie Mendez' AND
    j.date_of_visit BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020';

    SELECT a.name, COUNT(*) FROM animals a
    JOIN visits j ON a.id = j.animal_id
    GROUP BY a.name
    ORDER BY COUNT(*) DESC LIMIT 1;

    SELECT a.name, j.date_of_visit FROM vets v
    JOIN visits j ON v.id = j.vet_id
    JOIN animals a ON a.id = j.animal_id
    WHERE v.name = 'Maisy Smith'
    ORDER BY j.date_of_visit
    LIMIT 1;

    SELECT j.date_of_visit, v.*, a.* FROM vets v
    JOIN visits j ON j.vet_id = v.id
    JOIN animals a ON j.animal_id = a.id
    ORDER BY j.date_of_visit DESC LIMIT 1;

    SELECT v.name, COUNT(*) FROM vets v
    JOIN visits j ON j.vet_id = v.id
    JOIN animals a ON j.animal_id = a.id
    LEFT JOIN specializations s ON s.vet_id = v.id
    WHERE s.species_id != a.species_id OR s.species_id IS NULL
    GROUP BY v.name;

    SELECT s.name, COUNT(*) FROM vets v
    JOIN visits j ON j.vet_id = v.id
    JOIN animals a ON j.animal_id = a.id
    JOIN species s ON a.species_id = s.id
    WHERE v.name = 'Maisy Smith'
    GROUP BY s.name ORDER BY COUNT(*) DESC LIMIT 1;
