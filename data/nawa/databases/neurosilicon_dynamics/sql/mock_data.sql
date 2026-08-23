INSERT INTO customers VALUES (1,'HyperCloud Inc','North America','Cloud'),(2,'DeepAI Labs','Europe','Startup'),(3,'Quantum Research Center','Asia','Research'),(4,'GameTech OEM','North America','OEM'),(5,'DataCore Systems','Europe','Enterprise');

INSERT INTO products VALUES (1,'NSD A100X','AI Accelerator',12000.00),(2,'NSD RTX Pro','GPU',2500.00),(3,'NSD EdgeCore','Edge AI',1800.00);

INSERT INTO suppliers VALUES (1,'SiliconFoundry Co','Taiwan'),(2,'NanoChip Fabricators','South Korea');

INSERT INTO production_batches VALUES (1,1,1,'2026-01-10',500,8000.00),(2,2,1,'2026-01-15',1000,1500.00),(3,3,2,'2026-02-01',700,1100.00),(4,1,2,'2026-02-20',400,8200.00),(5,2,1,'2026-03-05',900,1400.00),(6,3,2,'2026-03-18',600,1050.00);

INSERT INTO inventory VALUES (1,1,300,'2026-03-31'),(2,2,500,'2026-03-31'),(3,3,400,'2026-03-31');

INSERT INTO orders VALUES (1,1,'2026-01-20','Completed'),(2,2,'2026-01-25','Completed'),(3,3,'2026-02-05','Completed'),(4,4,'2026-02-15','Completed'),(5,5,'2026-02-28','Completed'),(6,1,'2026-03-10','Completed'),(7,2,'2026-03-15','Completed'),(8,4,'2026-03-22','Completed');

INSERT INTO order_items VALUES (1,1,1,20,12000.00),(2,1,2,50,2500.00),(3,2,2,30,2500.00),(4,3,1,10,12000.00),(5,4,2,100,2500.00),(6,5,3,80,1800.00),(7,6,1,25,12000.00),(8,7,3,60,1800.00),(9,8,2,120,2500.00);
