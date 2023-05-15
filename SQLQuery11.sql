CREATE TRIGGER trgUpdateStockQuantity ON [Order Details] AFTER INSERT
AS
BEGIN
	DECLARE @ProductID int -- ürün ýd deðiþkeni tanýmladýk
	DECLARE @Quantity smallint  
	SELECT @ProductID=ProductID,@Quantity=Quantity FROM inserted

	-- Güncelleme öncesi Products tablosundaki UnitsInStock deðerini oku 
	SELECT ProductID,ProductName,UnitsInStock FROM Products WHERE ProductID=@ProductID

	-- Tabloyu yeni deðerle Update etme
	UPDATE Products
	SET UnitsInStock=UnitsInStock - @Quantity
	WHERE ProductID=@ProductID

	-- Güncellemeden sonra oluþan yeni deðeri oku
	SELECT ProductID,ProductName,UnitsInStock FROM Products WHERE ProductID=@ProductID
END;