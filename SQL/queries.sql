-- ===============================
-- Vehicle Rental System Database
-- ===============================


Old tables remove (if exist)
DROP TABLE IF EXISTS Bookings CASCADE;
DROP TABLE IF EXISTS Vehicles CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- ===============================
-- Users Table
-- ===============================
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) DEFAULT 'customer'
);

-- ===============================
-- Vehicles Table
-- ===============================
CREATE TABLE Vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    model VARCHAR(50),
    registration_no VARCHAR(50) UNIQUE,
    rental_price_per_day NUMERIC(10,2),
    status VARCHAR(20) DEFAULT 'available'
);

-- ===============================
-- Bookings Table
-- ===============================
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    vehicle_id INT REFERENCES Vehicles(vehicle_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    total_cost NUMERIC(10,2)
);

-- ===============================
-- Insert Users
-- ===============================
INSERT INTO Users (name, email, password, phone, role)
VALUES 
('Rahim', 'rahim@example.com', '12345', '01700000001', 'customer'),
('Karim', 'karim@example.com', '12345', '01700000002', 'customer'),
('Admin', 'admin@example.com', 'admin123', '01711111111', 'admin');

-- ===============================
-- Insert Vehicles
-- ===============================
INSERT INTO Vehicles (name, type, model, registration_no, rental_price_per_day, status)
VALUES
('Toyota Corolla', 'car', '2020', 'ABC-1234', 2000, 'available'),
('Honda Civic', 'car', '2019', 'DEF-5678', 1800, 'available'),
('Yamaha R15', 'bike', '2021', 'XYZ-9999', 800, 'available'),
('Suzuki Wagon R', 'car', '2018', 'GHI-4321', 1500, 'available');

-- ===============================
-- Insert Bookings
-- (extra data added for GROUP BY >1 booking)
-- ===============================
INSERT INTO Bookings (user_id, vehicle_id, start_date, end_date, status, total_cost)
VALUES
(1, 1, '2026-01-15', '2026-01-18', 'confirmed', 6000),
(2, 3, '2026-01-20', '2026-01-22', 'pending', 1600),
(1, 2, '2026-01-25', '2026-01-27', 'completed', 3600),
(2, 1, '2026-02-01', '2026-02-03', 'confirmed', 4000),
(1, 1, '2026-02-05', '2026-02-07', 'confirmed', 4000),
(3, 2, '2026-02-10', '2026-02-12', 'confirmed', 3600);

-- ===============================
-- JOIN Query
-- Booking info with User & Vehicle
-- ===============================
SELECT
    b.booking_id,
    u.name AS customer_name,
    u.email,
    u.phone,
    u.role,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Vehicles v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id;

-- ===============================
-- NOT EXISTS Query
-- Vehicles never booked
-- ===============================
SELECT
    v.vehicle_id,
    v.name,
    v.type
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM Bookings b
    WHERE b.vehicle_id = v.vehicle_id
);

-- ===============================
-- WHERE Query
-- Available cars only
-- ===============================
SELECT vehicle_id, name, rental_price_per_day
FROM Vehicles
WHERE type = 'car' AND status = 'available';

-- ===============================
-- GROUP BY + HAVING
-- Vehicles with more than 1 booking
-- ===============================
SELECT
    v.vehicle_id,
    v.name,
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING COUNT(b.booking_id) > 1;

-- ===============================
-- Users Output (Password Hidden)
-- ===============================
SELECT user_id, name, email, phone, role FROM Users;

-- ===============================
-- Verify Tables
-- ===============================
SELECT * FROM Vehicles;
SELECT * FROM Bookings;
