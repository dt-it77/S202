-- Base de dades Tienda
use tienda;
-- 1 - Llista el nom de tots els productos que hi ha en la taula producto.
select nombre from producto;
-- 2 - Llista els noms i els preus de tots els productos de la taula producto.
select nombre, precio from producto;
-- 3 - Llista totes les columnes de la taula producto.
select * from producto;
-- 4 - Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD). Suposo que el preu esta en euros
select nombre, precio, round(precio*1.0807,2) from producto;
-- 5 - Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dolars.
select nombre as 'nom de producto', precio as euros, round(precio*1.0807,2) as dolars from producto;
-- 6 -  Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a majúscula.
select UPPER(nombre), precio from producto;
-- 7 - Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a minúscula.
select LOWER(nombre), precio from producto;
-- 8 - Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
select nombre, UPPER(LEFT(nombre,2)) from producto;
-- 9 - Llista els noms i els preus de tots els productos de la taula producto, arrodonint el valor del preu.
select nombre, round(precio) from producto;
-- 10 - Llista els noms i els preus de tots els productos de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
select nombre, TRUNCATE(precio,0) from producto;
-- 11 - Llista el codi dels fabricants que tenen productos en la taula producto.
select fabricante.codigo from fabricante inner join producto on producto.codigo_fabricante = fabricante.codigo;
-- 12 - Llista el codi dels fabricants que tenen productos en la taula producto, eliminant els codis que apareixen repetits.
select distinct(fabricante.codigo) from fabricante inner join producto on producto.codigo_fabricante = fabricante.codigo;
-- 13 - Llista els noms dels fabricants ordenats de manera ascendent.
select nombre from fabricante order by nombre Asc;
-- 14 - Llista els noms dels fabricants ordenats de manera descendent.
select nombre from fabricante order by nombre Desc;
-- 15 - Llista els noms dels productos ordenats en primer lloc pel nom de manera ascendent i en segon lloc pel preu de manera descendent.
select nombre from producto order by nombre asc, precio desc;
-- 16 - Retorna una llista amb les 5 primeres files de la taula fabricante.
select * from fabricante Limit 5;
-- 17 - Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
select * from fabricante Limit 3, 2; -- equivalent a select * from fabricante Limit 2 offset 3;
-- 18 - Llista el nom i el preu del producto més barat. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY
select nombre, precio from producto order by precio asc Limit 1;
-- 19 - Llista el nom i el preu del producto més car. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
select nombre, precio from producto order by precio desc Limit 1;
-- 20 - Llista el nom de tots els productos del fabricant el codi de fabricant del qual és igual a 2.
select nombre from producto where codigo_fabricante = 2;
-- 21 - Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante;
-- 22 -Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordeni el resultat pel nom del fabricador, per ordre alfabètic.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante order by f.nombre asc;
-- 23 - Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
select p.codigo, p.nombre, f.codigo, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante;
-- 24 - Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante order by p.precio asc limit 1;
-- 25 - Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante order by p.precio desc limit 1;
-- 26 - Retorna una llista de tots els productes del fabricador Lenovo.
select p.nombre, p.precio from producto p inner join fabricante f on f.codigo = p.codigo_fabricante where f.nombre = 'Lenovo';
-- 27 - Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200€.
select p.nombre, p.precio from producto p inner join fabricante f on f.codigo = p.codigo_fabricante where f.nombre = 'Crucial' and p.precio > 200;
-- 28 - Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante where f.nombre = 'Asus' or f.nombre = 'Hewlett-Packard' or f.nombre = 'Seagate';
-- 29 - Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Utilitzant l'operador IN.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante where f.nombre IN  ('Asus','Hewlett-Packard','Seagate');
-- 30 - Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante where f.nombre like '%e';
-- 31 - Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante where f.nombre like '%w%';
-- 32 - Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180€. Ordeni el resultat en primer lloc pel preu (en ordre descendent) i en segon lloc pel nom (en ordre ascendent) 
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on f.codigo = p.codigo_fabricante where p.precio >= 180 order by p.precio desc, p.nombre asc;
-- 33 - Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
select codigo, nombre from fabricante where codigo in (select codigo_fabricante from producto);
-- 34 - Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
select p.nombre, p.precio, f.nombre from fabricante f left join producto p on f.codigo = p.codigo_fabricante;
-- 35 -- Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
select codigo, nombre from fabricante where codigo not in (select codigo_fabricante from producto);
-- 36 - Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
select * from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo');
-- 37 - Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricador Lenovo. (Sense utilitzar INNER JOIN).
select * from producto where precio = (select precio from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo') order by precio desc limit 1);
-- 38 - Llista el nom del producte més car del fabricador Lenovo.
select nombre from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo') order by precio desc limit 1;
-- 39 - Llista el nom del producte més barat del fabricant Hewlett-Packard.
select nombre from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Hewlett-Packard') order by precio asc limit 1;
-- 40 - Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricador Lenovo.
select * from producto where precio >= (select precio from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Lenovo') order by precio desc limit 1);
-- 41 - Llesta tots els productes del fabricador Asus que tenen un preu superior al preu mitjà de tots els seus productes.
select * from producto where precio > (select AVG(precio) from producto where codigo_fabricante = (select codigo from fabricante where nombre = 'Asus')) and codigo_fabricante = (select codigo from fabricante where nombre = 'Asus'); -- preu mitja de productes asus i busquem sobre els productes asus un altre cop