-- =====================================================================
-- Music Library Management System  |  MySQL 8.0
-- Lakshay Gupta (2501420048)
-- Run ONE section at a time in MySQL Workbench (select it, then Ctrl+Enter),
-- take the screenshot named in the report, then move to the next section.
-- Run on a fresh database, in this order. Sections marked EXPECTED ERROR
-- are meant to fail: run them alone and screenshot the error.
-- =====================================================================

DROP DATABASE IF EXISTS music_library;
CREATE DATABASE music_library;
USE music_library;

-- ---------- 2.1 Table: genres ----------
CREATE TABLE genres (
    genre_id    INT AUTO_INCREMENT PRIMARY KEY,
    genre_name  VARCHAR(40) NOT NULL UNIQUE
);

DESCRIBE genres;

INSERT INTO genres (genre_id, genre_name) VALUES
(1,'Pop'),(2,'Rock'),(3,'Bollywood'),(4,'Jazz'),
(5,'Electronic'),(6,'Hip-Hop'),(7,'Classical');

SELECT * FROM genres;

-- ---------- 2.2 Table: artists ----------
CREATE TABLE artists (
    artist_id    INT AUTO_INCREMENT PRIMARY KEY,
    artist_name  VARCHAR(100) NOT NULL UNIQUE,
    country      VARCHAR(50)  NOT NULL DEFAULT 'India',
    artist_type  ENUM('SOLO','BAND','DUO','COMPOSER') NOT NULL DEFAULT 'SOLO'
);

DESCRIBE artists;

INSERT INTO artists (artist_id, artist_name, country, artist_type) VALUES
(1,'Coldplay','UK','BAND'),
(2,'Ed Sheeran','UK','SOLO'),
(3,'Taylor Swift','USA','SOLO'),
(4,'The Weeknd','Canada','SOLO'),
(5,'Linkin Park','USA','BAND'),
(6,'A.R. Rahman','India','COMPOSER'),
(7,'Pritam','India','COMPOSER'),
(8,'Miles Davis','USA','SOLO'),
(9,'Daft Punk','France','DUO'),
(10,'Eminem','USA','SOLO'),
(11,'Ludovico Einaudi','Italy','COMPOSER');

SELECT * FROM artists;

-- ---------- 2.3 Table: albums ----------
CREATE TABLE albums (
    album_id      INT AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(120) NOT NULL,
    artist_id     INT NOT NULL,
    release_year  SMALLINT NOT NULL,
    CONSTRAINT fk_album_artist FOREIGN KEY (artist_id) REFERENCES artists(artist_id),
    CONSTRAINT uq_album UNIQUE (artist_id, title),
    CONSTRAINT chk_album_year CHECK (release_year BETWEEN 1900 AND 2100)
);

DESCRIBE albums;

INSERT INTO albums (album_id, title, artist_id, release_year) VALUES
(1,'Parachutes',1,2000),
(2,'A Rush of Blood to the Head',1,2002),
(3,'Viva la Vida or Death and All His Friends',1,2008),
(4,'Divide',2,2017),
(5,'Multiply',2,2014),
(6,'1989',3,2014),
(7,'After Hours',4,2020),
(8,'Hybrid Theory',5,2000),
(9,'Rockstar',6,2011),
(10,'Ae Dil Hai Mushkil',7,2016),
(11,'Kind of Blue',8,1959),
(12,'Discovery',9,2001),
(13,'The Marshall Mathers LP',10,2000),
(14,'Una Mattina',11,2004);

SELECT * FROM albums;

-- ---------- 2.4 Table: tracks ----------
CREATE TABLE tracks (
    track_id      INT AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(120) NOT NULL,
    album_id      INT NOT NULL,
    genre_id      INT NOT NULL,
    duration_sec  SMALLINT NOT NULL,
    CONSTRAINT fk_track_album FOREIGN KEY (album_id) REFERENCES albums(album_id),
    CONSTRAINT fk_track_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    CONSTRAINT uq_track UNIQUE (album_id, title),
    CONSTRAINT chk_track_duration CHECK (duration_sec > 0)
);

DESCRIBE tracks;

INSERT INTO tracks (track_id, title, album_id, genre_id, duration_sec) VALUES
(1,'Yellow',1,2,269),(2,'Trouble',1,2,273),
(3,'Clocks',2,2,307),(4,'The Scientist',2,2,309),
(5,'Viva la Vida',3,2,242),(6,'Violet Hill',3,2,222),
(7,'Shape of You',4,1,234),(8,'Castle on the Hill',4,1,261),(9,'Perfect',4,1,263),
(10,'Thinking Out Loud',5,1,281),(11,'Photograph',5,1,258),
(12,'Shake It Off',6,1,219),(13,'Blank Space',6,1,231),(14,'Style',6,1,231),
(15,'Blinding Lights',7,1,200),(16,'Save Your Tears',7,1,215),(17,'In Your Eyes',7,1,237),
(18,'In the End',8,2,216),(19,'Crawling',8,2,209),(20,'One Step Closer',8,2,157),
(21,'Kun Faya Kun',9,3,473),(22,'Tum Ho',9,3,299),(23,'Sadda Haq',9,3,281),
(24,'Channa Mereya',10,3,289),(25,'Ae Dil Hai Mushkil',10,3,269),(26,'Bulleya',10,3,266),
(27,'So What',11,4,562),(28,'Blue in Green',11,4,337),(29,'All Blues',11,4,693),
(30,'One More Time',12,5,320),(31,'Digital Love',12,5,301),(32,'Harder Better Faster Stronger',12,5,225),
(33,'Stan',13,6,404),(34,'The Real Slim Shady',13,6,284),
(35,'Nuvole Bianche',14,7,357),(36,'Una Mattina',14,7,228);

SELECT * FROM tracks LIMIT 15;

-- ---------- 2.5 Table: users ----------
CREATE TABLE users (
    user_id      INT AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(80)  NOT NULL,
    email        VARCHAR(100) NOT NULL UNIQUE,
    joined_date  DATE NOT NULL DEFAULT (CURRENT_DATE)
);

DESCRIBE users;

INSERT INTO users (user_id, full_name, email, joined_date) VALUES
(1,'Rohit Kumar','rohit.kumar@example.com','2026-01-12'),
(2,'Meera Nair','meera.nair@example.com','2026-01-20'),
(3,'Kabir Anand','kabir.anand@example.com','2026-02-03'),
(4,'Ishita Bose','ishita.bose@example.com','2026-02-14'),
(5,'Dev Malhotra','dev.malhotra@example.com','2026-03-01'),
(6,'Ritika Sood','ritika.sood@example.com','2026-03-18'),
(7,'Aman Verma','aman.verma@example.com','2026-04-05'),
(8,'Tara Kulkarni','tara.kulkarni@example.com','2026-04-22'),
(9,'Siddharth Roy','siddharth.roy@example.com','2026-05-09'),
(10,'Nisha Pillai','nisha.pillai@example.com','2026-05-30'),
(11,'Varun Bhatia','varun.bhatia@example.com','2026-06-15'),
(12,'Pallavi Joshi','pallavi.joshi@example.com','2026-07-02');

SELECT * FROM users LIMIT 12;

-- ---------- 2.6 Table: playlists ----------
CREATE TABLE playlists (
    playlist_id    INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT NOT NULL,
    playlist_name  VARCHAR(80) NOT NULL,
    created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pl_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT uq_pl_user_name UNIQUE (user_id, playlist_name)
);

DESCRIBE playlists;

INSERT INTO playlists (playlist_id, user_id, playlist_name) VALUES
(1,1,'Morning Run'),(2,1,'Study Focus'),(3,2,'Road Trip'),(4,3,'Bollywood Hits'),
(5,4,'Chill Evening'),(6,5,'Workout Mix'),(7,6,'Jazz Nights'),(8,7,'Throwback Rock');

SELECT * FROM playlists;

-- ---------- 2.7 Table: playlist_tracks ----------
CREATE TABLE playlist_tracks (
    playlist_id  INT NOT NULL,
    track_id     INT NOT NULL,
    position     INT NOT NULL,
    added_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, track_id),
    CONSTRAINT fk_pt_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE,
    CONSTRAINT fk_pt_track FOREIGN KEY (track_id) REFERENCES tracks(track_id),
    CONSTRAINT chk_pt_position CHECK (position > 0)
);

DESCRIBE playlist_tracks;

INSERT INTO playlist_tracks (playlist_id, track_id, position) VALUES
(1,15,1),(1,7,2),(1,12,3),(1,18,4),
(2,35,1),(2,28,2),(2,36,3),
(3,5,1),(3,1,2),(3,7,3),(3,15,4),(3,30,5),
(4,24,1),(4,25,2),(4,26,3),(4,21,4),(4,22,5),
(5,9,1),(5,11,2),(5,10,3),(5,4,4),
(6,34,1),(6,20,2),(6,32,3),(6,33,4),
(7,27,1),(7,28,2),(7,29,3),
(8,18,1),(8,19,2),(8,3,3),(8,6,4);

SELECT * FROM playlist_tracks LIMIT 15;

-- ---------- 2.8 Table: play_history ----------
CREATE TABLE play_history (
    play_id    BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    track_id   INT NOT NULL,
    played_at  DATETIME NOT NULL,
    CONSTRAINT fk_ph_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_ph_track FOREIGN KEY (track_id) REFERENCES tracks(track_id)
);

DESCRIBE play_history;

INSERT INTO play_history (user_id, track_id, played_at) VALUES
(1,15,'2026-09-30 08:00:00'),(1,7,'2026-09-30 08:04:00'),(1,12,'2026-09-30 08:07:30'),
(1,18,'2026-09-30 08:11:00'),(1,35,'2026-09-30 21:00:00'),(1,28,'2026-09-30 21:06:00'),
(1,36,'2026-09-30 21:10:00'),(1,15,'2026-10-01 08:01:00'),
(2,5,'2026-09-30 09:15:00'),(2,1,'2026-09-30 09:20:00'),(2,7,'2026-09-30 09:25:00'),
(3,24,'2026-09-30 19:00:00'),(3,25,'2026-09-30 19:05:00'),(3,26,'2026-09-30 19:10:00');

SELECT * FROM play_history LIMIT 14;

-- ---------- 2.9 Bulk data and row counts ----------
-- Bulk data (deterministic). Run AFTER the sample INSERTs, on a fresh database.
USE music_library;
SET SESSION cte_max_recursion_depth = 100000;

-- 300 artists
INSERT INTO artists (artist_name, country, artist_type)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 300)
SELECT CONCAT('Artist ', LPAD(i,4,'0')),
       ELT(1+MOD(i,5),'India','USA','UK','Canada','Germany'),
       ELT(1+MOD(i,4),'SOLO','BAND','DUO','COMPOSER')
FROM n;

-- 600 albums (artist ids 12 to 311)
INSERT INTO albums (title, artist_id, release_year)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 600)
SELECT CONCAT(ELT(1+MOD(i,10),'Midnight','Golden','Electric','Silent','Wild',
                  'Broken','Neon','Crimson','Lonely','Endless'), ' Sessions ', i),
       12 + MOD(i,300),
       1990 + MOD(i,36)
FROM n;

-- 12,000 tracks (album ids 15 to 614)
INSERT INTO tracks (title, album_id, genre_id, duration_sec)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 12000)
SELECT CONCAT(ELT(1+MOD(i,10),'Midnight','Golden','Electric','Silent','Wild',
                  'Broken','Neon','Crimson','Lonely','Endless'), ' ',
              ELT(1+MOD(i DIV 10,10),'Dreams','Road','Heart','Fire','River',
                  'Sky','Echo','Rain','Light','Shadow'), ' ', i),
       15 + MOD(i,600),
       1 + MOD(i,7),
       120 + MOD(i*37,240)
FROM n;

-- 500 users
INSERT INTO users (full_name, email)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 500)
SELECT CONCAT('Listener ', LPAD(i,4,'0')), CONCAT('listener', i, '@example.com')
FROM n;

-- 2,000 playlists
INSERT INTO playlists (user_id, playlist_name)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 2000)
SELECT 1 + MOD(i,512), CONCAT('Mix ', i)
FROM n;

-- 30,000 playlist entries (15 tracks per playlist)
INSERT INTO playlist_tracks (playlist_id, track_id, position)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 30000)
SELECT 9 + (i-1) DIV 15,
       1 + MOD(i*7 + (MOD(i-1,15)+1)*797, 12036),
       MOD(i-1,15) + 1
FROM n;

-- 60,000 plays, all on the 36 sample tracks, with a skewed spread
INSERT INTO play_history (user_id, track_id, played_at)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 60000)
SELECT 1 + MOD(i*7,512),
       1 + LEAST(MOD(i,36), MOD(i DIV 5 + MOD(i,7)*MOD(i,11), 36)),
       DATE_ADD('2026-10-01 00:00:00', INTERVAL i*53 SECOND)
FROM n;

SELECT 'genres' AS table_name, COUNT(*) AS row_count FROM genres
UNION ALL SELECT 'artists', COUNT(*) FROM artists
UNION ALL SELECT 'albums', COUNT(*) FROM albums
UNION ALL SELECT 'tracks', COUNT(*) FROM tracks
UNION ALL SELECT 'users', COUNT(*) FROM users
UNION ALL SELECT 'playlists', COUNT(*) FROM playlists
UNION ALL SELECT 'playlist_tracks', COUNT(*) FROM playlist_tracks
UNION ALL SELECT 'play_history', COUNT(*) FROM play_history;


-- =====================================================================
-- CHAPTER 3
-- =====================================================================

-- ---------- 3.1 Search songs by title ----------
-- Search songs by title (partial match)
SELECT t.track_id, t.title AS track, ar.artist_name, g.genre_name
FROM tracks t
JOIN albums  al ON al.album_id  = t.album_id
JOIN artists ar ON ar.artist_id = al.artist_id
JOIN genres  g  ON g.genre_id   = t.genre_id
WHERE t.title LIKE '%the%'
ORDER BY t.title;

-- ---------- 3.2 Search songs by artist ----------
-- Search songs by artist
SELECT ar.artist_name, al.title AS album, al.release_year, t.title AS track, t.duration_sec
FROM artists ar
JOIN albums al ON al.artist_id = ar.artist_id
JOIN tracks t  ON t.album_id   = al.album_id
WHERE ar.artist_name = 'Coldplay'
ORDER BY al.release_year, t.track_id;

-- ---------- 3.3 Search songs by genre ----------
-- Search songs by genre (sample tracks only: ids 1-36)
SELECT g.genre_name, t.title AS track, ar.artist_name
FROM genres g
JOIN tracks  t  ON t.genre_id   = g.genre_id
JOIN albums  al ON al.album_id  = t.album_id
JOIN artists ar ON ar.artist_id = al.artist_id
WHERE g.genre_name = 'Jazz'
  AND t.track_id <= 36
ORDER BY t.track_id;

-- ---------- 3.4 Library summary per genre ----------
-- Tracks and total minutes per genre
SELECT g.genre_name,
       COUNT(t.track_id)                    AS tracks,
       ROUND(SUM(t.duration_sec) / 60, 1)   AS total_minutes
FROM genres g
LEFT JOIN tracks t ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY tracks DESC;

-- ---------- 3.5 Albums of one artist with runtime ----------
-- Albums of one artist (artist_id 1 = Coldplay)
SELECT al.title, al.release_year,
       COUNT(t.track_id)                AS tracks,
       SEC_TO_TIME(SUM(t.duration_sec)) AS runtime
FROM albums al
LEFT JOIN tracks t ON t.album_id = al.album_id
WHERE al.artist_id = 1
GROUP BY al.album_id, al.title, al.release_year
ORDER BY al.release_year;

-- ---------- 3.6 Music preference analysis: one listener ----------
-- Genre preference of user 1
SELECT g.genre_name, COUNT(*) AS plays
FROM play_history ph
JOIN tracks t ON t.track_id = ph.track_id
JOIN genres g ON g.genre_id = t.genre_id
WHERE ph.user_id = 1
GROUP BY g.genre_id, g.genre_name
ORDER BY plays DESC;

-- ---------- 3.7 Most played tracks overall ----------
-- Top 5 most played tracks
SELECT t.title AS track, ar.artist_name, COUNT(*) AS plays
FROM play_history ph
JOIN tracks  t  ON t.track_id   = ph.track_id
JOIN albums  al ON al.album_id  = t.album_id
JOIN artists ar ON ar.artist_id = al.artist_id
GROUP BY t.track_id, t.title, ar.artist_name
ORDER BY plays DESC
LIMIT 5;

-- =====================================================================
-- CHAPTER 4
-- =====================================================================

-- ---------- 4.1 Create: add an artist, an album and a track ----------
-- Create (INSERT)
INSERT INTO artists (artist_name, country, artist_type)
VALUES ('Demo Artist', 'India', 'SOLO');
SET @demo_artist = LAST_INSERT_ID();

INSERT INTO albums (title, artist_id, release_year)
VALUES ('Demo Album', @demo_artist, 2026);
SET @demo_album = LAST_INSERT_ID();

INSERT INTO tracks (title, album_id, genre_id, duration_sec)
VALUES ('Demo Track', @demo_album, 1, 200);

-- ---------- 4.2 Read: view the new content ----------
-- Read (SELECT)
SELECT ar.artist_name, ar.country, al.title AS album,
       t.title AS track, g.genre_name, t.duration_sec
FROM artists ar
JOIN albums al ON al.artist_id = ar.artist_id
JOIN tracks t  ON t.album_id   = al.album_id
JOIN genres g  ON g.genre_id   = t.genre_id
WHERE ar.artist_name = 'Demo Artist';

-- ---------- 4.3 Update: change artist and track information ----------
-- Update (UPDATE)
UPDATE artists
SET country = 'UK'
WHERE artist_name = 'Demo Artist';

UPDATE tracks
SET genre_id = 5, duration_sec = 215      -- 5 = Electronic
WHERE title = 'Demo Track' AND album_id = @demo_album;

-- ---------- 4.4 Read again: after the update ----------
SELECT ar.artist_name, ar.country, al.title AS album,
       t.title AS track, g.genre_name, t.duration_sec
FROM artists ar
JOIN albums al ON al.artist_id = ar.artist_id
JOIN tracks t  ON t.album_id   = al.album_id
JOIN genres g  ON g.genre_id   = t.genre_id
WHERE ar.artist_name = 'Demo Artist';

-- ---------- 4.5 Delete: rejected by the foreign key ----------
-- EXPECTED ERROR 1451
-- Delete the parent first (this fails)
DELETE FROM artists
WHERE artist_name = 'Demo Artist';

-- ---------- 4.6 Delete: remove the rows in the right order ----------
-- Delete child rows first
DELETE FROM tracks  WHERE album_id  = @demo_album;
DELETE FROM albums  WHERE album_id  = @demo_album;
DELETE FROM artists WHERE artist_id = @demo_artist;

SELECT COUNT(*) AS remaining
FROM artists
WHERE artist_name = 'Demo Artist';

-- ---------- 4.7 Create a playlist ----------
-- Create a playlist
INSERT INTO playlists (user_id, playlist_name)
VALUES (1, 'Weekend Vibes');
SET @pl = LAST_INSERT_ID();

-- ---------- 4.8 Add tracks to the playlist ----------
-- 15 Blinding Lights, 30 One More Time, 1 Yellow,
-- 21 Kun Faya Kun, 27 So What
INSERT INTO playlist_tracks (playlist_id, track_id, position)
VALUES (@pl, 15, 1), (@pl, 30, 2), (@pl, 1, 3),
       (@pl, 21, 4), (@pl, 27, 5);

-- ---------- 4.9 View the playlist in order ----------
SELECT pt.position, t.title AS track, ar.artist_name,
       SEC_TO_TIME(t.duration_sec) AS length
FROM playlist_tracks pt
JOIN tracks  t  ON t.track_id   = pt.track_id
JOIN albums  al ON al.album_id  = t.album_id
JOIN artists ar ON ar.artist_id = al.artist_id
WHERE pt.playlist_id = @pl
ORDER BY pt.position;

-- ---------- 4.10 Playlist total length ----------
SELECT p.playlist_name,
       COUNT(*)                         AS tracks,
       SEC_TO_TIME(SUM(t.duration_sec)) AS total_length
FROM playlists p
JOIN playlist_tracks pt ON pt.playlist_id = p.playlist_id
JOIN tracks t           ON t.track_id     = pt.track_id
WHERE p.playlist_id = @pl
GROUP BY p.playlist_id, p.playlist_name;

-- ---------- 4.11 Remove a track and close the gap (transaction) ----------
START TRANSACTION;

DELETE FROM playlist_tracks
WHERE playlist_id = @pl AND track_id = 1;        -- Yellow, position 3

UPDATE playlist_tracks
SET position = position - 1
WHERE playlist_id = @pl AND position > 3;

COMMIT;

-- ---------- 4.12 Delete the playlist (ON DELETE CASCADE) ----------
DELETE FROM playlists WHERE playlist_id = @pl;

SELECT COUNT(*) AS entries_left
FROM playlist_tracks
WHERE playlist_id = @pl;

-- =====================================================================
-- CHAPTER 5
-- =====================================================================

-- ---------- 5.1 Existing indexes on tracks ----------
SHOW INDEX FROM tracks;

-- ---------- 5.2 Title search with a leading wildcard: EXPLAIN before ----------
EXPLAIN SELECT track_id, title
FROM tracks
WHERE title LIKE '%Heart%';

-- ---------- 5.3 Create a B-tree index on the title ----------
CREATE INDEX idx_tracks_title ON tracks (title);

-- ---------- 5.4 Prefix search: EXPLAIN after the index ----------
EXPLAIN SELECT track_id, title
FROM tracks
WHERE title LIKE 'Midnight%';

-- ---------- 5.5 Leading wildcard again, now that the index exists ----------
EXPLAIN SELECT track_id, title
FROM tracks
WHERE title LIKE '%Heart%';

-- ---------- 5.6 Why a leading wildcard prevents normal index usage ----------

-- ---------- 5.7 Create FULLTEXT indexes on title and artist name ----------
CREATE FULLTEXT INDEX ft_tracks_title ON tracks (title);
CREATE FULLTEXT INDEX ft_artists_name ON artists (artist_name);

-- ---------- 5.8 FULLTEXT search: EXPLAIN ----------
EXPLAIN SELECT track_id, title
FROM tracks
WHERE MATCH(title) AGAINST('Heart' IN NATURAL LANGUAGE MODE);

-- ---------- 5.9 Combined search by track title or artist name ----------
SELECT t.track_id, t.title AS track, ar.artist_name
FROM tracks t
JOIN albums  al ON al.album_id  = t.album_id
JOIN artists ar ON ar.artist_id = al.artist_id
WHERE MATCH(t.title) AGAINST('Midnight')
UNION
SELECT t.track_id, t.title, ar.artist_name
FROM artists ar
JOIN albums al ON al.artist_id = ar.artist_id
JOIN tracks t  ON t.album_id   = al.album_id
WHERE MATCH(ar.artist_name) AGAINST('Coldplay')
LIMIT 20;

-- ---------- 5.10 Comparison of the three search methods ----------

-- ---------- 5.11 Playlist order: EXPLAIN before the index ----------
EXPLAIN SELECT track_id, position
FROM playlist_tracks
WHERE playlist_id = 500
ORDER BY position;

-- ---------- 5.12 Create the composite index ----------
CREATE INDEX idx_pt_playlist_pos
ON playlist_tracks (playlist_id, position);

-- ---------- 5.13 Playlist order: EXPLAIN after the index ----------
EXPLAIN SELECT track_id, position
FROM playlist_tracks
WHERE playlist_id = 500
ORDER BY position;

-- ---------- 5.14 Why this column order (playlist_id, position) ----------

-- ---------- 5.15 A query that does NOT use the composite index ----------
EXPLAIN SELECT playlist_id, track_id
FROM playlist_tracks
WHERE position = 3;

-- =====================================================================
-- CHAPTER 6
-- =====================================================================

-- ---------- 6.1 View 1: track details ----------
CREATE VIEW v_track_details AS
SELECT t.track_id, t.title AS track_title,
       al.album_id, al.title AS album_title, al.release_year,
       ar.artist_id, ar.artist_name,
       g.genre_name, t.duration_sec
FROM tracks t
JOIN albums  al ON al.album_id  = t.album_id
JOIN artists ar ON ar.artist_id = al.artist_id
JOIN genres  g  ON g.genre_id   = t.genre_id;

SELECT * FROM v_track_details WHERE track_id <= 10;

-- ---------- 6.2 Song search without the view ----------
SELECT t.title AS track, al.title AS album, al.release_year
FROM tracks t
JOIN albums  al ON al.album_id  = t.album_id
JOIN artists ar ON ar.artist_id = al.artist_id
JOIN genres  g  ON g.genre_id   = t.genre_id
WHERE ar.artist_name = 'Coldplay'
  AND g.genre_name   = 'Rock';

-- ---------- 6.3 Song search with the view ----------
SELECT track_title, album_title, release_year
FROM v_track_details
WHERE artist_name = 'Coldplay'
  AND genre_name  = 'Rock';

-- ---------- 6.4 View 2: top artists by play count ----------
CREATE VIEW v_top_artists AS
SELECT ar.artist_id, ar.artist_name, COUNT(ph.play_id) AS total_plays
FROM artists ar
JOIN albums  al ON al.artist_id = ar.artist_id
JOIN tracks  t  ON t.album_id   = al.album_id
JOIN play_history ph ON ph.track_id = t.track_id
GROUP BY ar.artist_id, ar.artist_name;

SELECT * FROM v_top_artists
ORDER BY total_plays DESC
LIMIT 5;

-- ---------- 6.5 Proof that View 2 is not updatable ----------
-- EXPECTED ERROR 1288
UPDATE v_top_artists
SET total_plays = 0
WHERE artist_id = 1;

-- ---------- 6.6 Altering an underlying table: adding a column ----------
ALTER TABLE albums ADD COLUMN label VARCHAR(60) NULL;

SELECT * FROM v_track_details LIMIT 3;

-- ---------- 6.7 Altering an underlying table: renaming a column ----------
-- EXPECTED ERROR 1356 (from the SELECT)
ALTER TABLE genres
RENAME COLUMN genre_name TO genre_title;

SELECT * FROM v_track_details LIMIT 3;

-- ---------- 6.8 Fix the view and clean up ----------
ALTER TABLE genres RENAME COLUMN genre_title TO genre_name;
ALTER TABLE albums DROP COLUMN label;

SELECT track_title, genre_name FROM v_track_details LIMIT 3;

-- =====================================================================
-- CHAPTER 7
-- =====================================================================

-- ---------- 7.1 Top 5 tracks per genre (DENSE_RANK) ----------
WITH track_plays AS (
    SELECT t.track_id, t.title, t.genre_id, COUNT(*) AS plays
    FROM tracks t
    JOIN play_history ph ON ph.track_id = t.track_id
    GROUP BY t.track_id, t.title, t.genre_id
),
ranked AS (
    SELECT g.genre_name, tp.title, tp.plays,
           DENSE_RANK() OVER (PARTITION BY tp.genre_id
                              ORDER BY tp.plays DESC) AS genre_rank
    FROM track_plays tp
    JOIN genres g ON g.genre_id = tp.genre_id
)
SELECT genre_name, genre_rank, title, plays
FROM ranked
WHERE genre_rank <= 5
ORDER BY genre_name, genre_rank, title;

-- ---------- 7.2 Next track played (LEAD) ----------
SELECT ph.played_at,
       t.title AS current_track,
       LEAD(t.title) OVER (PARTITION BY ph.user_id
                           ORDER BY ph.played_at) AS next_track
FROM play_history ph
JOIN tracks t ON t.track_id = ph.track_id
WHERE ph.user_id = 1
ORDER BY ph.played_at
LIMIT 10;

-- ---------- 7.3 Running total of plays per day (SUM OVER) ----------
WITH daily AS (
    SELECT DATE(played_at) AS play_date, COUNT(*) AS plays
    FROM play_history
    GROUP BY DATE(played_at)
)
SELECT play_date, plays,
       SUM(plays) OVER (ORDER BY play_date) AS running_total
FROM daily
ORDER BY play_date
LIMIT 15;

-- ---------- 7.4 Share of each track in its album (SUM OVER PARTITION BY) ----------
WITH tp AS (
    SELECT t.track_id, t.title, t.album_id, COUNT(*) AS plays
    FROM tracks t
    JOIN play_history ph ON ph.track_id = t.track_id
    GROUP BY t.track_id, t.title, t.album_id
)
SELECT al.title AS album, tp.title AS track, tp.plays,
       SUM(tp.plays) OVER (PARTITION BY tp.album_id) AS album_plays,
       ROUND(100 * tp.plays /
             SUM(tp.plays) OVER (PARTITION BY tp.album_id), 2) AS pct_of_album
FROM tp
JOIN albums al ON al.album_id = tp.album_id
ORDER BY al.title, pct_of_album DESC;
