USE wedel;

CREATE USER IF NOT EXISTS 'app'@'localhost' IDENTIFIED BY 'apppassword';
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'adminpassword';
CREATE USER IF NOT EXISTS 'manager'@'localhost' IDENTIFIED BY 'managerpassword';
CREATE USER IF NOT EXISTS 'worker'@'localhost' IDENTIFIED BY 'workerpassword';

CREATE ROLE IF NOT EXISTS worker;
CREATE ROLE IF NOT EXISTS manager;
CREATE ROLE IF NOT EXISTS admin;

GRANT worker TO manager;
GRANT manager TO admin;

GRANT manager TO `manager`@`localhost`;
GRANT worker TO `worker`@`localhost`;
GRANT admin TO `admin`@`localhost`;

SET DEFAULT ROLE worker FOR `worker`@`localhost`;
SET DEFAULT ROLE manager FOR `manager`@`localhost`;
SET DEFAULT ROLE admin FOR `admin`@`localhost`;

GRANT SELECT ON wedel.products TO worker;
GRANT SELECT ON wedel.chocolates TO worker;
GRANT SELECT ON wedel.candies TO worker;
GRANT SELECT ON wedel.jellyCandies TO worker;
GRANT SELECT ON wedel.chocolateBars TO worker;
GRANT SELECT ON wedel.suppliers TO worker;
GRANT INSERT ON wedel.clients TO worker;
GRANT INSERT ON wedel.supplies TO worker;
GRANT INSERT ON wedel.sales TO worker;
GRANT INSERT ON wedel.suppliesInfo TO worker;
GRANT INSERT ON wedel.salesInfo TO worker;

GRANT EXECUTE ON FUNCTION wedel.quantityOnDate TO worker;
GRANT EXECUTE ON PROCEDURE wedel.updateSale TO worker;
GRANT EXECUTE ON PROCEDURE wedel.updateSupply TO worker;
GRANT EXECUTE ON PROCEDURE wedel.addChocolate TO manager;
GRANT EXECUTE ON PROCEDURE wedel.addCandy TO manager;
GRANT EXECUTE ON PROCEDURE wedel.addJellyCandy TO manager;
GRANT EXECUTE ON PROCEDURE wedel.addChocolateBar TO manager;
GRANT INSERT ON wedel.suppliers TO manager;

GRANT INSERT ON wedel.users TO admin;
GRANT DELETE ON wedel.users TO admin;

GRANT SELECT, LOCK TABLES ON alkohurt.* TO 'admin'@'localhost';
GRANT DROP, CREATE, ALTER ON alkohurt.* TO 'admin'@'localhost';
GRANT SUPER ON *.* TO 'admin'@'localhost';
GRANT SELECT on alkohurt.users TO 'app'@'localhost';