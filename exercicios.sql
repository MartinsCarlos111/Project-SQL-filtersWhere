use ContosoRetailDW;

-- filtrando por top, vendas com maior numero  
select top(100) * from FactSales
order by SalesAmount desc;


-- filtrando valores nulos 
select * from DimCustomer 
where FirstName is null;

-- filtrando top 10 produtos com produtos 
select top(10) * from DimProduct 
order by UnitPrice desc, weight desc;

select top(10) * from DimProduct 
order by UnitPrice desc, weight desc, AvailableForSaleDate ASC;

-- trocando de nome
select ProductName AS 'Nome do Produto',
		Weight as 'Peso (Libras)' from DimProduct where Weight > 100 
order by Weight desc;


-- busca de lojas ativas e troca de nome
select StoreName as 'Nome da Loja', 
		OpenDate as 'Datas de abertura', 
		EmployeeCount as 'Numero de funcionarios'
	from DimStore where StoreType = 'Store' AND Status = 'on';


-- busca de datetime
select * from DimProduct;
select * from DimProduct where BrandName = 'Litware' and AvailableForSaleDate = '15/03/2009';


-- busca de lojas inativas 
select StoreName as 'Nome da Loja', 
		OpenDate as 'Datas de abertura', 
		EmployeeCount as 'Numero de funcionarios'
	from DimStore where StoreType = 'Store' AND Status = 'off';

--buscando por lojas fechadas sem usar os status
select * from DimStore where CloseDate is not null;

-- Buscando por maior e menor
select * from DimStore where EmployeeCount > 50;

-- utilizando like para busca
select * from DimProduct 
where ProductDescription like '%LCD%';


--Busca repetitiva 
select * from DimProduct 
where ColorName in ('Green', 'Orange') and BrandName in ('Cotoso', 'Litware');

-- orden by e detween
select * from DimProduct 
where ColorName in ('Silver') and BrandName in ('Contoso') 
and
UnitPrice between 10 and 30 order by UnitPrice desc;

--quantidade total de valores da coluna CustomerKey
select 
count(CustomerKey) as 'qtd. Clientes'
from DimCustomer;

--filtrando total por genero
select 
count(CustomerKey) as 'qtd. Clientes'
from DimCustomer where Gender = 'M';

--filtra o total de dregistros distintos
select 
count(distinct DepartmentName) as 'qtd. Areas'
from DimEmployee;

-- somando e filtrando pelo maior
select sum(SalesQuantity) as 'total vendido'
from FactSales where UnitPrice >= 100;

-- avg para tirar media 
select AVG(salesquantity) as 'media de vendas'
from FactSales
where UnitPrice >= 100;


-- min e max
select min(salesquantity) as 'media de vendas'
from FactSales;

select max(salesquantity) as 'media de vendas'
from FactSales;


--somando e consultando
select sum(SalesQuantity) as 'Quantidade vendida',
sum(ReturnQuantity) as 'Quantidade devolvida' 
from FactSales where channelKey = 1;

-- media salarial dos clientes
select avg(YearlyIncome) as 'Media salarial' from DimCustomer where Occupation = 'Professional';

--quantidade de funcionarios das lojas, max, min e o nome
select max(EmployeeCount) as 'quantidade de funcionarios' from DimStore;
select min(EmployeeCount) as 'quantidade de funcionarios' from DimStore;
select EmployeeCount as 'quantidade de funcionarios', StoreName as 'nome da loja' from DimStore where EmployeeCount = 325;
select EmployeeCount as 'quantidade de funcionarios', StoreName as 'nome da loja' from DimStore where EmployeeCount = 7;

--buscando com subconsulta
select * from DimEmployee;
select 
count(EmployeeKey) as 'qtd. Clientes'
from DimEmployee where Gender = 'M';

select 
count(EmployeeKey) as 'qtd. Clientes'
from DimEmployee where Gender = 'F';

SELECT top 1 HireDate, LastName, EmailAddress  
FROM DimEmployee 
WHERE Gender = 'M';

SELECT top 1 HireDate, LastName, EmailAddress  
FROM DimEmployee 
WHERE Gender = 'F' ;

-- subconsulta
select count(distinct ColorName) as 'Tipos de cores',count(distinct BrandName) as 'Tipos de Marcas',
count(distinct ClassName) as 'Tipos de classes'  from DimProduct;

--  group by
select DepartmentName,
	count(DepartmentName) as 'Total de Funcionarios'
from dimemployee
group by DepartmentName;

--agrupando e ordenando
select StoreType,
		sum(EmployeeCount) as 'Qtd.Total funcionario'
from
	DimStore
group by StoreType
order by sum(EmployeeCount) desc;

-- group mais where 
select 
	colorName as 'Cor do Produto',
	count(colorname) as 'qtd. total'
from
	DimProduct
where BrandName = 'contoso'
group by ColorName;

-- usando having
select 
	BrandName as 'marca',
	count(BrandName) as 'qtd. total'
from
	DimProduct
group by BrandName 
 having count(BrandName) >= 200;

 select 
	BrandName as 'marca',
	count(BrandName) as 'qtd. total'
from
	DimProduct
where ClassName = 'Economy'
group by BrandName 
 having count(BrandName) >= 200;

 -- usando group e having
select sum(SalesQuantity), channelKey 
from FactSales 
group by channelKey;

select 
	StoreKey,
	sum(SalesQuantity) as 'qtd vendida',
	sum(ReturnQuantity) as 'retornou'
from
	FactSales
group by StoreKey;

select 
	channelKey, sum(salesquantity)
from
	factSales
where DateKey between '01/01/2007' and '31/12/2007';

-- 
SELECT top(10) ProductKey, SUM(SalesAmount) AS Valortotalvendido
FROM FactSales 
GROUP BY ProductKey
HAVING SUM(SalesAmount) > 5000000
order by Valortotalvendido desc ;

--
SELECT top 1 CustomerKey, SUM(SalesQuantity) AS Totalvendas
FROM FactOnlineSales
GROUP BY CustomerKey
ORDER BY Totalvendas DESC;
 
SELECT top 3 ProductKey, CustomerKey, SUM(SalesQuantity) AS Totalvendas
FROM FactOnlineSales
GROUP BY CustomerKey
ORDER BY Totalvendas DESC;
select * from FactOnlineSales;
select * from DimStore;

select top 3 ProductKey,SUM(SalesQuantity) AS Totalvendas 
from  FactOnlineSales 
where CustomerKey = 19037
group by ProductKey
order by Totalvendas;

-----------------


select 
	BrandName as 'marca',
	count(BrandName) as 'qtd. total'
from
	DimProduct
group by BrandName ;


select 
	ClassName as 'classename',
	avg(UnitPrice) as 'media'
from
	DimProduct
group by ClassName ;


select 
	ColorName as 'cor',
	count(Weight) as 'peso'
from
	DimProduct
group by ColorName ;

---------
select * from DimProduct;

SELECT
    StockTypeName,
    SUM(Weight) AS peso,
    BrandName
FROM
    DimProduct
WHERE
    BrandName = 'Contoso'
	
	group by StockTypeName, BrandName
	order by peso desc;