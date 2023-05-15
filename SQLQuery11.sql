CREATE TRIGGER trgUpdateStockQuantity ON [Order Details] AFTER INSERT
AS
BEGIN
	DECLARE @ProductID int -- �r�n �d de�i�keni tan�mlad�k
	DECLARE @Quantity smallint  
	SELECT @ProductID=ProductID,@Quantity=Quantity FROM inserted

	-- G�ncelleme �ncesi Products tablosundaki UnitsInStock de�erini oku 
	SELECT ProductID,ProductName,UnitsInStock FROM Products WHERE ProductID=@ProductID

	-- Tabloyu yeni de�erle Update etme
	UPDATE Products
	SET UnitsInStock=UnitsInStock - @Quantity
	WHERE ProductID=@ProductID

	-- G�ncellemeden sonra olu�an yeni de�eri oku
	SELECT ProductID,ProductName,UnitsInStock FROM Products WHERE ProductID=@ProductID
END;