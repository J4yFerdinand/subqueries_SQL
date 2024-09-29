-- creación de la tabla:Category --
CREATE TABLE category(
    category_id INT(11) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    CONSTRAINT pk_category_id PRIMARY KEY (category_id)
);

-- creación de la tabla: Product --
CREATE TABLE product(
    product_id INT(11) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    fk_category_id INT(11) NOT NULL,
    quantity_per_unit INT(11) NOT NULL,
    unit_price INT(11) NOT NULL,
    discontinued ENUM('F', 'V') NOT NULL,
    CONSTRAINT pk_product_id PRIMARY KEY (product_id),
    CONSTRAINT FOREIGN KEY (fk_category_id) REFERENCES category (category_id)
);

INSERT INTO category (category_id, name, description) VALUES (1,'Alimentos','Productos alimenticios'),(2,'Hogar','Productos para el hogar'),(3,'Tecnologia','Productos tecnologicos para el hogar y/u oficina');
SELECT * FROM category;

INSERT INTO product (product_id,product_name,fk_category_id,quantity_per_unit,unit_price,discontinued)VALUES (100,'Arroz blanco Diana',1,500,2100,'F'),(101,'Aceite de Coco Diana',1,1000,3100,'F'),(102,'Frijol Verde Diana',1,600,1900,'F'),
(103,'Sal gruesa Refisal',1,1000,1250,'F'),(104,'Sardinas VanCamps',1,800,6930,'V');

INSERT INTO product VALUES (200,'Jabon de Baño',2,1000,1850,'F'),(201,'Papel Higienico Nube',2,5671,4900,'F'),(202,'Crema dental Kolynos',2,300,8970,'V'),(203,'Crema de afeitar Barbasol',2,10000,17850,'F'),(204,'Champu Alert Women',2,3000,11250,'F');

INSERT INTO product VALUES (300,'Mouse Genius',3,50,20000,'F'),(301,'Teclado MSI Español',3,20,61500,'F'),(302,'Torre ATX MSI6500',3,100,91300,'F'),
(303,'Memoria DDR4 1TB Hitachi',3,100,180000,'F'),(304,'Pendrive 32GB MSI',3,500,23450,'V');

SELECT * FROM product;

SELECT c.name, p.product_name, p.unit_price
FROM category AS c JOIN product as p
ON c.category_id = p.fk_category_id
WHERE p.unit_price > (
    SELECT AVG(unit_price)
    FROM product
    JOIN category
    ON product.fk_category_id = category.category_id
    WHERE category.category_id = c.category_id
);

SELECT c.name, COUNT(*) AS expensive_products
FROM category AS c JOIN product AS p
ON c.category_id = p.fk_category_id
WHERE p.unit_price > (
    SELECT AVG(unit_price)
    FROM product
    JOIN category
    ON product.fk_category_id = category.category_id
    WHERE category.category_id = c.category_id
)
GROUP BY
c.category_id, c.name;