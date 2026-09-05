/*
DROP TABLE IF EXISTS fact_ticket_sales CASCADE;
DROP TABLE IF EXISTS dim_date CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS dim_event CASCADE;
DROP TABLE IF EXISTS dim_seat CASCADE;
DROP TABLE IF EXISTS dim_order CASCADE;
DROP TABLE IF EXISTS dim_venue CASCADE;
*/

/*Описание:
- Таблицы измерений (dim) используют суррогатные ключи с суффиксом _sk.
- Оригинальные ключи хранятся с суффиксом _id.
- Все денежные суммы приведены к руб.
*/

-- tables of dementions

--date_sk формируется как числовой формат YYYYMMDD (например, 20260701) 


CREATE TABLE dim_date (
    date_sk INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    year SMALLINT NOT NULL,
    month SMALLINT NOT NULL,
    day SMALLINT NOT NULL,
    week SMALLINT NOT NULL
);

CREATE TABLE dim_customer (
    customer_sk INTEGER PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    full_name VARCHAR(150),
    birth_date DATE,
    country VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE dim_event (
    event_sk INTEGER PRIMARY KEY,
    event_id VARCHAR(50) NOT NULL,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(50),
    genre VARCHAR(50),
    start_time TIME
);

CREATE TABLE dim_seat (
    seat_sk INTEGER PRIMARY KEY,
    seat_type VARCHAR(50) NOT NULL,
);

CREATE TABLE dim_order (
    order_sk INTEGER PRIMARY KEY,
    way_to_pay VARCHAR(30),
    sales_channel VARCHAR(30)
);

CREATE TABLE dim_venue (
    venue_sk INTEGER PRIMARY KEY,
    venue_id VARCHAR(50) NOT NULL,
    name VARCHAR(150) NOT NULL,
    capacity INTEGER,
    country VARCHAR(100),
    city VARCHAR(100)
);

--fact table 

--одна строка = один проданный билет в одном заказе.

CREATE TABLE fact_ticket_sales (
    sale_date_key INTEGER REFERENCES dim_date(date_sk),
    event_date_key INTEGER REFERENCES dim_date(date_sk),
    customer_key INTEGER REFERENCES dim_customer(customer_sk),
    event_key INTEGER REFERENCES dim_event(event_sk),
    seat_key INTEGER REFERENCES dim_seat(seat_sk),
    venue_key INTEGER REFERENCES dim_venue(venue_sk),
    order_context_key INTEGER REFERENCES dim_order(order_sk),
    
--уникальные идентификаторы из транзакционной системы
    order_id UUID NOT NULL,
    ticket_id UUID NOT NULL,
	seat_code VARCHAR(20),
    
--метрики    
    value_amount DECIMAL(10,2),  -- стоимость ОДНОГО билета
    service_fee_amount DECIMAL(10,2), --сервисный сбор 
    discount_amount DECIMAL(10,2), --скидка
    total_amount DECIMAL(10,2) --итого к оплате за ОДИН билет
);

INSERT INTO dim_date (date_sk, full_date, year, month, day, week) 
	VALUES
	(20260701, '2026-07-01', 2026, 7, 1, 27),
	(20260715, '2026-07-15', 2026, 7, 15, 29),
	(20260801, '2026-08-01', 2026, 8, 1, 31),
	(20260810, '2026-08-10', 2026, 8, 10, 33),
	(20260820, '2026-08-20', 2026, 8, 20, 34),
	(20260825, '2026-08-25', 2026, 8, 25, 35),
	(20260901, '2026-09-01', 2026, 9, 1, 36),
	(20260910, '2026-09-10', 2026, 9, 10, 37),
	(20261005, '2026-10-05', 2026, 10, 5, 41),
	(20261015, '2026-10-15', 2026, 10, 15, 42);

INSERT INTO dim_customer (customer_sk, customer_id, full_name, birth_date, country, city) 
	VALUES
	(1, 'CUST-100', 'Александр Смирнов', '1990-05-14', 'Россия', 'Москва'),
	(2, 'CUST-101', 'John Doe', '1985-11-20', 'United Kingdom', 'London'),
	(3, 'CUST-102', 'Marie Dupont', '1992-03-08', 'France', 'Paris'),
	(4, 'CUST-103', 'Елена Иванова', '1998-07-30', 'Россия', 'Санкт-Петербург'),
	(5, 'CUST-104', 'Максим Козлов', '1994-12-12', 'Россия', 'Казань'),
	(6, 'CUST-105', 'Sarah Jenkins', '1991-01-25', 'USA', 'New York'),
	(7, 'CUST-106', 'Ольга Васильева', '2001-09-03', 'Россия', 'Екатеринбург'),
	(8, 'CUST-107', 'Hans Müller', '1982-04-18', 'Germany', 'Berlin');

INSERT INTO dim_event (event_sk, event_id, name, category, genre, start_time) 
	VALUES
	(10, 'EV-01', 'Summer Rock Fest 2026', 'Concert', 'Rock', '19:00:00'),
	(20, 'EV-02', 'Swan Lake Ballet', 'Theatre', 'Ballet', '18:30:00'),
	(30, 'EV-03', 'Football Champions Final', 'Sport', 'Football', '20:00:00'),
	(40, 'EV-04', 'Jazz Night Standup', 'Concert', 'Jazz', '21:00:00'),
	(50, 'EV-05', 'Modern Art Expo', 'Exhibition', 'Contemporary', '10:00:00'),
	(60, 'EV-06', 'Symphony Orchestra Show', 'Concert', 'Classical', '19:30:00');

INSERT INTO dim_seat (seat_sk, seat_type) 
	VALUES
	(100, 'VIP'),
	(200, 'Standard'),
	(300, 'Fan Zone'),
	(400, 'Parterre'),
	(500, 'Balcony'),
	(600, 'Student');

INSERT INTO dim_order (order_sk, way_to_pay, sales_channel) 
	VALUES
	(1, 'Credit Card', 'Website'),
	(2, 'Apple Pay', 'Mobile App'),
	(3, 'Cash', 'Box Office'),
	(4, 'Debit Card', 'Partner Portal'),
	(5, 'Google Pay', 'Mobile App'),
	(6, 'Credit Card', 'Box Office');

INSERT INTO dim_venue (venue_sk, venue_id, name, capacity, country, city) 
	VALUES
	(1000, 'VEN-01', 'Стадион Лужники', 80000, 'Россия', 'Москва'),
	(2000, 'VEN-02', 'Wembley Stadium', 90000, 'United Kingdom', 'London'),
	(3000, 'VEN-03', 'Большой Театр', 2500, 'Россия', 'Москва'),
	(4000, 'VEN-04', 'МСК Арена', 12000, 'Россия', 'Казань'),
	(5000, 'VEN-05', 'Madison Square Garden', 20000, 'USA', 'New York'),
	(6000, 'VEN-06', 'Philharmonie Berlin', 2400, 'Germany', 'Berlin');

INSERT INTO fact_ticket_sales (
    sale_date_key, event_date_key, customer_key, event_key, seat_key,
    venue_key, order_context_key, order_id, ticket_id, seat_code,
    value_amount, service_fee_amount, discount_amount, total_amount
) VALUES
-- Продажа: Рок-фестиваль в Лондоне
(
    20260715, -- дата продажи (в формате YYYYMMDD)
    20260825, -- дата проведения мероприятия (YYYYMMDD)
    2, -- ID покупателя
    10, -- ID мероприятия
    100, -- ID категории мест (VIP)
    2000, -- ID площадки
    1, -- ID канала продаж
    'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', -- уникальный идентификатор заказа
    'c1b12345-8888-4ef8-bb6d-6bb9bd380a11', -- уникальный идентификатор билета
    'A-01', -- конкретное место на площадке Wembley Stadium
    30000.00, -- базовая стоимость билета
    1500.00, -- сумма сервисного сбора
    0.00, -- сумма скидки
    31500.00  -- итоговая сумма
),
-- Продажа: Футбол в Москве со скидкой
(
    20260801, -- дата продажи (в формате YYYYMMDD)
    20260910, -- дата проведения мероприятия (YYYYMMDD)
    1, -- ID покупателя
    30, -- ID мероприятия
    200, -- ID категории мест (Standard)
    1000, -- ID площадки
    2, -- ID канала продаж
    'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', -- уникальный идентификатор заказа
    'd2b12345-9999-4ef8-bb6d-6bb9bd380b22', -- уникальный идентификатор билета
    'B-15', -- конкретное место на площадке Лужники
    9000.00, -- базовая стоимость билета
    450.00, -- сумма сервисного сбора
    1000.00, -- сумма скидки
    8450.00  -- итоговая сумма
),
-- Продажа: Театр в Москве через кассу
(
    20260810, -- дата продажи (в формате YYYYMMDD)
    20260825, -- дата проведения мероприятия (YYYYMMDD)
    4, -- ID покупателя
    20, -- ID мероприятия
    400, -- ID категории мест (Parterre)
    3000, -- ID площадки
    3, -- ID канала продаж
    'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380c33', -- уникальный идентификатор заказа
    'e3b12345-0000-4ef8-bb6d-6bb9bd380c33', -- уникальный идентификатор билета
    'P-05', -- конкретное место в Большом Театре
    15000.00, -- базовая стоимость билета
    0.00, -- сумма сервисного сбора
    1000.00,  -- сумма скидки
    14000.00  -- итоговая сумма
),
-- Продажа: Фан-зона в Лондоне
(
    20260810, -- дата продажи (в формате YYYYMMDD)
    20260825, -- дата проведения мероприятия (YYYYMMDD)
    3, -- ID покупателя
    10, -- ID мероприятия
    300, -- ID категории мест (Fan Zone)
    2000, -- ID площадки
    1, -- ID канала продаж
    'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380d44', -- уникальный идентификатор заказа
    'f4b12345-1111-4ef8-bb6d-6bb9bd380d44', -- уникальный идентификатор билета
    'F-100', -- конкретное место на Wembley Stadium
    6000.00,  -- базовая стоимость билета
    300.00, -- сумма сервисного сбора
    0.00, -- сумма скидки
    6300.00  -- итоговая сумма
),
-- Продажа: Джаз в Казани
(
    20260701, -- дата продажи (в формате YYYYMMDD)
    20260820, -- дата проведения мероприятия (YYYYMMDD)
    5, -- ID покупателя
    40, -- ID мероприятия
    200, -- ID категории мест (Standard)
    4000, -- ID площадки
    5, -- ID канала продаж
    'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380e55', -- уникальный идентификатор заказа
    'a1b12345-2222-4ef8-bb6d-6bb9bd380e55', -- уникальный идентификатор билета
    'B-22', -- конкретное место в МСК Арене
    3000.00, -- базовая стоимость билета
    150.00, -- сумма сервисного сбора
    300.00, -- сумма скидки
    2850.00  -- итоговая сумма
),
-- Продажа: Выставка в Нью-Йорке
(
    20260820, -- дата продажи (в формате YYYYMMDD)
    20261005, -- дата проведения мероприятия (YYYYMMDD)
    6, -- ID покупателя
    50, -- ID мероприятия
    600,  -- ID категории мест (Student)
    5000, -- ID площадки
    4,  -- ID канала продаж
    'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380f66', -- уникальный идентификатор заказа
    'b2b12345-3333-4ef8-bb6d-6bb9bd380f66', -- уникальный идентификатор билета
    'S-01', -- конкретное место в Madison Square Garden
    1600.00, -- базовая стоимость билета
    80.00,  -- сумма сервисного сбора
    0.00, -- сумма скидки
    1680.00 -- итоговая сумма
),
-- Продажа: Симфонический оркестр в Берлине
(
    20260901, -- дата продажи (в формате YYYYMMDD)
    20261015, -- дата проведения мероприятия (YYYYMMDD)
    8, -- ID покупателя
    60, -- ID мероприятия
    100, -- ID категории мест (VIP)
    6000, -- ID площадки
    1, -- ID канала продаж
    'a6eebc99-9c0b-4ef8-bb6d-6bb9bd380a77', -- уникальный идентификатор заказа
    'c3b12345-4444-4ef8-bb6d-6bb9bd380a77', -- уникальный идентификатор билета
    'A-05', -- конкретное место в Philharmonie Berlin
    15000.00, -- базовая стоимость билета
    750.00, -- сумма сервисного сбора
    2000.00, -- сумма скидки
    13750.00  -- итоговая сумма
),
-- Продажа: Балет в Москве для VIP-клиента
(
    20260801, -- дата продажи (в формате YYYYMMDD)
    20260825, -- дата проведения мероприятия (YYYYMMDD)
    7, -- ID покупателя
    20, -- ID мероприятия
    100, -- ID категории мест (VIP)
    3000, -- ID площадки
    2, -- ID канала продаж
    'b7eebc99-9c0b-4ef8-bb6d-6bb9bd380b88', -- уникальный идентификатор заказа
    'd4b12345-5555-4ef8-bb6d-6bb9bd380b88', -- уникальный идентификатор билета
    'A-01', -- конкретное место в Большом Театре (другая площадка, поэтому
            -- дубль кода "A-01" из первой продажи корректен — он теперь
            -- живёт в контексте venue через fact, а не как общий seat_sk)
    30000.00, -- базовая стоимость билета
    1500.00, -- сумма сервисного сбора
    0.00, -- сумма скидки
    31500.00  -- итоговая сумма
);
--Какие мероприятия получили наибольшую выручку и сколько билетов было на них продано?
SELECT 
    e.name AS event_name,
    e.category AS event_category,
    v.name AS venue_name,
    COUNT(f.ticket_id) AS tickets_sold, 
    SUM(f.total_amount) AS total_revenue
FROM fact_ticket_sales f
JOIN dim_event e 
	ON f.event_key = e.event_sk
JOIN dim_venue v 
	ON f.venue_key = v.venue_sk
GROUP BY e.name,
		 e.category,
		 v.name
ORDER BY total_revenue DESC
LIMIT 10;

--Через какие каналы и какими способами оплаты клиенты приносят больше всего денег?
SELECT 
    o.sales_channel,
    o.way_to_pay,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(f.ticket_id) AS tickets_sold, 
    SUM(f.total_amount) AS total_revenue
FROM fact_ticket_sales f
JOIN dim_order o 
	ON f.order_context_key = o.order_sk
GROUP BY o.sales_channel,
		 o.way_to_pay
ORDER BY total_revenue DESC;

--Какова доля выручки от продаж различных категорий мест (VIP, Standard) и какова скидка на них?
SELECT
    s.seat_type,
    COUNT(f.ticket_id) AS tickets_sold,
    SUM(f.value_amount) AS base_revenue,
    SUM(f.discount_amount) AS total_discounts_given,
    SUM(f.total_amount) AS final_revenue,
    ROUND(
        100.0 * SUM(f.total_amount) / SUM(SUM(f.total_amount)) OVER (),
        2
    ) AS revenue_share_pct
FROM fact_ticket_sales f
JOIN dim_seat s
	ON f.seat_key = s.seat_sk
GROUP BY s.seat_type
ORDER BY final_revenue DESC;

--Как меняется объем продаж от месяца к месяцу?
SELECT 
    d.year,
    d.month,
    COUNT(f.ticket_id) AS monthly_tickets_sold,
    SUM(f.total_amount) AS monthly_revenue,
    SUM(f.service_fee_amount) AS monthly_service_fees
FROM fact_ticket_sales f
JOIN dim_date d 
	ON f.sale_date_key = d.date_sk
GROUP BY d.year,
		 d.month
ORDER BY d.year ASC, 
		 d.month ASC;
