CREATE DATABASE if not exists wedel;

USE wedel;

# set foreign_key_checks = 1;
# drop table suppliesInfo;



CREATE TABLE products (
    id         int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name       varchar(50),
    mass       int UNSIGNED,
    type       enum ('chocolate', 'candy', 'jelly candy', 'chocolate bar'),
    price      decimal(5, 2) UNSIGNED,
    quantity   int UNSIGNED
);

# delete from chocolates where name like '%';

CREATE TABLE chocolates (
    id         int NOT NULL PRIMARY KEY,
    name       varchar(50),
    producer   varchar(50),
    type       enum ('bitter', 'milky', 'white'),
    flavour    varchar(50),
    mass       int UNSIGNED,
    FOREIGN KEY (id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE candies (
    id         int NOT NULL PRIMARY KEY,
    name       varchar(50),
    producer   varchar(50),
    type       varchar(50),
    flavour    varchar(50),
    mass       int UNSIGNED,
    FOREIGN KEY (id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE jellyCandies (
    id         int NOT NULL PRIMARY KEY,
    name       varchar(50),
    producer   varchar(50),
    type       varchar(50),
    flavour    varchar(50),
    mass       int UNSIGNED,
    FOREIGN KEY (id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE chocolateBars (
    id         int NOT NULL PRIMARY KEY,
    name       varchar(50),
    producer   varchar(50),
    flavour    varchar(50),
    mass       int UNSIGNED,
    FOREIGN KEY (id) REFERENCES products (id) ON DELETE CASCADE
);

CREATE TABLE users (
    login    varchar(50) PRIMARY KEY,
    password varchar(255),
    type     enum ('admin', 'manager', 'worker')
);

CREATE TABLE suppliers (
    supplierId        int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name              varchar(50),
    nip               char(10)
);

CREATE TABLE supplies (
    supplyId    int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date        date,
    supplierId  int,
    done        boolean,
    FOREIGN KEY (supplierId) REFERENCES suppliers (supplierId)
);

CREATE TABLE suppliesInfo (
    id         int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productId  int,
    supplyId   int,
    quantity   int UNSIGNED,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (supplyId) REFERENCES supplies (supplyId) ON DELETE CASCADE
);

CREATE TABLE clients (
    clientId          int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name              varchar(50),
    city              varchar(50),
    street_and_number varchar(50)
);

CREATE TABLE sales (
    saleId    int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date      date,
    clientId  int,
    done      boolean,
    FOREIGN KEY (clientId) REFERENCES clients (clientId)
);

CREATE TABLE salesInfo (
    id         int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productId  int,
    saleId     int,
    quantity   int UNSIGNED,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (saleId) REFERENCES sales (saleId) ON DELETE CASCADE
);

# drop procedure addProduct;

DELIMITER //
CREATE PROCEDURE addProduct(IN type_in ENUM('chocolate', 'candy', 'jelly candy', 'chocolate bar'),
                            IN name_in VARCHAR(50), IN mass_in INT UNSIGNED,
                            IN price_in DECIMAL(5, 2) UNSIGNED, IN quantity_in INT UNSIGNED, OUT id INT)
BEGIN
    INSERT INTO products(type, name, mass, price, quantity)
    VALUES (
                type_in,
                name_in,
                mass_in,
                price_in,
                quantity_in
           );
    SELECT last_insert_id() INTO id;
END //
DELIMITER ;

# drop function chocolateAlreadyExists;

DELIMITER //
CREATE FUNCTION chocolateAlreadyExists(name VARCHAR(50), producer VARCHAR(50), type ENUM('bitter', 'milky', 'white'), flavour VARCHAR(50),
                                       mass INT UNSIGNED) RETURNS BOOLEAN
BEGIN
    RETURN !ISNULL ((
        SELECT id
        FROM chocolates c
        WHERE
                c.name = name AND
                c.producer = producer AND
                c.type = type AND
                c.flavour = flavour AND
                c.mass = mass
    ));
END //
DELIMITER ;

# drop procedure innerAddChocolate;

DELIMITER //
CREATE PROCEDURE innerAddChocolate(IN id_in INT, IN name_in VARCHAR(50), IN producer_in VARCHAR(50), IN type_in ENUM('bitter', 'milky', 'white'),
                                   IN flavour_in varchar(50), mass_in INT UNSIGNED)
BEGIN
    INSERT INTO chocolates(id, producer, name, type, flavour, mass)
    VALUES (
               id_in,
               producer_in,
               name_in,
               type_in,
               flavour_in,
               mass_in
           );
END //
DELIMITER ;

# drop procedure addChocolate;

DELIMITER //
CREATE OR REPLACE PROCEDURE addChocolate(IN name VARCHAR(50), IN producer VARCHAR(50), IN type ENUM('bitter', 'milky', 'white'),
                                         IN flavour varchar(50), mass INT UNSIGNED, IN price DECIMAL(5, 2) UNSIGNED)
BEGIN
    IF chocolateAlreadyExists(name, producer, type, flavour, mass) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chocolate already exists';
    ELSE
        SET AUTOCOMMIT = 0;
        START TRANSACTION;
        CALL addProduct('chocolate', name, mass, price, 0, @id);
        CALL innerAddChocolate(@id, name, producer, type, flavour, mass);
        COMMIT;
        SET AUTOCOMMIT = 1;
    END IF;
END //
DELIMITER ;

# drop function candyAlreadyExists;

DELIMITER //
CREATE FUNCTION candyAlreadyExists(name VARCHAR(50), producer VARCHAR(50), type VARCHAR(50), flavour VARCHAR(50),
                                   mass INT UNSIGNED) RETURNS BOOLEAN
BEGIN
    RETURN !ISNULL ((
        SELECT id
        FROM candies c
        WHERE
                c.name = name AND
                c.producer = producer AND
                c.type = type AND
                c.flavour = flavour AND
                c.mass = mass
    ));
END //
DELIMITER ;

# drop procedure innerAddCandy;

DELIMITER //
CREATE PROCEDURE innerAddCandy(IN id_in INT, IN name_in VARCHAR(50), IN producer_in VARCHAR(50), IN type_in VARCHAR(50),
                               IN flavour_in varchar(50), mass_in INT UNSIGNED)
BEGIN
    INSERT INTO candies(id, producer, name, type, flavour, mass)
    VALUES (
               id_in,
               producer_in,
               name_in,
               type_in,
               flavour_in,
               mass_in
           );
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE addCandy(IN name VARCHAR(50), IN producer VARCHAR(50), IN type VARCHAR(50),
                                     IN flavour varchar(50), mass INT UNSIGNED, IN price DECIMAL(5, 2) UNSIGNED)
BEGIN
    IF candyAlreadyExists(name, producer, type, flavour, mass) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Candy already exists';
    ELSE
        SET AUTOCOMMIT = 0;
        START TRANSACTION;
        CALL addProduct('candy', name, mass, price, 0, @id);
        CALL innerAddCandy(@id, name, producer, type, flavour, mass);
        COMMIT;
        SET AUTOCOMMIT = 1;
    END IF;
END //
DELIMITER ;

# drop function jellyCandyAlreadyExists;

DELIMITER //
CREATE FUNCTION jellyCandyAlreadyExists(name VARCHAR(50), producer VARCHAR(50), type VARCHAR(50), flavour VARCHAR(50),
                                        mass INT UNSIGNED) RETURNS BOOLEAN
BEGIN
    RETURN !ISNULL ((
        SELECT id
        FROM jellyCandies j
        WHERE
                j.name = name AND
                j.producer = producer AND
                j.type = type AND
                j.flavour = flavour AND
                j.mass = mass
    ));
END //
DELIMITER ;

drop procedure innerAddJellyCandy;

DELIMITER //
CREATE PROCEDURE innerAddJellyCandy(IN id_in INT, IN name_in VARCHAR(50), IN producer_in VARCHAR(50), IN type_in VARCHAR(50),
                                    IN flavour_in varchar(50), mass_in INT UNSIGNED)
BEGIN
    INSERT INTO jellyCandies(id, producer, name, type, flavour, mass)
    VALUES (
               id_in,
               producer_in,
               name_in,
               type_in,
               flavour_in,
               mass_in
           );
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE addJellyCandy(IN name VARCHAR(50), IN producer VARCHAR(50), IN type VARCHAR(50),
                                          IN flavour varchar(50), mass INT UNSIGNED, IN price DECIMAL(5, 2) UNSIGNED)
BEGIN
    IF jellyCandyAlreadyExists(name, producer, type, flavour, mass) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Jelly candy already exists';
    ELSE
        SET AUTOCOMMIT = 0;
        START TRANSACTION;
        CALL addProduct('jelly candy', name, mass, price, 0, @id);
        CALL innerAddJellyCandy(@id, name, producer, type, flavour, mass);
        COMMIT;
        SET AUTOCOMMIT = 1;
    END IF;
END //
DELIMITER ;

# drop function chocolateBarAlreadyExists;

DELIMITER //
CREATE FUNCTION chocolateBarAlreadyExists(name VARCHAR(50), producer VARCHAR(50), flavour VARCHAR(50),
                                          mass INT UNSIGNED) RETURNS BOOLEAN
BEGIN
    RETURN !ISNULL ((
        SELECT id
        FROM chocolateBars c
        WHERE
                c.name = name AND
                c.producer = producer AND
                c.flavour = flavour AND
                c.mass = mass
    ));
END //
DELIMITER ;

# drop procedure innerAddChocolateBar;

DELIMITER //
CREATE PROCEDURE innerAddChocolateBar(IN id_in INT, IN name_in VARCHAR(50), IN producer_in VARCHAR(50),
                                      IN flavour_in varchar(50), mass_in INT UNSIGNED)
BEGIN
    INSERT INTO chocolateBars(id, producer, name, flavour, mass)
    VALUES (
               id_in,
               producer_in,
               name_in,
               flavour_in,
               mass_in
           );
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE PROCEDURE addChocolateBar(IN name VARCHAR(50), IN producer VARCHAR(50),
                                            IN flavour varchar(50), mass INT UNSIGNED, IN price DECIMAL(5, 2) UNSIGNED)
BEGIN
    IF chocolateBarAlreadyExists(name, producer, flavour, mass) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chocolate bar already exists';
    ELSE
        SET AUTOCOMMIT = 0;
        START TRANSACTION;
        CALL addProduct('chocolate bar', name, mass, price, 0, @id);
        CALL innerAddChocolateBar(@id, name, producer, flavour, mass);
        COMMIT;
        SET AUTOCOMMIT = 1;
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER updateQuantitySupplies AFTER UPDATE ON supplies FOR EACH ROW
BEGIN
    IF NEW.done AND NOT OLD.done THEN
        CREATE TEMPORARY TABLE prods AS (
            SELECT productId, quantity FROM supplies JOIN suppliesInfo ON supplies.supplyId = suppliesInfo.supplyId
            WHERE supplies.supplyId = NEW.supplyId
        );
        UPDATE products p JOIN prods ON  p.id = prods.productId
        SET p.quantity = p.quantity + prods.quantity;
    END IF;
END //
DELIMITER ;

show triggers;

DELIMITER //
CREATE TRIGGER deleteProducts AFTER DELETE ON products FOR EACH ROW
BEGIN
    DELETE FROM chocolates WHERE chocolates.id = OLD.id;
    DELETE FROM candies WHERE candies.id = OLD.id;
    DELETE FROM jellyCandies WHERE jellyCandies.id = OLD.id;
    DELETE FROM chocolateBars WHERE chocolateBars.id = OLD.id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER updateQuantitySales AFTER UPDATE ON sales FOR EACH ROW
BEGIN
    IF NEW.done AND NOT OLD.done THEN
        CREATE TEMPORARY TABLE prods AS (
            SELECT productId, quantity FROM sales s JOIN salesInfo si ON s.saleId = si.saleId
            WHERE s.saleId = NEW.saleId
        );
        UPDATE products p JOIN prods ON  p.id = prods.productId
        SET p.quantity = p.quantity - prods.quantity;
    END IF;
END //
DELIMITER ;

select quantityOnDate(4, '2021-01-13') as quantity;

DELIMITER //
CREATE OR REPLACE FUNCTION quantityOnDate(in_product_id INT, in_date DATE) RETURNS INT
BEGIN
    DECLARE supplied INT;
    DECLARE sold INT;

    IF in_date < DATE(now()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please enter future date';
    END IF;

    SELECT SUM(quantity)
    FROM suppliesInfo si JOIN supplies s ON si.supplyId = s.supplyId
    WHERE si.productId = in_product_id AND (date BETWEEN NOW() AND in_date AND NOT done)
    INTO supplied;
#     OR (si.productId = in_product_id AND NOT done)

    SELECT SUM(quantity)
    FROM salesInfo si JOIN sales s ON si.saleId = s.saleId
    WHERE si.productId = in_product_id AND
        date BETWEEN NOW() AND in_date AND
        NOT done
    INTO sold;

    IF sold IS NULL THEN
        SET sold = 0;
    END IF;

    IF supplied IS NULL THEN
        SET supplied = 0;
    END IF;

    RETURN (SELECT quantity + supplied - sold
            FROM products
            WHERE id = in_product_id);
END //
DELIMITER ;

# drop procedure updateSupply;

DELIMITER //
CREATE PROCEDURE updateSupply(IN in_supply_id INT)
BEGIN
    UPDATE supplies SET done = 1 WHERE supplyId = in_supply_id;
END //
DELIMITER ;

drop procedure updateSale;

DELIMITER //
CREATE PROCEDURE updateSale(IN in_sale_id INT)
BEGIN
    UPDATE sales SET done = 1 WHERE saleId = in_sale_id;
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE FUNCTION nipIsValid(nip CHAR(10)) RETURNS BOOLEAN
BEGIN
    IF MOD(
                       6*CAST(SUBSTR(nip, 1, 1) AS UNSIGNED) +
                       5*CAST(SUBSTR(nip, 2, 1) AS UNSIGNED) +
                       7*CAST(SUBSTR(nip, 3, 1) AS UNSIGNED) +
                       2*CAST(SUBSTR(nip, 4, 1) AS UNSIGNED) +
                       3*CAST(SUBSTR(nip, 5, 1) AS UNSIGNED) +
                       4*CAST(SUBSTR(nip, 6, 1) AS UNSIGNED) +
                       5*CAST(SUBSTR(nip, 7, 1) AS UNSIGNED) +
                       6*CAST(SUBSTR(nip, 8, 1) AS UNSIGNED) +
                       7*CAST(SUBSTR(nip, 9, 1) AS UNSIGNED),
                       11) <> SUBSTR(nip, 10, 1)
    THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE OR REPLACE TRIGGER suppliersInsert BEFORE INSERT ON suppliers FOR EACH ROW
BEGIN
    IF NOT nipIsValid(new.nip) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NIP control sum error';
    END IF;
END //
DELIMITER ;

show triggers;
