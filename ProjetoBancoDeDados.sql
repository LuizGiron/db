create database extensao;

use extensao;

create table Pedidos(
id_pedidos integer auto_increment primary key not null,
data_pedido date not null,
cliente varchar(30)
);
describe Pedidos;

Drop table Pedidos;

create table ItensPedidos(
id_item integer auto_increment primary key not null,
id_pedidos integer not null,
produto varchar(30) not null,
quantidade integer not null,
preco_uni decimal (10, 2),
foreign key (id_pedidos) references Pedidos(id_pedidos)
);
describe ItensPedidos;

insert into Pedidos(id_pedidos, data_pedido, cliente)
values (null, '2024-04-19', "Ana"),
	   (null, '2024-04-19', "João"),
       (null, '2024-04-20', "Davi"),
       (null, '2024-04-20', "Miguel"),
       (null, '2024-04-21', "Luiz"),
       (null, '2024-04-21', "Luciane"),
       (null, '2024-04-21', "Lucas");
       
drop table ItensPedidos;

select * from Pedidos;

SELECT COUNT(*) AS total_pedidos FROM Pedidos;

insert into ItensPedidos(id_item, id_pedidos, produto, quantidade, preco_uni)
values (null, 1, "Camiseta", 5, 500.00),
	   (null, 2, "Calça Jeans", 1, 250.00),
       (null, 3, "Boné", 1, 200.00),
       (null, 4, "Bermuda", 5, 500.00),
       (null, 5, "Camisa Polo", 2, 300.00),
       (null, 6, "Vestido", 1, 1200.00),
       (null, 7, "Regata", 5, 500.00);
       
DELIMITER //

DELIMITER //

CREATE PROCEDURE PopulaPedidosEItensPedidos()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE rand_index INT;
    DECLARE rand_quantidade INT;
    DECLARE rand_preco DECIMAL(10, 2);
    DECLARE rand_produto VARCHAR(30);
    DECLARE base_preco DECIMAL(10, 2);

    WHILE i <= 10000 DO
        -- Inserir dados na tabela Pedidos
        INSERT INTO Pedidos (data_pedido, cliente)
        VALUES ('2024-01-01', CONCAT('Cliente ', i));

        -- Obter o ID do último pedido inserido
        SET @last_id_pedidos = LAST_INSERT_ID();

        -- Selecionar aleatoriamente um produto
        SET rand_index = FLOOR(1 + RAND() * 7); 
        
        -- Definindo a quantidade aleatória entre 1 e 10
        SET rand_quantidade = FLOOR(1 + RAND() * 10);
        
        -- Obter nome e preço base do produto
        CASE rand_index
            WHEN 1 THEN
                SET rand_produto = 'Camiseta';
                SET base_preco = 500.00;
            WHEN 2 THEN
                SET rand_produto = 'Calça Jeans';
                SET base_preco = 250.00;
            WHEN 3 THEN
                SET rand_produto = 'Boné';
                SET base_preco = 200.00;
            WHEN 4 THEN
                SET rand_produto = 'Bermuda';
                SET base_preco = 500.00;
            WHEN 5 THEN
                SET rand_produto = 'Camisa Polo';
                SET base_preco = 300.00;
            WHEN 6 THEN
                SET rand_produto = 'Vestido';
                SET base_preco = 1200.00;
            WHEN 7 THEN
                SET rand_produto = 'Regata';
                SET base_preco = 500.00;
        END CASE;
        
        -- Calcular preço unitário aleatório baseado no preço base
        SET rand_preco = ROUND(base_preco * (0.5 + RAND()), 2); -- Preço entre 50% e 150% do preço base
        
        -- Inserir o registro na tabela ItensPedidos
        INSERT INTO ItensPedidos (id_pedidos, produto, quantidade, preco_uni)
        VALUES (@last_id_pedidos, rand_produto, rand_quantidade, rand_preco);
        
        SET i = i + 1;
    END WHILE;
END //

//

DELIMITER ;

-- Executando o procedimento para popular as tabelas
CALL PopulaPedidosEItensPedidos();


SELECT COUNT(*) AS total_itens_pedidos FROM ItensPedidos;

select Pedidos.id_pedidos, Pedidos.data_pedido, Pedidos.cliente, ItensPedidos.id_item, 
ItensPedidos.produto, ItensPedidos.quantidade, ItensPedidos.preco_uni
from Pedidos
inner join ItensPedidos on Pedidos.id_pedidos = ItensPedidos.id_pedidos;


