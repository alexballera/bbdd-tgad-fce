-- Base de datos : `Jurasik_Park`
-- CREATE database Jurasik_Park;
-- GO

-- Selección de  la base de datos
-- USE Jurasik_Park;
-- GO
-- estructura de tabla para la tabla `escuela`
--
CREATE TABLE escuela (
  Codigo_escuela smallint NOT NULL,
  Nombre_escuela varchar(100) NOT NULL ,
  Domicilio_escuela varchar(200) NOT NULL ,
  PRIMARY KEY NONCLUSTERED  (Codigo_escuela) );
--
-- Volcar la base de datos para la tabla `escuela`
--
INSERT into escuela VALUES(1, 'Escuela Domingo Faustino Sarmiento', 'Soler 219, Capital Federal');
INSERT into escuela VALUES(2, 'Instituto Santa Elena', 'Las Acacias 23 Pinamar');
INSERT into escuela VALUES(3, 'Escuela Nacional Nro 4 Nicolas Avellaneda', 'Salvador y Nicaragua s/n Cordoba');
INSERT into escuela VALUES(4, 'Escuela Tecnica El Tornillo', 'Lomas de Zamora 1 - El Palomar');
INSERT into escuela VALUES(5, 'First Escuela Super Important', 'Av. Extranjera 2154, CABA');
INSERT into escuela VALUES(6, 'Escuela N‹ 28', 'Av. Cordoba 1234, CABA');
INSERT into escuela VALUES(7, 'Escuela N‹ 1 Pte Roque Saenz Pena', 'Av. Córdoba 1951, CABA');
INSERT into escuela VALUES(8, 'Escuela Normal N‹ 8', 'La Rioja 1042, CABA');
INSERT into escuela VALUES(9, 'Escuela Normal Superior N‹ 4 Estanislao Severo Zeballos', 'Av. Rivadavia 4950,CABA');
INSERT into escuela VALUES(10, 'Escuela Educacion Media N‹ 11', 'Av. Espora y Esteban Adrogue s/n, Adrogue');
INSERT into escuela VALUES(11, 'La Sra. Escuela', 'Av Rivadavia 1500');
INSERT into escuela VALUES(12, 'La Mejor Escuela', 'Av de Mayo 2323');
INSERT into escuela VALUES(13, 'Escuela de Educacion Secundaria Tecnica N‹3', 'El Tordo 459, Temperley');
INSERT into escuela VALUES(14, 'Escuela Tecnica N‹6 "Ing. Juan V. Passalacgua"', 'Av. Adolfo Alsina 868, Banfield');
INSERT into escuela VALUES(15, 'Instituto La Salle de Flores', 'Bonifacio 2475, CABA');
INSERT into escuela VALUES(16, 'Instituto San Jose', 'Juan Vucetich 539, CABA');
INSERT into escuela VALUES(17, 'Instituto Facundo Quiroga', 'El Guaycura 836, Ciudad Evita');
INSERT into escuela VALUES(18, 'Instituto Educativo Altos de Laferrere', 'Fardman 1951, Laferrere');
INSERT into escuela VALUES(19, 'EGB N‹ 131 Pcia. Santiago del Estero', 'Alvear 1317, Rafael Castillo');
INSERT into escuela VALUES(20, 'Colegio Almafuerte', 'Guemes 61, Bernal');
INSERT into escuela VALUES(21, 'Escuela Nacional Aprendetodo', 'Av. Corrientes 5628, CABA');
INSERT into escuela VALUES(22, 'Instituto Tecnologico de Datos', 'Carabobo 1265, CABA');
INSERT into escuela VALUES(23, 'Escuela Ecologica "Planeta Verde"', 'Espana 199, CABA');
INSERT into escuela VALUES(24, 'Escuela Deportiva Leonel Messi', 'Gavilan 2151, CABA');
INSERT into escuela VALUES(25, 'Instituto Jose Manuel Estrada', 'Av. San Martin 2150');
INSERT into escuela VALUES(26, 'Escuela N‹ 51', 'La Calandria 5018');
INSERT into escuela VALUES(27, 'Escuela Tecnica Pio IX', 'Yapeyu 197, CABA');
INSERT into escuela VALUES(28, 'Escuela Nicolas Avellaneda', 'Palpa 6589, CABA');
INSERT into escuela VALUES(29, 'Escuela Primaria N‹ 14 Guillermo Enrique Hudson', 'Arregui 6840, CABA');
INSERT into escuela VALUES(30, 'Colegio Buenos Aires', 'Acevedo 357, CABA');
INSERT into escuela VALUES(31, 'EscueLa De Comercio N‹ 32', 'Acasusso 4830, CABA');
INSERT into escuela VALUES(32, 'Escuela Guida Y Spano', 'Ramon Falcon 5800, CABA');
INSERT into escuela VALUES(33, 'Escuela 16 Ernesto Bavio', 'Bahia Blanca 1551');
INSERT into escuela VALUES(34, 'Escuela 35 Tecnica Lazina ', 'Lope de Vega 2115');
INSERT into escuela VALUES(35, 'Escuela Tecnica 17', 'Lacarra 535');
INSERT into escuela VALUES(36, 'Escuela N‹ 124 Luis Jorge Fontana', 'Av. 25 De Mayo 1599, Formosa');
INSERT into escuela VALUES(37, 'Escuela Normal Superior N‹4  Estanislao S. Zeballos.', 'Av. Rivadavia 4950, CABA');


 --------------------------------------------------------
--
-- estructura de tabla para la tabla `guia`
--
CREATE TABLE guia (
  Codigo_Guia smallint NOT NULL,
  apellido_Guia varchar(60) NOT NULL ,
  Nombre_Guia varchar(60) NOT NULL ,
  PRIMARY KEY NONCLUSTERED (Codigo_Guia)
);
--
-- Volcar la base de datos para la tabla `guia`
--
INSERT INTO guia VALUES (1, 'Lopez Aguado', 'Bernardo');
INSERT INTO guia VALUES (2, 'Grondona Echague', 'Victor Manuel');
INSERT INTO guia VALUES (3, 'Morales', 'Victor Hugo');
INSERT INTO guia VALUES (4, 'Fernandez', 'Eleonora');
INSERT INTO guia VALUES (5, 'Zaluzi', 'Cristina');
INSERT INTO guia VALUES (6, 'Fernandez', 'Juan');
INSERT INTO guia VALUES (7, 'Fernandez', 'Maria');
INSERT INTO guia VALUES (8, 'Quito', 'Esteban');
INSERT INTO guia VALUES (9, 'Gimenez', 'Gonzalo');
INSERT INTO guia VALUES (10, 'Aguirre', 'Celeste');
INSERT INTO guia VALUES (11, 'Aguaysol', 'Agustin');
INSERT INTO guia VALUES (12, 'Bonpetit', 'Julieta');
INSERT INTO guia VALUES (13, 'Martinez', 'Pedro');
INSERT INTO guia VALUES (14, 'Gomez', 'Adrian');
INSERT INTO guia VALUES (15, 'Santalla', 'Josefina');
INSERT INTO guia VALUES (16, 'Kumar', 'Marcelo');
INSERT INTO guia VALUES (17, 'Tomassini', 'Tomas');
INSERT INTO guia VALUES (18, 'Hernandez', 'Joaquina');
INSERT INTO guia VALUES (19, 'Acosta ', 'Laura');
INSERT INTO guia VALUES (20, 'Wainstein', 'Liliana');
INSERT INTO guia VALUES (21, 'De La Vega', 'Diego');
INSERT INTO guia VALUES (22, 'De La Mora', 'Paulina');
INSERT INTO guia VALUES (23, 'Guinoa', 'Lucas');
INSERT INTO guia VALUES (24, 'Santa Cruz', 'Cecilia');

 --------------------------------------------------------
--
--estructura de tabla para la tabla `reserva`
--
CREATE TABLE reserva (
  Numero_Reserva int NOT NULL,
  FeCHa_VISITa_ReSeRVaDa smalldatetime NOT NULL ,
  Hora_Visita_Reservada smalldatetime NOT NULL ,
  Codigo_escuela smallint NOT NULL CONSTRAINT FK_codigo_escuela1 REFERENCES escuela,
  PRIMARY KEY  (Numero_Reserva)
);
--
-- Volcar la base de datos para la tabla `reserva`
--
INSERT INTO reserva VALUES (1, '20000410', '08:00:00', 1);
INSERT INTO reserva VALUES (2, '20010523', '09:00:00', 2);
INSERT INTO reserva VALUES (3, '20020614', '10:30:00', 1);
INSERT INTO reserva VALUES (4, '20030510', '11:00:00', 3);
INSERT INTO reserva VALUES (5, '20030511', '09:00:00', 4);
INSERT INTO reserva VALUES (6, '20030510', '09:00:00', 2);
INSERT INTO reserva VALUES (7, '20030510', '14:00:00', 4);
INSERT INTO reserva VALUES (8, '20030510', '11:00:00', 5);
INSERT INTO reserva VALUES (9, '20020614', '13:00:00', 1);
INSERT INTO reserva VALUES (10, '20200515', '12:00:00', 6);
INSERT INTO reserva VALUES (11, '20200501', '11:30:00', 2);
INSERT INTO reserva VALUES (12, '20210302', '11:20:00', 3);
INSERT INTO reserva VALUES (13, '20210326', '09:00:00', 11);
INSERT INTO reserva VALUES (14, '20210310', '10:00:00', 12);
INSERT INTO reserva VALUES (15, '20210410', '09:00:00', 8);
INSERT INTO reserva VALUES (16, '20210211', '10:30:00', 14);
INSERT INTO reserva VALUES (17, '20200321', '09:45:00', 21);
INSERT INTO reserva VALUES (18, '20200830', '13:20:00', 22);
INSERT INTO reserva VALUES (19, '20150904', '16:30:00', 21);
INSERT INTO reserva VALUES (20, '19980610', '14:15:00', 22);
INSERT INTO reserva VALUES (21, '20210211', '10:00:00', 30);
INSERT INTO reserva VALUES (22, '20010510', '14:00:00', 23);
INSERT INTO reserva VALUES (23, '20050525', '14:30:00', 24);
INSERT INTO reserva VALUES (24, '20210430', '09:00:00', 31);
INSERT INTO reserva VALUES (25, '20210430', '15:00:00', 32);
INSERT INTO reserva VALUES (26, '20210430', '15:00:00', 4);
INSERT INTO reserva VALUES (27, '20210429', '10:00:00', 7);
INSERT INTO reserva VALUES (28, '20210427', '14:50:00', 9);
INSERT INTO reserva VALUES (29, '20210508', '10:30:00', 36);
INSERT INTO reserva VALUES (30, '20210509', '14:30:00', 37);
INSERT INTO reserva VALUES (31, '20160818', '09:30:00', 10);
INSERT INTO reserva VALUES (32, '20130406', '12:00:00', 17);
INSERT INTO reserva VALUES (33, '20160720', '11:30:00', 16);
INSERT INTO reserva VALUES (34, '20120512', '11:20:00', 17);
INSERT INTO reserva VALUES (35, '20170913', '09:00:00', 16);
INSERT INTO reserva VALUES (36, '20150520', '10:00:00', 15);
INSERT INTO reserva VALUES (37, '20150615', '09:30:00', 16);
INSERT INTO reserva VALUES (38, '20140820', '08:30:00', 19);
INSERT INTO reserva VALUES (39, '20170417', '08:00:00', 20);
INSERT INTO reserva VALUES (40, '20111022', '11:00:00', 18);
INSERT INTO reserva VALUES (41, '20120925', '10:30:00', 28);
INSERT INTO reserva VALUES (42, '20160818', '09:00:00', 29);
INSERT INTO reserva VALUES (43, '20130410', '10:00:00', 26);
INSERT INTO reserva VALUES (44, '20130913', '10:00:00', 27);
INSERT INTO reserva VALUES (45, '20180602', '10:30:00', 25);
INSERT INTO reserva VALUES (46, '20100711', '11:30:00', 29);
INSERT INTO reserva VALUES (47, '20201218', '11:00:00', 18);
INSERT INTO reserva VALUES (48, '20170712', '08:30:00', 34);
INSERT INTO reserva VALUES (49, '20110610', '08:00:00', 33);
INSERT INTO reserva VALUES (50, '20150719', '12:00:00', 36);
INSERT INTO reserva VALUES (51, '20181201', '10:00:00', 35);
INSERT INTO reserva VALUES (52, '20130503', '09:00:00', 36);
INSERT INTO reserva VALUES (53, '20180831', '12:00:00', 10);
INSERT INTO reserva VALUES (54, '20121220', '12:30:00', 34);
INSERT INTO reserva VALUES (55, '20200508', '11:00:00', 15);
INSERT INTO reserva VALUES (56, '20151223', '08:00:00', 11);
INSERT INTO reserva VALUES (57, '20200523', '09:00:00', 1);
INSERT INTO reserva VALUES (58, '20140202', '10:30:00', 30);
INSERT INTO reserva VALUES (59, '20150131', '12:00:00', 4);
INSERT INTO reserva VALUES (60, '20181008', '11:30:00', 13);
INSERT INTO reserva VALUES (61, '20191223', '09:30:00', 5);
INSERT INTO reserva VALUES (62, '20151018', '08:00:00', 9);
INSERT INTO reserva VALUES (63, '20131125', '10:00:00', 2);
INSERT INTO reserva VALUES (64, '20191026', '08:30:00', 31);
INSERT INTO reserva VALUES (65, '20181118', '10:30:00', 36);
INSERT INTO reserva VALUES (66, '20160330', '11:00:00', 31);
INSERT INTO reserva VALUES (67, '20130326', '09:00:00', 10);
INSERT INTO reserva VALUES (68, '20191029', '09:30:00', 32);
INSERT INTO reserva VALUES (69, '20100109', '12:00:00', 14);
INSERT INTO reserva VALUES (70, '20140413', '10:00:00', 37);
INSERT INTO reserva VALUES (71, '20150719', '09:00:00', 24);
INSERT INTO reserva VALUES (72, '20130503', '12:00:00', 9);
INSERT INTO reserva VALUES (73, '20121220', '12:30:00', 24);
INSERT INTO reserva VALUES (74, '20190821', '11:00:00', 10);
INSERT INTO reserva VALUES (75, '20121206', '08:00:00', 4);
INSERT INTO reserva VALUES (76, '20190122', '09:00:00', 23);
INSERT INTO reserva VALUES (77, '20120715', '10:30:00', 21);
INSERT INTO reserva VALUES (78, '20181229', '12:00:00', 11);
INSERT INTO reserva VALUES (79, '20170214', '11:30:00', 6);
INSERT INTO reserva VALUES (80, '20151223', '09:30:00', 10);

 --------------------------------------------------------
--
-- estructura de tabla para la tabla `telefono_escuela`
--
CREATE TABLE telefono_escuela (
  Codigo_escuela smallint NOT NULL CONSTRAINT FK_codigo_escuela2 REFERENCES escuela,
  Telefono_escuela varchar(16) NOT NULL,
  PRIMARY KEY  (Codigo_escuela,Telefono_escuela)
);
--
-- Volcar la base de datos para la tabla `telefono_escuela`
--
INSERT INTO telefono_escuela VALUES (1, '4591-1221');
INSERT INTO telefono_escuela VALUES (2, '1212-1212');
INSERT INTO telefono_escuela VALUES (3, '5151-5151');
INSERT INTO telefono_escuela VALUES (4, '4441-6661');
INSERT INTO telefono_escuela VALUES (5, '1122-3344');
INSERT INTO telefono_escuela VALUES (7, '4813-7373');
INSERT INTO telefono_escuela VALUES (9, '4901-1582');
INSERT INTO telefono_escuela VALUES (10, '4294-0300');
INSERT INTO telefono_escuela VALUES (11, '4456-7766');
INSERT INTO telefono_escuela VALUES (13, '4269-8948');
INSERT INTO telefono_escuela VALUES (15, '4422-3041');
INSERT INTO telefono_escuela VALUES (17, '4487-5027');
INSERT INTO telefono_escuela VALUES (19, '4690-4231');
INSERT INTO telefono_escuela VALUES (21, '4354-9812');
INSERT INTO telefono_escuela VALUES (23, '4569-4789');
INSERT INTO telefono_escuela VALUES (25, '4212-5839');
INSERT INTO telefono_escuela VALUES (27, '4864-2121');
INSERT INTO telefono_escuela VALUES (28, '4555-3887');
INSERT INTO telefono_escuela VALUES (29, '4642-8772');
INSERT INTO telefono_escuela VALUES (31, '4775-4891');
INSERT INTO telefono_escuela VALUES (33, '45667411');
INSERT INTO telefono_escuela VALUES (36, '03717-434116');
INSERT INTO telefono_escuela VALUES (37, '011 4901-1582');
INSERT INTO telefono_escuela VALUES (1, '4591-2411');
INSERT INTO telefono_escuela VALUES (2, '1212-1213');
INSERT INTO telefono_escuela VALUES (3, '5451-5151');
INSERT INTO telefono_escuela VALUES (5, '4433-2211');
INSERT INTO telefono_escuela VALUES (7, '4816-2853');
INSERT INTO telefono_escuela VALUES (11, '4422-5679');
INSERT INTO telefono_escuela VALUES (15, '4432-3344');
INSERT INTO telefono_escuela VALUES (28, '4551-8978');
INSERT INTO telefono_escuela VALUES (37, '4901-9429');
INSERT INTO telefono_escuela VALUES (1, '4591-2413');
INSERT INTO telefono_escuela VALUES (2, '1212-1215');
INSERT INTO telefono_escuela VALUES (7, '4813-7703');
INSERT INTO telefono_escuela VALUES (37, '4902-8022');




 --------------------------------------------------------
--
-- estructura de tabla para la tabla `tipo_visita`
--
CREATE TABLE tipo_visita (
  Codigo_Tipo_Visita tinyint NOT NULL,
  Descripcion_Tipo_Visita varchar(200) NOT NULL,
  arancel_por_alumno decimal(8,2) NOT NULL ,
  PRIMARY KEY  (Codigo_Tipo_Visita)
);
INSERT INTO tipo_visita VALUES (1, 'Parque de Brontosaurios', 10);
INSERT INTO tipo_visita VALUES (2, 'Los Mamuts en Familia', 8);
INSERT INTO tipo_visita VALUES (3, 'Las Tortugas Prehistoricas', 4);
INSERT INTO tipo_visita VALUES (4, 'Laguna de Nahuelito', 6);
INSERT INTO tipo_visita VALUES (5, 'Las cenizas del meteorito mortal', 8);
INSERT INTO tipo_visita VALUES (6, 'Visita a los huevos de mama Dino', 10);
INSERT INTO tipo_visita VALUES (7, 'Dinos argentinos', 6);
INSERT INTO tipo_visita VALUES (8, 'Zoo', 11);
INSERT INTO tipo_visita VALUES (9, 'Plantas exoticas', 12);
INSERT INTO tipo_visita VALUES (10, 'Mini exploadores, buscando dinos', 9);
INSERT INTO tipo_visita VALUES (11, 'Jardin Botanico', 18);
INSERT INTO tipo_visita VALUES (12, 'El mundo de Avatar', 20);
INSERT INTO tipo_visita VALUES (13, 'Circuito de los 7 lagos', 30);
INSERT INTO tipo_visita VALUES (14, 'ReptoSaurios', 40);
INSERT INTO tipo_visita VALUES (15, 'Lagartos', 1);
INSERT INTO tipo_visita VALUES (16, 'Laboratorio', 40);
INSERT INTO tipo_visita VALUES (17, 'Museo Tiranosaurio Rex', 15);


--
-- estructura de tabla para la tabla `grado`
--
CREATE TABLE grado (
  Numero_grado tinyint NOT NULL,
  Descripcion_grado varchar(60) NOT NULL,
  PRIMARY KEY NONCLUSTERED (Numero_grado)
);
--
-- Volcar la base de datos para la tabla `grado`
--
INSERT INTO grado VALUES (1, 'Primer grado');
INSERT INTO grado VALUES (2, 'Segundo grado');
INSERT INTO grado VALUES (3, 'Tercer grado');
INSERT INTO grado VALUES (4, 'Cuarto grado');
INSERT INTO grado VALUES (5, 'Quinto grado');
INSERT INTO grado VALUES (6, 'Sexto grado');
INSERT INTO grado VALUES (7, 'Septimo grado');
INSERT INTO grado VALUES (8, 'Octavo grado');
INSERT INTO grado VALUES (9, 'Noveno grado');
 --------------------------------------------------------
--
-- estructura de tabla para la tabla `reserva_tipo_visita`
--
CREATE TABLE reserva_tipo_visita (
  Numero_Reserva int NOT NULL CONSTRAINT FK_numero_reserva1 REFERENCES Reserva,
  Codigo_Tipo_Visita tinyint NOT NULL  CONSTRAINT FK_codigo_tipo_visita1 REFERENCES Tipo_Visita,
  Codigo_Guia smallint  NOT NULL  CONSTRAINT FK_codigo_guia1 REFERENCES Guia,
  Cantidad_alumnos_Reservados smallint NOT NULL ,
  Cantidad_alumnos_Reales smallint ,
  PRIMARY KEY  (Numero_Reserva,Codigo_Tipo_Visita)
);
--
-- Volcar la base de datos para la tabla `reserva_tipo_visita`
--
INSERT INTO reserva_tipo_visita VALUES (1, 2, 1, 25, 21);
INSERT INTO reserva_tipo_visita VALUES (1, 1, 2, 30, 25);
INSERT INTO reserva_tipo_visita VALUES (1, 3, 3, 110, 89);
INSERT INTO reserva_tipo_visita VALUES (2, 1, 3, 56, 50);
INSERT INTO reserva_tipo_visita VALUES (2, 4, 4, 90, 78);
INSERT INTO reserva_tipo_visita VALUES (2, 3, 5, 100, 53);
INSERT INTO reserva_tipo_visita VALUES (3, 3, 2, 21, 15);
INSERT INTO reserva_tipo_visita VALUES (3, 1, 4, 42, 22);
INSERT INTO reserva_tipo_visita VALUES (3, 2, 1, 54, 46);
INSERT INTO reserva_tipo_visita VALUES (3, 4, 5, 110, 98);
INSERT INTO reserva_tipo_visita VALUES (4, 1, 1, 120, 103);
INSERT INTO reserva_tipo_visita VALUES (4, 2, 3, 130, 125);
INSERT INTO reserva_tipo_visita VALUES (5, 3, 5, 114, 112);
INSERT INTO reserva_tipo_visita VALUES (5, 2, 4, 95, 90);
INSERT INTO reserva_tipo_visita VALUES (6, 5, 5, 65, 52);
INSERT INTO reserva_tipo_visita VALUES (6, 14, 15, 37, 37);
INSERT INTO reserva_tipo_visita VALUES (6, 1, 12, 93, 53);
INSERT INTO reserva_tipo_visita VALUES (7, 2, 2, 210, 190);
INSERT INTO reserva_tipo_visita VALUES (7, 13, 15, 57, 50);
INSERT INTO reserva_tipo_visita VALUES (7, 3, 15, 44, 42);
INSERT INTO reserva_tipo_visita VALUES (8, 1, 1, 25, 20);
INSERT INTO reserva_tipo_visita VALUES (8, 2, 3, 32, 26);
INSERT INTO reserva_tipo_visita VALUES (9, 5, 5, 70, 68);
INSERT INTO reserva_tipo_visita VALUES (9, 15, 16, 67, 60);
INSERT INTO reserva_tipo_visita VALUES (9, 14, 18, 70, 68);
INSERT INTO reserva_tipo_visita VALUES (10, 3, 6, 80, 80);
INSERT INTO reserva_tipo_visita VALUES (10, 10, 16, 89, 55);
INSERT INTO reserva_tipo_visita VALUES (10, 2, 11, 83, 81);
INSERT INTO reserva_tipo_visita VALUES (11, 6, 9, 30, 28);
INSERT INTO reserva_tipo_visita VALUES (11, 5, 13, 87, 59);
INSERT INTO reserva_tipo_visita VALUES (12, 7, 11, 45, 38);
INSERT INTO reserva_tipo_visita VALUES (12, 1, 14, 91, 74);
INSERT INTO reserva_tipo_visita VALUES (13, 8, 18, 109, 60);
INSERT INTO reserva_tipo_visita VALUES (13, 1, 10, 107, 31);
INSERT INTO reserva_tipo_visita VALUES (14, 3, 5, 72, 53);
INSERT INTO reserva_tipo_visita VALUES (15, 7, 22, 45, 32);
INSERT INTO reserva_tipo_visita VALUES (15, 11, 10, 108, 47);
INSERT INTO reserva_tipo_visita VALUES (16, 3, 19, 68, 27);
INSERT INTO reserva_tipo_visita VALUES (16, 16, 9, 55, 34);
INSERT INTO reserva_tipo_visita VALUES (16, 8, 15, 48, 35);
INSERT INTO reserva_tipo_visita VALUES (17, 12, 22, 98, 36);
INSERT INTO reserva_tipo_visita VALUES (17, 11, 21, 300, 125);
INSERT INTO reserva_tipo_visita VALUES (18, 12, 22, 132, 75);
INSERT INTO reserva_tipo_visita VALUES (18, 11, 21, 54, 21);
INSERT INTO reserva_tipo_visita VALUES (19, 12, 22, 67, 60);
INSERT INTO reserva_tipo_visita VALUES (19, 11, 21, 140, 128);
INSERT INTO reserva_tipo_visita VALUES (20, 11, 22, 78, 40);
INSERT INTO reserva_tipo_visita VALUES (20, 12, 21, 29, 10);
INSERT INTO reserva_tipo_visita VALUES (21, 1, 23, 30, 20);
INSERT INTO reserva_tipo_visita VALUES (21, 2, 8, 25, 20);
INSERT INTO reserva_tipo_visita VALUES (22, 2, 2, 80, 41);
INSERT INTO reserva_tipo_visita VALUES (22, 8, 3, 75, 55);
INSERT INTO reserva_tipo_visita VALUES (23, 2, 2, 50, 50);
INSERT INTO reserva_tipo_visita VALUES (23, 13, 24, 100, 95);
INSERT INTO reserva_tipo_visita VALUES (24, 15, 3, 49, 40);
INSERT INTO reserva_tipo_visita VALUES (24, 12, 5, 91, 79);
INSERT INTO reserva_tipo_visita VALUES (25, 16, 6, 28, 20);
INSERT INTO reserva_tipo_visita VALUES (25, 4, 24, 102, 46);
INSERT INTO reserva_tipo_visita VALUES (26, 1, 2, 67, 60);
INSERT INTO reserva_tipo_visita VALUES (26, 4, 6, 92, 43);
INSERT INTO reserva_tipo_visita VALUES (26, 14, 3, 106, 44);
INSERT INTO reserva_tipo_visita VALUES (27, 2, 5, 43, 40);
INSERT INTO reserva_tipo_visita VALUES (27, 1, 23, 81, 65);
INSERT INTO reserva_tipo_visita VALUES (28, 3, 5, 23, 20);
INSERT INTO reserva_tipo_visita VALUES (28, 7, 2, 62, 49);
INSERT INTO reserva_tipo_visita VALUES (29, 10, 2, 40, 40);
INSERT INTO reserva_tipo_visita VALUES (29, 6, 9, 86, 62);
INSERT INTO reserva_tipo_visita VALUES (29, 13, 3, 63, 52);
INSERT INTO reserva_tipo_visita VALUES (30, 11, 4, 30, 20);
INSERT INTO reserva_tipo_visita VALUES (30, 10, 2, 89, 52);
INSERT INTO reserva_tipo_visita VALUES (30, 8, 16, 78, 60);
INSERT INTO reserva_tipo_visita VALUES (30, 4, 18, 68, 32);
INSERT INTO reserva_tipo_visita VALUES (31, 9, 21, 95, 86);
INSERT INTO reserva_tipo_visita VALUES (31, 4, 15, 102, 96);
INSERT INTO reserva_tipo_visita VALUES (32, 5, 12, 86, 42);
INSERT INTO reserva_tipo_visita VALUES (33, 3, 12, 77, 56);
INSERT INTO reserva_tipo_visita VALUES (33, 10, 24, 100, 89);
INSERT INTO reserva_tipo_visita VALUES (34, 15, 6, 90, 78);
INSERT INTO reserva_tipo_visita VALUES (35, 5, 4, 100, 36);
INSERT INTO reserva_tipo_visita VALUES (36, 11, 23, 97, 63);
INSERT INTO reserva_tipo_visita VALUES (36, 3, 21, 95, 68);
INSERT INTO reserva_tipo_visita VALUES (36, 7, 13, 79, 54);
INSERT INTO reserva_tipo_visita VALUES (36, 6, 18, 105, 62);
INSERT INTO reserva_tipo_visita VALUES (37, 3, 15, 84, 84);
INSERT INTO reserva_tipo_visita VALUES (37, 8, 3, 78, 30);
INSERT INTO reserva_tipo_visita VALUES (38, 7, 15, 109, 71);
INSERT INTO reserva_tipo_visita VALUES (38, 1, 21, 77, 46);
INSERT INTO reserva_tipo_visita VALUES (38, 5, 21, 104, 83);
INSERT INTO reserva_tipo_visita VALUES (39, 12, 5, 92, 75);
INSERT INTO reserva_tipo_visita VALUES (40, 17, 16, 103, 43);
INSERT INTO reserva_tipo_visita VALUES (40, 12, 6, 108, 72);
INSERT INTO reserva_tipo_visita VALUES (41, 10, 15, 102, 102);
INSERT INTO reserva_tipo_visita VALUES (41, 15, 13, 49, 45);
INSERT INTO reserva_tipo_visita VALUES (42, 7, 22, 103, 50);
INSERT INTO reserva_tipo_visita VALUES (43, 13, 23, 105, 28);
INSERT INTO reserva_tipo_visita VALUES (44, 6, 16, 81, 75);
INSERT INTO reserva_tipo_visita VALUES (44, 16, 24, 71, 38);
INSERT INTO reserva_tipo_visita VALUES (45, 17, 11, 76, 57);
INSERT INTO reserva_tipo_visita VALUES (45, 6, 24, 97, 94);
INSERT INTO reserva_tipo_visita VALUES (45, 7, 8, 91, 63);
INSERT INTO reserva_tipo_visita VALUES (46, 13, 1, 56, 51);
INSERT INTO reserva_tipo_visita VALUES (47, 1, 5, 59, 42);
INSERT INTO reserva_tipo_visita VALUES (47, 13, 18, 97, 62);
INSERT INTO reserva_tipo_visita VALUES (48, 7, 19, 78, 27);
INSERT INTO reserva_tipo_visita VALUES (49, 2, 12, 86, 27);
INSERT INTO reserva_tipo_visita VALUES (49, 10, 12, 67, 34);
INSERT INTO reserva_tipo_visita VALUES (50, 7, 8, 83, 60);
INSERT INTO reserva_tipo_visita VALUES (51, 9, 16, 67, 44);
INSERT INTO reserva_tipo_visita VALUES (52, 10, 12, 52, 37);
INSERT INTO reserva_tipo_visita VALUES (52, 5, 16, 102, 67);
INSERT INTO reserva_tipo_visita VALUES (52, 6, 22, 54, 53);
INSERT INTO reserva_tipo_visita VALUES (53, 5, 4, 39, 35);
INSERT INTO reserva_tipo_visita VALUES (54, 8, 6, 45, 37);
INSERT INTO reserva_tipo_visita VALUES (54, 17, 14, 36, 32);
INSERT INTO reserva_tipo_visita VALUES (55, 4, 21, 51, 48);
INSERT INTO reserva_tipo_visita VALUES (55, 6, 8, 55, 30);
INSERT INTO reserva_tipo_visita VALUES (56, 4, 7, 44, 42);
INSERT INTO reserva_tipo_visita VALUES (57, 13, 23, 83, 37);
INSERT INTO reserva_tipo_visita VALUES (58, 17, 23, 96, 33);
INSERT INTO reserva_tipo_visita VALUES (58, 3, 7, 108, 54);
INSERT INTO reserva_tipo_visita VALUES (58, 12, 15, 71, 54);
INSERT INTO reserva_tipo_visita VALUES (59, 7, 4, 82, 39);
INSERT INTO reserva_tipo_visita VALUES (60, 17, 1, 56, 32);
INSERT INTO reserva_tipo_visita VALUES (60, 15, 23, 53, 51);
INSERT INTO reserva_tipo_visita VALUES (61, 11, 8, 88, 30);
INSERT INTO reserva_tipo_visita VALUES (62, 8, 11, 58, 44);
INSERT INTO reserva_tipo_visita VALUES (63, 15, 13, 85, 37);
INSERT INTO reserva_tipo_visita VALUES (63, 5, 14, 58, 33);
INSERT INTO reserva_tipo_visita VALUES (64, 1, 9, 37, 28);
INSERT INTO reserva_tipo_visita VALUES (65, 15, 16, 93, 84);
INSERT INTO reserva_tipo_visita VALUES (65, 12, 24, 109, 32);
INSERT INTO reserva_tipo_visita VALUES (66, 6, 8, 80, 51);
INSERT INTO reserva_tipo_visita VALUES (67, 15, 5, 96, 55);
INSERT INTO reserva_tipo_visita VALUES (68, 1, 15, 62, 53);
INSERT INTO reserva_tipo_visita VALUES (69, 4, 2, 44, 30);
INSERT INTO reserva_tipo_visita VALUES (70, 16, 10, 106, 44);
INSERT INTO reserva_tipo_visita VALUES (70, 9, 23, 67, 28);
INSERT INTO reserva_tipo_visita VALUES (70, 8, 4, 65, 35);
INSERT INTO reserva_tipo_visita VALUES (71, 8, 19, 41, 33);
INSERT INTO reserva_tipo_visita VALUES (72, 6, 5, 104, 28);
INSERT INTO reserva_tipo_visita VALUES (72, 10, 2, 110, 84);
INSERT INTO reserva_tipo_visita VALUES (73, 16, 23, 66, 44);
INSERT INTO reserva_tipo_visita VALUES (73, 1, 12, 58, 43);
INSERT INTO reserva_tipo_visita VALUES (73, 10, 3, 79, 44);
INSERT INTO reserva_tipo_visita VALUES (73, 4, 16, 31, 31);
INSERT INTO reserva_tipo_visita VALUES (74, 12, 1, 88, 43);
INSERT INTO reserva_tipo_visita VALUES (75, 2, 10, 54, 32);
INSERT INTO reserva_tipo_visita VALUES (75, 7, 4, 27, 27);
INSERT INTO reserva_tipo_visita VALUES (75, 17, 15, 59, 31);
INSERT INTO reserva_tipo_visita VALUES (76, 15, 15, 103, 100);
INSERT INTO reserva_tipo_visita VALUES (77, 9, 1, 95, 47);
INSERT INTO reserva_tipo_visita VALUES (77, 1, 15, 61, 25);
INSERT INTO reserva_tipo_visita VALUES (78, 11, 23, 99, 50);
INSERT INTO reserva_tipo_visita VALUES (78, 13, 13, 60, 47);
INSERT INTO reserva_tipo_visita VALUES (78, 1, 13, 106, 68);
INSERT INTO reserva_tipo_visita VALUES (79, 4, 18, 33, 33);
INSERT INTO reserva_tipo_visita VALUES (80, 2, 18, 109, 104);
INSERT INTO reserva_tipo_visita VALUES (80, 4, 16, 60, 55);
INSERT INTO reserva_tipo_visita VALUES (80, 10, 4, 105, 96);


 --------------------------------------------------------
--
-- estructura de tabla para la tabla `reserva_por_grado`
--
CREATE TABLE reserva_por_grado (
  Numero_Reserva int NOT NULL ,
  Codigo_Tipo_Visita tinyint NOT NULL ,
  Numero_grado tinyint NOT NULL CONSTRAINT FK_numero_grado1 REFERENCES Grado,
  PRIMARY KEY  (Numero_Reserva,Codigo_Tipo_Visita,Numero_grado)
);
--
-- Volcar la base de datos para la tabla `reserva_por_grdo`
--
INSERT INTO reserva_por_grado VALUES (1, 1, 2);
INSERT INTO reserva_por_grado VALUES (1, 2, 1);
INSERT INTO reserva_por_grado VALUES (1, 2, 5);
INSERT INTO reserva_por_grado VALUES (1, 2, 6);
INSERT INTO reserva_por_grado VALUES (1, 3, 3);
INSERT INTO reserva_por_grado VALUES (1, 3, 7);
INSERT INTO reserva_por_grado VALUES (2, 1, 5);
INSERT INTO reserva_por_grado VALUES (2, 1, 7);
INSERT INTO reserva_por_grado VALUES (2, 3, 7);
INSERT INTO reserva_por_grado VALUES (2, 4, 4);
INSERT INTO reserva_por_grado VALUES (3, 1, 4);
INSERT INTO reserva_por_grado VALUES (3, 2, 1);
INSERT INTO reserva_por_grado VALUES (3, 3, 2);
INSERT INTO reserva_por_grado VALUES (3, 4, 5);
INSERT INTO reserva_por_grado VALUES (4, 1, 4);
INSERT INTO reserva_por_grado VALUES (4, 2, 3);
INSERT INTO reserva_por_grado VALUES (5, 2, 6);
INSERT INTO reserva_por_grado VALUES (5, 3, 5);
INSERT INTO reserva_por_grado VALUES (6, 1, 5);
INSERT INTO reserva_por_grado VALUES (6, 1, 6);
INSERT INTO reserva_por_grado VALUES (6, 5, 5);
INSERT INTO reserva_por_grado VALUES (6, 14, 6);
INSERT INTO reserva_por_grado VALUES (7, 2, 1);
INSERT INTO reserva_por_grado VALUES (7, 2, 2);
INSERT INTO reserva_por_grado VALUES (7, 2, 3);
INSERT INTO reserva_por_grado VALUES (7, 3, 1);
INSERT INTO reserva_por_grado VALUES (7, 3, 2);
INSERT INTO reserva_por_grado VALUES (7, 3, 3);
INSERT INTO reserva_por_grado VALUES (7, 13, 1);
INSERT INTO reserva_por_grado VALUES (7, 13, 2);
INSERT INTO reserva_por_grado VALUES (7, 13, 3);
INSERT INTO reserva_por_grado VALUES (8, 1, 3);
INSERT INTO reserva_por_grado VALUES (8, 2, 4);
INSERT INTO reserva_por_grado VALUES (9, 5, 5);
INSERT INTO reserva_por_grado VALUES (9, 5, 7);
INSERT INTO reserva_por_grado VALUES (9, 14, 5);
INSERT INTO reserva_por_grado VALUES (9, 14, 6);
INSERT INTO reserva_por_grado VALUES (9, 15, 6);
INSERT INTO reserva_por_grado VALUES (9, 15, 7);
INSERT INTO reserva_por_grado VALUES (10, 2, 2);
INSERT INTO reserva_por_grado VALUES (10, 2, 6);
INSERT INTO reserva_por_grado VALUES (10, 3, 1);
INSERT INTO reserva_por_grado VALUES (10, 10, 2);
INSERT INTO reserva_por_grado VALUES (10, 10, 4);
INSERT INTO reserva_por_grado VALUES (11, 5, 1);
INSERT INTO reserva_por_grado VALUES (11, 5, 5);
INSERT INTO reserva_por_grado VALUES (11, 6, 3);
INSERT INTO reserva_por_grado VALUES (12, 1, 4);
INSERT INTO reserva_por_grado VALUES (12, 7, 2);
INSERT INTO reserva_por_grado VALUES (12, 7, 6);
INSERT INTO reserva_por_grado VALUES (13, 1, 2);
INSERT INTO reserva_por_grado VALUES (13, 1, 8);
INSERT INTO reserva_por_grado VALUES (13, 8, 1);
INSERT INTO reserva_por_grado VALUES (13, 8, 2);
INSERT INTO reserva_por_grado VALUES (14, 3, 4);
INSERT INTO reserva_por_grado VALUES (14, 3, 5);
INSERT INTO reserva_por_grado VALUES (15, 7, 4);
INSERT INTO reserva_por_grado VALUES (15, 7, 6);
INSERT INTO reserva_por_grado VALUES (15, 11, 6);
INSERT INTO reserva_por_grado VALUES (15, 11, 7);
INSERT INTO reserva_por_grado VALUES (16, 3, 1);
INSERT INTO reserva_por_grado VALUES (16, 3, 3);
INSERT INTO reserva_por_grado VALUES (16, 8, 1);
INSERT INTO reserva_por_grado VALUES (16, 8, 4);
INSERT INTO reserva_por_grado VALUES (16, 16, 2);
INSERT INTO reserva_por_grado VALUES (16, 16, 3);
INSERT INTO reserva_por_grado VALUES (17, 11, 1);
INSERT INTO reserva_por_grado VALUES (17, 12, 7);
INSERT INTO reserva_por_grado VALUES (18, 11, 5);
INSERT INTO reserva_por_grado VALUES (18, 12, 2);
INSERT INTO reserva_por_grado VALUES (19, 11, 3);
INSERT INTO reserva_por_grado VALUES (19, 11, 5);
INSERT INTO reserva_por_grado VALUES (19, 12, 3);
INSERT INTO reserva_por_grado VALUES (19, 12, 5);
INSERT INTO reserva_por_grado VALUES (20, 11, 6);
INSERT INTO reserva_por_grado VALUES (20, 12, 4);
INSERT INTO reserva_por_grado VALUES (21, 1, 6);
INSERT INTO reserva_por_grado VALUES (21, 1, 7);
INSERT INTO reserva_por_grado VALUES (21, 2, 4);
INSERT INTO reserva_por_grado VALUES (22, 2, 1);
INSERT INTO reserva_por_grado VALUES (22, 2, 5);
INSERT INTO reserva_por_grado VALUES (22, 8, 4);
INSERT INTO reserva_por_grado VALUES (23, 2, 2);
INSERT INTO reserva_por_grado VALUES (23, 2, 3);
INSERT INTO reserva_por_grado VALUES (23, 13, 4);
INSERT INTO reserva_por_grado VALUES (23, 13, 7);
INSERT INTO reserva_por_grado VALUES (24, 12, 2);
INSERT INTO reserva_por_grado VALUES (24, 15, 4);
INSERT INTO reserva_por_grado VALUES (24, 15, 7);
INSERT INTO reserva_por_grado VALUES (25, 4, 1);
INSERT INTO reserva_por_grado VALUES (25, 4, 6);
INSERT INTO reserva_por_grado VALUES (25, 16, 5);
INSERT INTO reserva_por_grado VALUES (25, 16, 7);
INSERT INTO reserva_por_grado VALUES (26, 1, 1);
INSERT INTO reserva_por_grado VALUES (26, 4, 3);
INSERT INTO reserva_por_grado VALUES (26, 14, 2);
INSERT INTO reserva_por_grado VALUES (26, 14, 7);
INSERT INTO reserva_por_grado VALUES (27, 1, 2);
INSERT INTO reserva_por_grado VALUES (27, 2, 3);
INSERT INTO reserva_por_grado VALUES (27, 2, 5);
INSERT INTO reserva_por_grado VALUES (28, 3, 1);
INSERT INTO reserva_por_grado VALUES (28, 7, 1);
INSERT INTO reserva_por_grado VALUES (28, 7, 5);
INSERT INTO reserva_por_grado VALUES (29, 6, 4);
INSERT INTO reserva_por_grado VALUES (29, 10, 3);
INSERT INTO reserva_por_grado VALUES (29, 10, 7);
INSERT INTO reserva_por_grado VALUES (29, 13, 4);
INSERT INTO reserva_por_grado VALUES (29, 13, 7);
INSERT INTO reserva_por_grado VALUES (30, 4, 1);
INSERT INTO reserva_por_grado VALUES (30, 4, 6);
INSERT INTO reserva_por_grado VALUES (30, 8, 1);
INSERT INTO reserva_por_grado VALUES (30, 8, 5);
INSERT INTO reserva_por_grado VALUES (30, 10, 3);
INSERT INTO reserva_por_grado VALUES (30, 10, 6);
INSERT INTO reserva_por_grado VALUES (30, 11, 5);
INSERT INTO reserva_por_grado VALUES (31, 4, 1);
INSERT INTO reserva_por_grado VALUES (31, 4, 5);
INSERT INTO reserva_por_grado VALUES (31, 9, 1);
INSERT INTO reserva_por_grado VALUES (31, 9, 6);
INSERT INTO reserva_por_grado VALUES (32, 5, 1);
INSERT INTO reserva_por_grado VALUES (32, 5, 3);
INSERT INTO reserva_por_grado VALUES (33, 3, 4);
INSERT INTO reserva_por_grado VALUES (33, 3, 7);
INSERT INTO reserva_por_grado VALUES (33, 10, 2);
INSERT INTO reserva_por_grado VALUES (33, 10, 3);
INSERT INTO reserva_por_grado VALUES (34, 15, 3);
INSERT INTO reserva_por_grado VALUES (34, 15, 5);
INSERT INTO reserva_por_grado VALUES (35, 5, 4);
INSERT INTO reserva_por_grado VALUES (35, 5, 7);
INSERT INTO reserva_por_grado VALUES (36, 3, 3);
INSERT INTO reserva_por_grado VALUES (36, 3, 5);
INSERT INTO reserva_por_grado VALUES (36, 6, 2);
INSERT INTO reserva_por_grado VALUES (36, 6, 3);
INSERT INTO reserva_por_grado VALUES (36, 7, 2);
INSERT INTO reserva_por_grado VALUES (36, 7, 4);
INSERT INTO reserva_por_grado VALUES (36, 11, 4);
INSERT INTO reserva_por_grado VALUES (36, 11, 5);
INSERT INTO reserva_por_grado VALUES (37, 3, 5);
INSERT INTO reserva_por_grado VALUES (37, 3, 7);
INSERT INTO reserva_por_grado VALUES (37, 8, 1);
INSERT INTO reserva_por_grado VALUES (37, 8, 5);
INSERT INTO reserva_por_grado VALUES (38, 1, 1);
INSERT INTO reserva_por_grado VALUES (38, 1, 7);
INSERT INTO reserva_por_grado VALUES (38, 5, 4);
INSERT INTO reserva_por_grado VALUES (38, 5, 6);
INSERT INTO reserva_por_grado VALUES (38, 7, 1);
INSERT INTO reserva_por_grado VALUES (38, 7, 2);
INSERT INTO reserva_por_grado VALUES (39, 12, 5);
INSERT INTO reserva_por_grado VALUES (40, 12, 5);
INSERT INTO reserva_por_grado VALUES (40, 12, 6);
INSERT INTO reserva_por_grado VALUES (40, 17, 2);
INSERT INTO reserva_por_grado VALUES (40, 17, 4);
INSERT INTO reserva_por_grado VALUES (41, 10, 2);
INSERT INTO reserva_por_grado VALUES (41, 10, 5);
INSERT INTO reserva_por_grado VALUES (41, 15, 2);
INSERT INTO reserva_por_grado VALUES (41, 15, 4);
INSERT INTO reserva_por_grado VALUES (42, 7, 2);
INSERT INTO reserva_por_grado VALUES (43, 13, 1);
INSERT INTO reserva_por_grado VALUES (43, 13, 4);
INSERT INTO reserva_por_grado VALUES (44, 6, 1);
INSERT INTO reserva_por_grado VALUES (44, 6, 5);
INSERT INTO reserva_por_grado VALUES (44, 16, 1);
INSERT INTO reserva_por_grado VALUES (44, 16, 2);
INSERT INTO reserva_por_grado VALUES (45, 6, 4);
INSERT INTO reserva_por_grado VALUES (45, 6, 5);
INSERT INTO reserva_por_grado VALUES (45, 7, 1);
INSERT INTO reserva_por_grado VALUES (45, 7, 3);
INSERT INTO reserva_por_grado VALUES (45, 17, 2);
INSERT INTO reserva_por_grado VALUES (45, 17, 6);
INSERT INTO reserva_por_grado VALUES (46, 13, 2);
INSERT INTO reserva_por_grado VALUES (46, 13, 7);
INSERT INTO reserva_por_grado VALUES (47, 1, 1);
INSERT INTO reserva_por_grado VALUES (47, 1, 7);
INSERT INTO reserva_por_grado VALUES (47, 13, 3);
INSERT INTO reserva_por_grado VALUES (47, 13, 6);
INSERT INTO reserva_por_grado VALUES (48, 7, 3);
INSERT INTO reserva_por_grado VALUES (48, 7, 4);
INSERT INTO reserva_por_grado VALUES (49, 2, 1);
INSERT INTO reserva_por_grado VALUES (49, 2, 4);
INSERT INTO reserva_por_grado VALUES (49, 10, 3);
INSERT INTO reserva_por_grado VALUES (49, 10, 5);
INSERT INTO reserva_por_grado VALUES (50, 7, 2);
INSERT INTO reserva_por_grado VALUES (50, 7, 3);
INSERT INTO reserva_por_grado VALUES (51, 9, 2);
INSERT INTO reserva_por_grado VALUES (51, 9, 6);
INSERT INTO reserva_por_grado VALUES (52, 5, 2);
INSERT INTO reserva_por_grado VALUES (52, 5, 5);
INSERT INTO reserva_por_grado VALUES (52, 6, 1);
INSERT INTO reserva_por_grado VALUES (52, 10, 3);
INSERT INTO reserva_por_grado VALUES (52, 10, 7);
INSERT INTO reserva_por_grado VALUES (53, 5, 7);
INSERT INTO reserva_por_grado VALUES (54, 8, 1);
INSERT INTO reserva_por_grado VALUES (54, 8, 4);
INSERT INTO reserva_por_grado VALUES (54, 17, 2);
INSERT INTO reserva_por_grado VALUES (54, 17, 7);
INSERT INTO reserva_por_grado VALUES (55, 4, 4);
INSERT INTO reserva_por_grado VALUES (55, 4, 6);
INSERT INTO reserva_por_grado VALUES (55, 6, 7);
INSERT INTO reserva_por_grado VALUES (56, 4, 2);
INSERT INTO reserva_por_grado VALUES (56, 4, 3);
INSERT INTO reserva_por_grado VALUES (57, 13, 1);
INSERT INTO reserva_por_grado VALUES (57, 13, 7);
INSERT INTO reserva_por_grado VALUES (58, 3, 1);
INSERT INTO reserva_por_grado VALUES (58, 3, 3);
INSERT INTO reserva_por_grado VALUES (58, 12, 7);
INSERT INTO reserva_por_grado VALUES (58, 17, 1);
INSERT INTO reserva_por_grado VALUES (58, 17, 2);
INSERT INTO reserva_por_grado VALUES (59, 7, 5);
INSERT INTO reserva_por_grado VALUES (59, 7, 7);
INSERT INTO reserva_por_grado VALUES (60, 15, 1);
INSERT INTO reserva_por_grado VALUES (60, 15, 2);
INSERT INTO reserva_por_grado VALUES (60, 15, 6);
INSERT INTO reserva_por_grado VALUES (60, 17, 1);
INSERT INTO reserva_por_grado VALUES (60, 17, 2);
INSERT INTO reserva_por_grado VALUES (61, 11, 5);
INSERT INTO reserva_por_grado VALUES (61, 11, 7);
INSERT INTO reserva_por_grado VALUES (62, 8, 1);
INSERT INTO reserva_por_grado VALUES (62, 8, 6);
INSERT INTO reserva_por_grado VALUES (63, 5, 1);
INSERT INTO reserva_por_grado VALUES (63, 5, 5);
INSERT INTO reserva_por_grado VALUES (63, 5, 6);
INSERT INTO reserva_por_grado VALUES (63, 15, 4);
INSERT INTO reserva_por_grado VALUES (63, 15, 6);
INSERT INTO reserva_por_grado VALUES (64, 1, 5);
INSERT INTO reserva_por_grado VALUES (64, 1, 7);
INSERT INTO reserva_por_grado VALUES (65, 12, 5);
INSERT INTO reserva_por_grado VALUES (65, 12, 6);
INSERT INTO reserva_por_grado VALUES (65, 15, 2);
INSERT INTO reserva_por_grado VALUES (65, 15, 6);
INSERT INTO reserva_por_grado VALUES (66, 6, 1);
INSERT INTO reserva_por_grado VALUES (66, 6, 3);
INSERT INTO reserva_por_grado VALUES (67, 15, 1);
INSERT INTO reserva_por_grado VALUES (67, 15, 2);
INSERT INTO reserva_por_grado VALUES (68, 1, 2);
INSERT INTO reserva_por_grado VALUES (68, 1, 5);
INSERT INTO reserva_por_grado VALUES (69, 4, 4);
INSERT INTO reserva_por_grado VALUES (69, 4, 5);
INSERT INTO reserva_por_grado VALUES (70, 8, 2);
INSERT INTO reserva_por_grado VALUES (70, 8, 5);
INSERT INTO reserva_por_grado VALUES (70, 9, 4);
INSERT INTO reserva_por_grado VALUES (70, 16, 2);
INSERT INTO reserva_por_grado VALUES (70, 16, 3);
INSERT INTO reserva_por_grado VALUES (71, 8, 3);
INSERT INTO reserva_por_grado VALUES (71, 8, 5);
INSERT INTO reserva_por_grado VALUES (72, 6, 2);
INSERT INTO reserva_por_grado VALUES (72, 6, 3);
INSERT INTO reserva_por_grado VALUES (72, 10, 1);
INSERT INTO reserva_por_grado VALUES (72, 10, 2);
INSERT INTO reserva_por_grado VALUES (72, 10, 4);
INSERT INTO reserva_por_grado VALUES (73, 1, 3);
INSERT INTO reserva_por_grado VALUES (73, 1, 7);
INSERT INTO reserva_por_grado VALUES (73, 4, 2);
INSERT INTO reserva_por_grado VALUES (73, 4, 6);
INSERT INTO reserva_por_grado VALUES (73, 10, 2);
INSERT INTO reserva_por_grado VALUES (73, 10, 4);
INSERT INTO reserva_por_grado VALUES (73, 16, 1);
INSERT INTO reserva_por_grado VALUES (73, 16, 2);
INSERT INTO reserva_por_grado VALUES (74, 12, 1);
INSERT INTO reserva_por_grado VALUES (74, 12, 3);
INSERT INTO reserva_por_grado VALUES (75, 2, 7);
INSERT INTO reserva_por_grado VALUES (75, 2, 9);
INSERT INTO reserva_por_grado VALUES (75, 7, 2);
INSERT INTO reserva_por_grado VALUES (75, 7, 7);
INSERT INTO reserva_por_grado VALUES (75, 17, 1);
INSERT INTO reserva_por_grado VALUES (75, 17, 2);
INSERT INTO reserva_por_grado VALUES (76, 15, 3);
INSERT INTO reserva_por_grado VALUES (76, 15, 5);
INSERT INTO reserva_por_grado VALUES (77, 1, 4);
INSERT INTO reserva_por_grado VALUES (77, 1, 7);
INSERT INTO reserva_por_grado VALUES (77, 9, 4);
INSERT INTO reserva_por_grado VALUES (77, 9, 7);
INSERT INTO reserva_por_grado VALUES (78, 1, 2);
INSERT INTO reserva_por_grado VALUES (78, 1, 5);
INSERT INTO reserva_por_grado VALUES (78, 1, 7);
INSERT INTO reserva_por_grado VALUES (78, 11, 7);
INSERT INTO reserva_por_grado VALUES (78, 13, 2);
INSERT INTO reserva_por_grado VALUES (79, 4, 5);
INSERT INTO reserva_por_grado VALUES (79, 4, 4);
INSERT INTO reserva_por_grado VALUES (80, 2, 5);
INSERT INTO reserva_por_grado VALUES (80, 2, 6);
INSERT INTO reserva_por_grado VALUES (80, 2, 7);
INSERT INTO reserva_por_grado VALUES (80, 4, 5);
INSERT INTO reserva_por_grado VALUES (80, 10, 6);
INSERT INTO reserva_por_grado VALUES (80, 10, 7);

 --------------------------------------------------------

alter TABLE [dbo].[reserva_por_grado]  WITH check add  CONSTRAINT [FK_reserva_por_grado_reserva_tipo_visita] foreign KEY([Numero_Reserva], [Codigo_Tipo_Visita])
REFERENCES [dbo].[reserva_tipo_visita] ([Numero_Reserva], [Codigo_Tipo_Visita])