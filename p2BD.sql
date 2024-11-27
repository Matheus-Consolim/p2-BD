use mydb;

SELECT 
    f.nome_funcionario AS Nome_Funcionario,
    m.numero_mesa AS Numero_Mesa,
    SUM(p.total_pedido) AS Total_Gasto
FROM 
    atendimento a
INNER JOIN funcionario f ON a.id_atendimento_funcionario = f.id_funcionario
INNER JOIN mesa m ON a.id_atendimento_mesa = m.id_mesa
INNER JOIN pedido p ON p.id_pedido_mesa = m.id_mesa
GROUP BY f.nome_funcionario, m.numero_mesa;


SELECT 
    m.numero_mesa AS Numero_Mesa,
    pr.descricao_produto AS Produto,
    ip.quantidade AS Quantidade,
    ip.subtotal AS Subtotal
FROM 
    pedido p
INNER JOIN itens_pedido ip ON p.id_pedido = ip.id_itens_pedido
INNER JOIN produto pr ON ip.id_itens_produto = pr.id_produto
INNER JOIN mesa m ON p.id_pedido_mesa = m.id_mesa
WHERE 
    m.numero_mesa = '1'; 
    
    DELIMITER $$

CREATE PROCEDURE RedefinirStatusMesa(IN p_id_mesa INT)
BEGIN
    UPDATE mesa
    SET status_mesa = 'Livre'
    WHERE id_mesa = p_id_mesa;
END$$

DELIMITER ;

CALL RedefinirStatusMesa(1);

INSERT INTO funcionario (id_funcionario, nome_funcionario) VALUES
(1, 'Carlos Silva'),
(2, 'Ana Souza'),
(3, 'Pedro Lima');

INSERT INTO cliente (id_cliente, nome_cliente, cpf) VALUES
(1, 'João Santos', '12345678901'),
(2, 'Maria Oliveira', '98765432100'),
(3, 'José Costa', '45678912345');

INSERT INTO mesa (id_mesa, numero_mesa, status_mesa, id_cliente) VALUES
(1, 101, 'Ocupada', 1),
(2, 102, 'Livre', NULL),
(3, 103, 'Sobremesa', 2);

INSERT INTO produto (id_produto, descricao_produto, preco, qtd_estoque) VALUES
(1, 'Pizza Margherita', 40.00, 10),
(2, 'Refrigerante 2L', 10.00, 30),
(3, 'Hambúrguer', 25.00, 20),
(4, 'Cerveja', 8.00, 50),
(5, 'Salada Caesar', 20.00, 15);

INSERT INTO pedido (id_pedido, id_pedido_mesa, id_pedido_cliente, forma_pagamento, total_pedido) VALUES
(1, 1, 1, 'CREDITO', 98.00),
(2, 1, 1, 'PIX', 25.00),
(3, 3, 2, 'DEBITO', 45.00);

INSERT INTO itens_pedido (id_item_pedido, id_itens_pedido, id_itens_produto, quantidade, subtotal) VALUES
(1, 1, 1, 2, 80.00),
(2, 1, 2, 1, 10.00),
(3, 2, 3, 1, 25.00),
(4, 3, 5, 2, 40.00);

INSERT INTO atendimento (id_atendimento, id_atendimento_funcionario, id_atendimento_mesa, data_hora) VALUES
(1, 1, 1, '2024-11-25'),
(2, 2, 3, '2024-11-25'),
(3, 3, 2, '2024-11-25');





    

