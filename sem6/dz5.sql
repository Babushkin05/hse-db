## 1. Создание таблицы Authors

CREATE TABLE Authors (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_year INT
);

## 2. Создание таблицы Books и добавление данных

-- 1. Создать таблицу
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publication_year INT,
    author_id INT REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- 2. Добавить данные
INSERT INTO Authors (full_name, birth_year)
VALUES ('Александр Пушкин', 1799);

INSERT INTO Books (title, publication_year, author_id)
VALUES ('Евгений Онегин', 1833, 
        (SELECT author_id FROM Authors WHERE full_name = 'Александр Пушкин'));

## 3. Разрешить книги без автора и добавить жанр

-- 1. Разрешить author_id быть NULL
ALTER TABLE Books DROP CONSTRAINT books_author_id_fkey;

ALTER TABLE Books
ALTER COLUMN author_id DROP NOT NULL,
ADD CONSTRAINT books_author_id_fkey
FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE;

-- 2. Добавить поле genre
ALTER TABLE Books
ADD COLUMN genre VARCHAR(50);

-- 3. Добавить две новые книги одной командой
INSERT INTO Books (title, publication_year, author_id, genre)
VALUES
('Сказки народов мира', 1980, NULL, 'Фольклор'),
('Пиковая дама', 1834, 
    (SELECT author_id FROM Authors WHERE full_name = 'Александр Пушкин'), 
    'Повесть');

## 4. Создание таблицы Reviews и добавление нового отзыва

-- 1. Создать таблицу Reviews
CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Books(book_id) ON DELETE CASCADE,
    reviewer_name VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    review_text TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Добавить отзыв и вернуть review_id и created_at
INSERT INTO Reviews (book_id, reviewer_name, rating, review_text)
VALUES (
    (SELECT book_id FROM Books WHERE title = 'Евгений Онегин'),
    'Белинский',
    5,
    'Энциклопедия русской жизни'
)
RETURNING review_id, created_at;

## 5. Добавление рейтинга авторов и расчет среднего значения

-- 1. Добавить колонку average_rating
ALTER TABLE Authors
ADD COLUMN average_rating NUMERIC(4,2);

-- 2. Выполнить расчет и обновление рейтинга
BEGIN;

UPDATE Authors a
SET average_rating = sub.avg_rating
FROM (
    SELECT
        b.author_id,
        ROUND(AVG(r.rating)::numeric, 2) AS avg_rating
    FROM Reviews r
    JOIN Books b ON r.book_id = b.book_id
    WHERE b.author_id IS NOT NULL
    GROUP BY b.author_id
) AS sub
WHERE a.author_id = sub.author_id;

COMMIT;
