INSERT INTO store_formats VALUES
(1, 'ICA Nära', 'Small-format urban convenience stores'),
(2, 'ICA Supermarket', 'Mid-size neighbourhood supermarkets'),
(3, 'ICA Kvantum', 'Large-format suburban supermarkets'),
(4, 'ICA Maxi', 'Hypermarket format with non-food range');

INSERT INTO stores VALUES
(1, 'ICA Supermarket Södermalm', 2, 'Stockholm', 'Stockholm', 'Anna Lindqvist', '2015-03-10'),
(2, 'ICA Maxi Kungens Kurva', 4, 'Stockholm', 'Huddinge', 'Per Eriksson', '2010-06-01'),
(3, 'ICA Nära Vasastan', 1, 'Stockholm', 'Stockholm', 'Maria Johansson', '2018-11-22'),
(4, 'ICA Kvantum Gothenburg City', 3, 'Västra Götaland', 'Gothenburg', 'Lars Svensson', '2012-04-14'),
(5, 'ICA Supermarket Malmö Centrum', 2, 'Skåne', 'Malmö', 'Sofia Nilsson', '2016-08-30'),
(6, 'ICA Maxi Uppsala', 4, 'Uppsala', 'Uppsala', 'Johan Berg', '2009-02-17'),
(7, 'ICA Nära Linköping', 1, 'Östergötland', 'Linköping', 'Karin Holm', '2020-05-05'),
(8, 'ICA Kvantum Örebro', 3, 'Örebro', 'Örebro', 'Mikael Strand', '2013-09-09');

INSERT INTO product_categories VALUES
(1, 'Dairy & Eggs', FALSE),
(2, 'Meat & Poultry', FALSE),
(3, 'Bakery', FALSE),
(4, 'Frozen Foods', FALSE),
(5, 'Beverages', FALSE),
(6, 'ICA Private Label – Pantry', TRUE),
(7, 'ICA Private Label – Fresh', TRUE),
(8, 'Household & Cleaning', FALSE);

INSERT INTO products VALUES
(1, 'Arla Mellanmjölk 3L', 1, 18.50, 24.90, 'Arla Foods'),
(2, 'ICA Basic Ägg 12-pack', 1, 14.00, 19.90, 'ICA Sverige AB'),
(3, 'Scan Kycklingfilé 1kg', 2, 62.00, 84.90, 'Scan AB'),
(4, 'ICA Selection Lax 400g', 7, 48.00, 69.90, 'ICA Sverige AB'),
(5, 'Skogaholm Rågbröd 700g', 3, 16.00, 22.50, 'Lantmännen Unibake'),
(6, 'ICA Basic Frysta Ärtor 1kg', 6, 9.50, 14.90, 'ICA Sverige AB'),
(7, 'Coca-Cola 1.5L', 5, 12.00, 18.90, 'Coca-Cola European Partners'),
(8, 'Ramlösa Naturell 6-pack', 5, 22.00, 32.90, 'Carlsberg Sverige'),
(9, 'ICA Basic Diskmedel 1L', 6, 8.00, 13.90, 'ICA Sverige AB'),
(10, 'Fairy Original 500ml', 8, 14.00, 21.90, 'Procter & Gamble');

INSERT INTO wholesale_orders VALUES
(1, 1, '2024-10-02', '2024-10-04', 'Delivered', 42800.00),
(2, 2, '2024-10-03', '2024-10-05', 'Delivered', 118500.00),
(3, 3, '2024-10-07', '2024-10-09', 'Delivered', 19400.00),
(4, 4, '2024-10-08', '2024-10-10', 'Delivered', 76300.00),
(5, 5, '2024-10-14', '2024-10-16', 'Delivered', 53200.00),
(6, 6, '2024-10-15', '2024-10-17', 'Delivered', 98700.00),
(7, 7, '2024-10-21', '2024-10-23', 'Delivered', 14900.00),
(8, 8, '2024-10-22', '2024-10-24', 'Delivered', 61100.00),
(9, 1, '2024-11-04', '2024-11-06', 'Delivered', 44100.00),
(10, 2, '2024-11-05', '2024-11-07', 'Delivered', 122300.00),
(11, 3, '2024-11-11', '2024-11-13', 'Delivered', 20800.00),
(12, 4, '2024-11-12', '2024-11-14', 'Delivered', 79500.00),
(13, 5, '2024-11-18', '2024-11-20', 'Delivered', 55900.00),
(14, 6, '2024-11-19', '2024-11-21', 'Delivered', 103400.00),
(15, 7, '2024-11-25', '2024-11-27', 'Delivered', 16200.00),
(16, 8, '2024-11-26', '2024-11-28', 'Delivered', 63800.00),
(17, 1, '2024-12-02', '2024-12-04', 'Delivered', 58300.00),
(18, 2, '2024-12-03', '2024-12-05', 'Delivered', 145600.00),
(19, 3, '2024-12-09', '2024-12-11', 'Delivered', 26100.00),
(20, 4, '2024-12-10', '2024-12-12', 'Delivered', 94200.00),
(21, 5, '2024-12-16', '2024-12-18', 'Delivered', 72400.00),
(22, 6, '2024-12-17', '2024-12-19', 'Delivered', 131800.00),
(23, 7, '2024-12-20', '2024-12-22', 'Delivered', 21500.00),
(24, 8, '2024-12-23', NULL, 'Pending', 79900.00);

INSERT INTO wholesale_order_items VALUES
(1, 1, 1, 200, 18.50),(2, 1, 3, 150, 62.00),(3, 1, 5, 300, 16.00),
(4, 2, 1, 600, 18.50),(5, 2, 3, 400, 62.00),(6, 2, 7, 500, 12.00),(7, 2, 10, 200, 14.00),
(8, 3, 2, 100, 14.00),(9, 3, 9, 150, 8.00),
(10, 4, 4, 300, 48.00),(11, 4, 8, 400, 22.00),(12, 4, 6, 500, 9.50),
(13, 5, 1, 250, 18.50),(14, 5, 3, 200, 62.00),(15, 5, 5, 200, 16.00),
(16, 6, 1, 500, 18.50),(17, 6, 7, 600, 12.00),(18, 6, 4, 400, 48.00),
(19, 7, 2, 80, 14.00),(20, 7, 9, 100, 8.00),
(21, 8, 3, 300, 62.00),(22, 8, 6, 400, 9.50),(23, 8, 8, 250, 22.00),
(24, 9, 1, 220, 18.50),(25, 9, 3, 160, 62.00),(26, 9, 5, 280, 16.00),
(27, 10, 1, 620, 18.50),(28, 10, 3, 420, 62.00),(29, 10, 7, 520, 12.00),
(30, 17, 1, 300, 18.50),(31, 17, 3, 250, 62.00),(32, 17, 7, 400, 12.00),
(33, 18, 1, 800, 18.50),(34, 18, 3, 600, 62.00),(35, 18, 7, 700, 12.00),(36, 18, 4, 500, 48.00);

INSERT INTO loyalty_members VALUES
(1, 1, '2021-01-15', 'Gold', 18400),
(2, 1, '2022-03-20', 'Silver', 9200),
(3, 2, '2020-07-08', 'Gold', 31500),
(4, 2, '2023-01-11', 'Bronze', 3100),
(5, 3, '2022-09-30', 'Silver', 7800),
(6, 4, '2021-06-14', 'Gold', 22600),
(7, 5, '2023-05-02', 'Bronze', 2400),
(8, 6, '2020-11-19', 'Gold', 41200),
(9, 7, '2023-08-25', 'Bronze', 1800),
(10, 8, '2022-02-28', 'Silver', 11300);

INSERT INTO loyalty_transactions VALUES
(1, 1, 1, '2024-10-05', 420.50, 420),
(2, 2, 1, '2024-10-08', 318.00, 318),
(3, 3, 2, '2024-10-10', 892.00, 892),
(4, 4, 2, '2024-10-12', 145.90, 145),
(5, 5, 3, '2024-10-15', 267.50, 267),
(6, 6, 4, '2024-10-18', 540.00, 540),
(7, 7, 5, '2024-10-20', 188.00, 188),
(8, 8, 6, '2024-10-22', 1100.00, 1100),
(9, 9, 7, '2024-10-25', 89.50, 89),
(10, 10, 8, '2024-10-28', 430.00, 430),
(11, 1, 1, '2024-11-03', 510.00, 510),
(12, 3, 2, '2024-11-07', 950.00, 950),
(13, 6, 4, '2024-11-14', 620.00, 620),
(14, 8, 6, '2024-11-20', 1250.00, 1250),
(15, 1, 1, '2024-12-05', 680.00, 680),
(16, 3, 2, '2024-12-10', 1140.00, 1140),
(17, 6, 4, '2024-12-15', 780.00, 780),
(18, 8, 6, '2024-12-20', 1580.00, 1580),
(19, 2, 1, '2024-12-22', 390.00, 390),
(20, 5, 3, '2024-12-24', 310.00, 310);
