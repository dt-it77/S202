-- Base de dades Universidad
use universidad;
-- 1- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select apellido1, apellido2, nombre from persona where tipo = 'alumno' order by apellido1 asc, apellido2 asc, nombre asc;
-- 2- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
select nombre, apellido1, apellido2 from persona where tipo = 'alumno' and telefono is null;
-- 3- Retorna el llistat dels alumnes que van néixer en 1999.
select * from persona where tipo = 'alumno' and YEAR(fecha_nacimiento) = 1999;
-- 4- Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
select * from persona where tipo = 'profesor' and telefono is null and nif like '%K';
-- 5- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
select * from asignatura where cuatrimestre = 1 and curso = 3 and id_grado = 7;
-- 6- Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
select p.apellido1, p.apellido2, p.nombre, d.nombre from persona p inner join profesor ps on ps.id_profesor = p.id inner join departamento d on d.id = ps.id_departamento order by p.apellido1 asc, p.apellido2 asc, p.nombre asc;
-- 7- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
select a.nombre, ce.anyo_inicio, ce.anyo_fin from asignatura a inner join alumno_se_matricula_asignatura asma on asma.id_asignatura = a.id inner join persona p on p.id = asma.id_alumno inner join curso_escolar ce on ce.id = asma.id_curso_escolar where p.nif = '26902806M';
-- 8- Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
select distinct(d.nombre) from grado g inner join asignatura a on a.id_grado = g.id inner join profesor p on p.id_profesor = a.id_profesor inner join departamento d on d.id = p.id_departamento where g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
-- 9- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
select p.nif, p.nombre, p.apellido1, p.apellido2 from persona p inner join alumno_se_matricula_asignatura asma on asma.id_alumno = p.id inner join curso_escolar ce on ce.id = asma.id_curso_escolar where ce.anyo_inicio = 2018 and ce.anyo_fin = 2019 group by p.nif, p.nombre, p.apellido1, p.apellido2;

-- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- 1 - Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select d.nombre as dpto, p.apellido1, p.apellido2, p.nombre from departamento d right join profesor pf on pf.id_departamento = d.id right join persona p on p.id = pf.id_profesor where p.tipo = 'profesor' order by d.nombre asc, p.apellido1 asc, p.apellido2 asc, p.nombre asc;
-- 2 - Retorna un llistat amb els professors que no estan associats a un departament.
select d.nombre as dpto, p.apellido1, p.apellido2, p.nombre from departamento d right join profesor pf on pf.id_departamento = d.id right join persona p on p.id = pf.id_profesor where p.tipo = 'profesor' and d.id is null order by d.nombre asc, p.apellido1 asc, p.apellido2 asc, p.nombre asc;
-- 3 - Retorna un llistat amb els departaments que no tenen professors associats.
select distinct(d.nombre) as dpto from  departamento d left join profesor pf on pf.id_departamento = d.id left join persona p on p.id = pf.id_profesor where pf.id_profesor is null;
-- 4 - Retorna un llistat amb els professors que no imparteixen cap assignatura.
select p.apellido1, p.apellido2, p.nombre from persona p left join asignatura a on a.id_profesor = p.id where p.tipo = 'profesor' and a.id is null order by p.apellido1 asc, p.apellido2 asc, p.nombre asc;
-- 5 - Retorna un llistat amb les assignatures que no tenen un professor assignat.
select a.nombre from persona p right join asignatura a on a.id_profesor = p.id where p.id is null order by a.nombre asc;
-- 6 - Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
select d.nombre from departamento d left join profesor p on p.id_departamento = d.id where p.id_departamento is null;

-- Consultes resum:
-- 1 - Retorna el nombre total d'alumnes que hi ha.
select count(*) from persona where tipo = 'alumno';
-- 2 - Calcula quants alumnes van néixer en 1999.
select count(*) from persona where tipo = 'alumno' and YEAR(fecha_nacimiento) = 1999;
-- 3 - Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
select d.nombre as dpt, count(*) as qty from departamento d inner join profesor p on p.id_departamento = d.id group by d.nombre order by qty desc;
-- 4 - Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.
select d.nombre as dpto, count(pf.id_departamento) as qty from  departamento d left join profesor pf on pf.id_departamento = d.id group by d.nombre order by qty desc;
-- 5 - Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
select g.nombre as grau, count(a.id) as qty from grado g left join asignatura a on a.id_grado = g.id group by g.nombre order by qty desc;
-- 6 - Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
select g.nombre as grau, count(a.id) as qty from grado g left join asignatura a on a.id_grado = g.id group by g.nombre having count(a.id) > 40 order by qty desc;
-- 7 - Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
select g.nombre as grau, a.tipo, SUM(a.creditos) credits from grado g inner join asignatura a on a.id_grado = g.id group by g.nombre, a.tipo;
-- 8 - Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
select ce.anyo_inicio, count(distinct(asma.id_alumno)) from curso_escolar ce inner join alumno_se_matricula_asignatura asma on asma.id_curso_escolar = ce.id group by ce.anyo_inicio;
-- 9 - Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
select p.id, p.nombre, p.apellido1, p.apellido2, count(a.id) as qtyAsignaturas from persona p left join asignatura a on a.id_profesor = p.id right join profesor pf on pf.id_profesor = p.id group by p.id, p.nombre, p.apellido1, p.apellido2 order by qtyAsignaturas desc;
-- 10 - Retorna totes les dades de l'alumne més jove.
select * from persona order by fecha_nacimiento asc limit 1;
-- 11 - Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.
select p.id, p.nombre, p.apellido1, p.apellido2 from persona p left join asignatura a on a.id_profesor = p.id right join profesor pf on pf.id_profesor = p.id where a.id is null;
