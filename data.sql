  /* Populate database with sample data. */

  INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
  VALUES
  ('Agumon', 'Feb 3, 2020', 10.23,'true', 0 ),
  ('Gabumon', 'Nov 15, 2018', 8, 'true', 2),
  ('Pikachu', 'Jan 7, 2021', 15.04, 'false', 1),
  ('Devimon', 'May 12, 2017', 11, 'true', 5),
  ('Charmander', 'Feb 8, 2020', -11, 'false', 0),
  ('Plantmon', 'Nov 15 2021', -5.7, 'true', 2),
  ('Squirtle', 'Apr 2, 1993', -12.13, 'false', 3),
  ('Angemon', 'Jun 12, 2005', -45, 'true', 1),
  ('Boarmon', 'Jun 7, 2005', 20.4, 'true', 7),
  ('Blossom', 'Oct 13, 1998', 17, 'true', 3),
  ('Ditto', 'May 14, 2022', 22, 'true', 4);


  INSERT INTO owners (full_name, age)
  VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

  INSERT INTO species (name)
  VALUES ('Pokemon'), ('Digimon');

  BEGIN;
  UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
  WHERE name LIKE '%mon';
  UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
  WHERE species_id IS NULL;
  COMMIT;

  BEGIN;
  UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHERE name = 'Agumon';
  UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHERE name = 'Gabumon' OR name = 'Pikachu';
  UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
  UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  WHERE name = 'Angemon' OR name = 'Boarmon';
  UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
  WHERE name = 'Devimon' OR name = 'Plantmon';
  COMMIT;
