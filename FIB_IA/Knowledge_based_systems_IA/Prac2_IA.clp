; Fri May 19 17:00:52 GST 2017
;
;+ (version "3.5")
;+ (build "Build 663")
(defclass %3ACLIPS_TOP_LEVEL_SLOT_CLASS "Fake class to save top-level slot information"
	(is-a USER)
	(role abstract)
	(single-slot BebidaM
		(type SYMBOL)
;+		(allowed-parents Bebida)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Postre
		(type SYMBOL)
;+		(allowed-parents Plato)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot PrecioP
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Tiene
		(type SYMBOL)
;+		(allowed-parents Ingredientes)
		(create-accessor read-write))
	(multislot Num_com
		(type INTEGER)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot Presupuesto
		(type INTEGER)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot Especiales
		(type SYMBOL)
		(allowed-values vegano sin_gluten sin_lactosa vegetariano pesado ligero japones italiano frances sibarita)
		(create-accessor read-write))
	(single-slot Calidad
		(type INTEGER)
		(range 0 5)
		(default 0)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot TipoA
		(type SYMBOL)
		(allowed-values cerveza cava vino_blanco vino_tinto vino_negro)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Precio
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot CalidadM
		(type INTEGER)
		(range 0 5)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Primero
		(type SYMBOL)
;+		(allowed-parents Plato)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Segundo
		(type SYMBOL)
;+		(allowed-parents Plato)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Ingrediente
		(type SYMBOL)
;+		(allowed-parents Ingredientes)
		(create-accessor read-write))
	(multislot Componentes
		(type INSTANCE)
;+		(allowed-classes Ingredientes)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(single-slot Complejidad
;+		(comment "0 to 5")
		(type INTEGER)
		(range 0 5)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot NoTiene
		(type SYMBOL)
;+		(allowed-parents Ingredientes)
		(create-accessor read-write))
	(single-slot CantidadR
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot N
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot NombreB
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot PrecioB
		(type FLOAT)
		(default 0.0)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot MenuEvento
		(type SYMBOL)
;+		(allowed-parents Menu)
		(cardinality 0 3)
		(create-accessor read-write))
	(multislot MenuP
		(type SYMBOL)
;+		(allowed-parents Menu)
		(create-accessor read-write))
	(single-slot TipoE
;+		(comment "Deberia ser Symbol")
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot MayorQue
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot EspecialM
		(type SYMBOL)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot CalidadR
		(type INTEGER)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot NombreI
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Gama
		(type SYMBOL)
		(allowed-values baja media alta)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Restricciones
		(type SYMBOL)
;+		(allowed-parents)
		(create-accessor read-write))
	(single-slot Temporada
		(type SYMBOL)
		(allowed-values verano todas primavera otono invierno)
		(default todas)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot PrecioMenu
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Caliente
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Refresco
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot TipoI
		(type SYMBOL)
		(allowed-values lacteos proteina_animal hidratos fruta%2Fverdura grasas condimentos otros dulces legumbre carne pescado huevos marisco)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot NombreP
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Orden
		(type SYMBOL)
		(allowed-values Primero Segundo Postre)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot TipoEst
;+		(comment "???")
		(type STRING)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(multislot Clasificacion
		(type SYMBOL)
		(allowed-values sopa ensalada bocadillo tapa asado plancha frito fruta reposteria pasta)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot NoIngrediente
		(type SYMBOL)
;+		(allowed-parents Ingredientes)
		(create-accessor read-write)))

(defclass Menu
	(is-a USER)
	(role concrete)
	(single-slot BebidaM
		(type SYMBOL)
;+		(allowed-parents Bebida)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Postre
		(type SYMBOL)
;+		(allowed-parents Plato)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot PrecioMenu
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Primero
		(type SYMBOL)
;+		(allowed-parents Plato)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Segundo
		(type SYMBOL)
;+		(allowed-parents Plato)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Plato
	(is-a USER)
	(role concrete)
	(single-slot Temporada
		(type SYMBOL)
		(allowed-values verano todas primavera otono invierno)
		(default todas)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot NombreP
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Especiales
		(type SYMBOL)
		(allowed-values vegano sin_gluten sin_lactosa vegetariano pesado ligero japones italiano frances sibarita)
		(create-accessor read-write))
	(single-slot Orden
		(type SYMBOL)
		(allowed-values Primero Segundo Postre)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Caliente
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot PrecioP
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(multislot Componentes
		(type INSTANCE)
;+		(allowed-classes Ingredientes)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(single-slot Calidad
		(type INTEGER)
		(range 0 5)
		(default 0)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot Complejidad
;+		(comment "0 to 5")
		(type INTEGER)
		(range 0 5)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Bebida
	(is-a USER)
	(role concrete)
	(single-slot PrecioB
		(type FLOAT)
		(default 0.0)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot NombreB
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass Alcohol
	(is-a Bebida)
	(role concrete)
	(single-slot TipoA
		(type SYMBOL)
		(allowed-values cerveza cava vino_blanco vino_tinto vino_negro)
;+		(cardinality 0 1)
		(create-accessor read-write))
	(single-slot Gama
		(type SYMBOL)
		(allowed-values baja media alta)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass NoAlcohol
	(is-a Bebida)
	(role concrete)
	(single-slot Refresco
		(type SYMBOL)
		(allowed-values FALSE TRUE)
;+		(cardinality 0 1)
		(create-accessor read-write)))

(defclass Ingredientes
	(is-a USER)
	(role concrete)
	(single-slot Precio
		(type FLOAT)
;+		(cardinality 1 1)
		(create-accessor read-write))
	(single-slot NombreI
		(type STRING)
;+		(cardinality 1 1)
		(create-accessor read-write)))

(defclass AllMenus
	(is-a USER)
	(role concrete)
	(multislot MenuP
		(type SYMBOL)
;+		(allowed-parents Menu)
		(create-accessor read-write)))



(definstances instancies
	([ProtegeMenu_Class0] of  Plato

		(Calidad 2)
		(Caliente TRUE)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class3]
			[ProtegeMenu_Class2]
			[Proyect2_Class20016]
			[Proyect2_Class1])
		(Especiales vegetariano sin_lactosa)
		(NombreP "patatas con alioli")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10] of  Ingredientes

		(NombreI "harina")
		(Precio 0.1))

	([ProtegeMenu_Class10000] of  Plato

		(Calidad 2)
		(Caliente TRUE)
		(Complejidad 3)
		(Componentes
			[ProtegeMenu_Class10001]
			[Proyect2_Class1]
			[ProtegeMenu_Class10002]
			[Proyect2_Class20016]
			[ProtegeMenu_Class6]
			[ProtegeMenu_Class10003]
			[Proyect2_Class10011]
			[Proyect2_Class10028]
			[Proyect2_Class10029])
		(Especiales japones)
		(NombreP "ramen")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10001] of  Ingredientes

		(NombreI "panceta cerdo")
		(Precio 0.5))

	([ProtegeMenu_Class10002] of  Ingredientes

		(NombreI "fideos")
		(Precio 0.7))

	([ProtegeMenu_Class10003] of  Ingredientes

		(NombreI "soja")
		(Precio 0.3))

	([ProtegeMenu_Class10004] of  Plato

		(Calidad 2)
		(Complejidad 2)
		(Componentes
			[Proyect2_Class20004]
			[ProtegeMenu_Class7]
			[Proyect2_Class10032]
			[Proyect2_Class10028]
			[Proyect2_Class10034]
			[ProtegeMenu_Class6])
		(Especiales vegano japones ligero sin_gluten sin_lactosa)
		(NombreP "tsukemono")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10005] of  Plato

		(Calidad 2)
		(Complejidad 0)
		(Componentes
			[Proyect2_Class10022]
			[Proyect2_Class10014]
			[ProtegeMenu_Class5]
			[Proyect2_Class20004])
		(Especiales japones ligero)
		(NombreP "onigiri")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10006] of  Plato

		(Calidad 3)
		(Caliente TRUE)
		(Complejidad 4)
		(Componentes
			[ProtegeMenu_Class10]
			[Proyect2_Class10032]
			[Proyect2_Class1]
			[Proyect2_Class10002]
			[ProtegeMenu_Class10007])
		(Especiales japones sin_lactosa)
		(NombreP "okonomiyaki")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class10007] of  Ingredientes

		(NombreI "puerro")
		(Precio 0.6))

	([ProtegeMenu_Class10008] of  Plato

		(Calidad 3)
		(Caliente TRUE)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class10002]
			[Proyect2_Class20016]
			[Proyect2_Class10002]
			[Proyect2_Class10032]
			[ProtegeMenu_Class10009]
			[Proyect2_Class20002]
			[Proyect2_Class10028])
		(Especiales japones)
		(NombreP "yakisoba")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10009] of  Ingredientes

		(NombreI "salsa yakisoba")
		(Precio 0.2))

	([ProtegeMenu_Class10011] of  Plato

		(Calidad 3)
		(Caliente TRUE)
		(Complejidad 3)
		(Componentes
			[ProtegeMenu_Class10]
			[Proyect2_Class10000]
			[Proyect2_Class20004]
			[Proyect2_Class1]
			[Proyect2_Class20020]
			[ProtegeMenu_Class10012]
			[ProtegeMenu_Class10013]
			[ProtegeMenu_Class10003]
			[ProtegeMenu_Class10009]
			[Proyect2_Class20014])
		(Especiales japones ligero)
		(NombreP "takoyaki")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10012] of  Ingredientes

		(NombreI "pulpo")
		(Precio 7.5))

	([ProtegeMenu_Class10013] of  Ingredientes

		(NombreI "levadura")
		(Precio 0.1))

	([ProtegeMenu_Class10014] of  Plato

		(Calidad 3)
		(Complejidad 2)
		(Componentes
			[ProtegeMenu_Class11]
			[ProtegeMenu_Class10002]
			[Proyect2_Class10029]
			[Proyect2_Class20016]
			[Proyect2_Class20004]
			[ProtegeMenu_Class10015])
		(Especiales italiano)
		(NombreP "trenette al pesto")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class10015] of  Ingredientes

		(NombreI "piñon")
		(Precio 0.3))

	([ProtegeMenu_Class10016] of  Plato

		(Calidad 4)
		(Complejidad 3)
		(Componentes
			[Proyect2_Class1]
			[Proyect2_Class10000]
			[ProtegeMenu_Class10017]
			[Proyect2_Class20021]
			[ProtegeMenu_Class10018]
			[ProtegeMenu_Class10019])
		(Especiales italiano vegetariano)
		(NombreP "tiramisu de fabio")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class10017] of  Ingredientes

		(NombreI "bizcocho")
		(Precio 2.0))

	([ProtegeMenu_Class10018] of  Ingredientes

		(NombreI "cafe individual")
		(Precio 0.5))

	([ProtegeMenu_Class10019] of  Ingredientes

		(NombreI "cacao")
		(Precio 0.8))

	([ProtegeMenu_Class10020] of  Plato

		(Calidad 1)
		(Caliente TRUE)
		(Complejidad 3)
		(Componentes
			[ProtegeMenu_Class10]
			[ProtegeMenu_Class11]
			[Proyect2_Class20007]
			[ProtegeMenu_Class10021]
			[Proyect2_Class20016]
			[Proyect2_Class20006]
			[Proyect2_Class20020]
			[Proyect2_Class20004]
			[ProtegeMenu_Class10013])
		(Especiales italiano pesado)
		(NombreP "pizza")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class10021] of  Ingredientes

		(NombreI "albahaca")
		(Precio 0.1))

	([ProtegeMenu_Class10022] of  Plato

		(Calidad 3)
		(Complejidad 2)
		(Componentes
			[Proyect2_Class10028]
			[ProtegeMenu_Class15]
			[Proyect2_Class10011]
			[Proyect2_Class20020]
			[ProtegeMenu_Class10023]
			[ProtegeMenu_Class14]
			[Proyect2_Class20002]
			[Proyect2_Class20004]
			[Proyect2_Class20016]
			[ProtegeMenu_Class11]
			[ProtegeMenu_Class10002])
		(Especiales italiano sibarita)
		(NombreP "spaghetti al ragu alla bolognese")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class10023] of  Ingredientes

		(NombreI "nuez")
		(Precio 0.35))

	([ProtegeMenu_Class10024] of  Plato

		(Calidad 1)
		(Complejidad 0)
		(Componentes
			[Proyect2_Class1]
			[Proyect2_Class10000]
			[Proyect2_Class20001]
			[Proyect2_Class20020]
			[ProtegeMenu_Class10025]
			[ProtegeMenu_Class10026])
		(Especiales frances vegetariano sin_gluten ligero)
		(NombreP "flan")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class10025] of  Ingredientes

		(NombreI "vainilla")
		(Precio 0.4))

	([ProtegeMenu_Class10026] of  Ingredientes

		(NombreI "limon")
		(Precio 0.3))

	([ProtegeMenu_Class10027] of  Plato

		(Calidad 4)
		(Complejidad 2)
		(Componentes
			[Proyect2_Class1]
			[Proyect2_Class10024]
			[ProtegeMenu_Class10]
			[Proyect2_Class20020]
			[Proyect2_Class10000]
			[Proyect2_Class20004]
			[ProtegeMenu_Class10028])
		(Especiales frances ligero vegetariano)
		(NombreP "crepes")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class10028] of  Ingredientes

		(NombreI "chocolate")
		(Precio 2.0))

	([ProtegeMenu_Class10029] of  Plato

		(Calidad 1)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class10030]
			[Proyect2_Class20012]
			[Proyect2_Class20021]
			[ProtegeMenu_Class10031]
			[ProtegeMenu_Class10028]
			[ProtegeMenu_Class10032]
			[ProtegeMenu_Class10033]
			[ProtegeMenu_Class10025])
		(Especiales vegetariano ligero)
		(NombreP "helado de fresa y platano")
		(Orden Postre)
		(Temporada verano))

	([ProtegeMenu_Class10030] of  Ingredientes

		(NombreI "platano")
		(Precio 0.4))

	([ProtegeMenu_Class10031] of  Ingredientes

		(NombreI "leche condensada")
		(Precio 0.8))

	([ProtegeMenu_Class10032] of  Ingredientes

		(NombreI "barquillo")
		(Precio 0.05))

	([ProtegeMenu_Class10033] of  Ingredientes

		(NombreI "menta")
		(Precio 0.1))

	([ProtegeMenu_Class10034] of  Plato

		(Calidad 2)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class1]
			[Proyect2_Class10000]
			[ProtegeMenu_Class10]
			[ProtegeMenu_Class10013]
			[ProtegeMenu_Class10025])
		(Especiales vegetariano sin_lactosa)
		(NombreP "brazo de gitano")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class10035] of  Plato

		(Calidad 3)
		(Caliente FALSE)
		(Complejidad 2)
		(Componentes
			[ProtegeMenu_Class2]
			[Proyect2_Class20020]
			[Proyect2_Class20021]
			[Proyect2_Class10024]
			[Proyect2_Class10029]
			[ProtegeMenu_Class10023]
			[Proyect2_Class20004])
		(Especiales frances vegetariano ligero sibarita)
		(NombreP "le gratin dauphinois")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class10036] of  Plato

		(Calidad 2)
		(Complejidad 2)
		(Componentes
			[Proyect2_Class10014]
			[Proyect2_Class10029]
			[Proyect2_Class10011]
			[ProtegeMenu_Class10037]
			[ProtegeMenu_Class10007]
			[ProtegeMenu_Class10023]
			[Proyect2_Class20002]
			[ProtegeMenu_Class10038]
			[ProtegeMenu_Class16])
		(Especiales italiano vegano)
		(NombreP "risotto vegano de setas")
		(Temporada todas))

	([ProtegeMenu_Class10037] of  Ingredientes

		(NombreI "leche de soja")
		(Precio 0.75))

	([ProtegeMenu_Class10038] of  Ingredientes

		(NombreI "champiñones")
		(Precio 3.5))

	([ProtegeMenu_Class10039] of  Plato

		(Calidad 2)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class10014]
			[ProtegeMenu_Class8]
			[ProtegeMenu_Class10038]
			[Proyect2_Class20007]
			[Proyect2_Class10011]
			[ProtegeMenu_Class10021])
		(Especiales sin_gluten vegano ligero)
		(NombreP "aguacate rellenos de arroz")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10040] of  Plato

		(Calidad 2)
		(Caliente TRUE)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class10011]
			[Proyect2_Class20016]
			[Proyect2_Class10029]
			[Proyect2_Class10024]
			[ProtegeMenu_Class10])
		(Especiales frances vegano sibarita vegetariano)
		(NombreP "la soupe a loignons")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class10041] of  Plato

		(Calidad 3)
		(Caliente FALSE)
		(Complejidad 4)
		(Componentes
			[Proyect2_Class20007]
			[Proyect2_Class10030]
			[ProtegeMenu_Class7]
			[Proyect2_Class10011]
			[Proyect2_Class20000]
			[Proyect2_Class10029]
			[Proyect2_Class20016]
			[Proyect2_Class20004]
			[ProtegeMenu_Class6])
		(Especiales vegano vegetariano sin_lactosa)
		(NombreP "gaspacho")
		(Orden Primero)
		(Temporada verano))

	([ProtegeMenu_Class11] of  Ingredientes

		(NombreI "queso parmesano")
		(Precio 3.0))

	([ProtegeMenu_Class12] of  Ingredientes

		(NombreI "espinacas")
		(Precio 1.8))

	([ProtegeMenu_Class13] of  Plato

		(Calidad 3)
		(Caliente TRUE)
		(Complejidad 4)
		(Componentes
			[ProtegeMenu_Class14]
			[ProtegeMenu_Class15]
			[Proyect2_Class10030]
			[Proyect2_Class10011]
			[ProtegeMenu_Class11]
			[Proyect2_Class10024]
			[ProtegeMenu_Class10]
			[Proyect2_Class20016]
			[Proyect2_Class20004])
		(Especiales italiano)
		(NombreP "canelones")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class14] of  Ingredientes

		(NombreI "tomate frito")
		(Precio 0.8))

	([ProtegeMenu_Class15] of  Ingredientes

		(NombreI "carne picada")
		(Precio 3.0))

	([ProtegeMenu_Class16] of  Ingredientes

		(NombreI "girgola")
		(Precio 3.6))

	([ProtegeMenu_Class2] of  Ingredientes

		(NombreI "patata")
		(Precio 0.5))

	([ProtegeMenu_Class20000] of  Plato

		(Calidad 1)
		(Caliente FALSE)
		(Complejidad 2)
		(Componentes
			[ProtegeMenu_Class10]
			[Proyect2_Class10000]
			[ProtegeMenu_Class10019]
			[Proyect2_Class20020]
			[ProtegeMenu_Class10025]
			[Proyect2_Class1]
			[ProtegeMenu_Class10028])
		(Especiales ligero)
		(NombreP "pastel de chocolate")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class20001] of  Plato

		(Calidad 5)
		(Caliente TRUE)
		(Complejidad 2)
		(Componentes
			[ProtegeMenu_Class20002]
			[Proyect2_Class10029]
			[Proyect2_Class20014]
			[Proyect2_Class20006])
		(Especiales sin_gluten sibarita)
		(NombreP "langostinos con ajo y miel")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class20002] of  Ingredientes

		(NombreI "langostino")
		(Precio 10.0))

	([ProtegeMenu_Class20003] of  Plato

		(Calidad 5)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class20004]
			[ProtegeMenu_Class20005]
			[Proyect2_Class20020]
			[Proyect2_Class10000]
			[ProtegeMenu_Class10025])
		(Especiales sibarita vegetariano vegano)
		(NombreP "pigna natural con crema tostada y fresitas silvestres")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class20004] of  Ingredientes

		(NombreI "piña")
		(Precio 0.7))

	([ProtegeMenu_Class20005] of  Ingredientes

		(NombreI "frutos del bosque")
		(Precio 0.8))

	([ProtegeMenu_Class20006] of  Plato

		(Calidad 5)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class10004]
			[Proyect2_Class10022]
			[ProtegeMenu_Class10023])
		(Especiales sibarita sin_gluten ligero)
		(NombreP "raviolis de  salmon")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class20007] of  Plato

		(Calidad 5)
		(Caliente TRUE)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class10018]
			[Proyect2_Class20004]
			[Proyect2_Class20002]
			[Proyect2_Class20016]
			[ProtegeMenu_Class20008])
		(Especiales sin_gluten sibarita ligero)
		(NombreP "gambas con estola")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class20008] of  Ingredientes

		(NombreI "calabacin")
		(Precio 0.8))

	([ProtegeMenu_Class20009] of  Plato

		(Calidad 3)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class20010]
			[ProtegeMenu_Class10]
			[ProtegeMenu_Class10013]
			[Proyect2_Class10000]
			[Proyect2_Class20004])
		(Especiales vegano vegetariano sin_lactosa ligero)
		(NombreP "bugnuelo de calabaza")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class20010] of  Ingredientes

		(NombreI "calabaza")
		(Precio 0.5))

	([ProtegeMenu_Class20011] of  Plato

		(Calidad 1)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class10030]
			[Proyect2_Class20001]
			[ProtegeMenu_Class10037]
			[ProtegeMenu_Class10023]
			[ProtegeMenu_Class10026])
		(Especiales vegano vegetariano ligero sin_lactosa)
		(NombreP "flan de platano")
		(Orden Postre)
		(Temporada todas))

	([ProtegeMenu_Class20012] of  Plato

		(Calidad 4)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class20013]
			[Proyect2_Class20007]
			[Proyect2_Class10011]
			[ProtegeMenu_Class10033]
			[Proyect2_Class10029]
			[Proyect2_Class20004]
			[Proyect2_Class20002]
			[Proyect2_Class20016])
		(Especiales vegano sin_lactosa vegetariano)
		(NombreP "ensaladilla de bulgur")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class20013] of  Ingredientes

		(NombreI "trigo")
		(Precio 0.75))

	([ProtegeMenu_Class20014] of  Plato

		(Calidad 2)
		(Caliente TRUE)
		(Complejidad 2)
		(Componentes
			[ProtegeMenu_Class10]
			[ProtegeMenu_Class10003]
			[Proyect2_Class10011]
			[Proyect2_Class10030]
			[Proyect2_Class20016]
			[Proyect2_Class20004]
			[Proyect2_Class20002])
		(Especiales vegano vegetariano sibarita)
		(NombreP "hamburguesa vegana")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class20015] of  Plato

		(Calidad 2)
		(Caliente TRUE)
		(Complejidad 2)
		(Componentes
			[ProtegeMenu_Class10021]
			[Proyect2_Class20007]
			[Proyect2_Class20016]
			[ProtegeMenu_Class10002]
			[Proyect2_Class20004]
			[ProtegeMenu_Class20016])
		(Especiales vegano vegetariano italiano sin_lactosa)
		(NombreP "espaguetis con tomate y albahaca")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class20016] of  Ingredientes

		(NombreI "tomate cherry")
		(Precio 0.65))

	([ProtegeMenu_Class20017] of  Plato

		(Calidad 2)
		(Caliente TRUE)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class10013]
			[Proyect2_Class10029]
			[Proyect2_Class10011]
			[ProtegeMenu_Class20018]
			[Proyect2_Class20003]
			[Proyect2_Class20004]
			[Proyect2_Class20002]
			[Proyect2_Class20007]
			[ProtegeMenu_Class10])
		(Especiales vegano vegetariano sin_lactosa)
		(NombreP "potaje de garbanzos")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class20018] of  Ingredientes

		(NombreI "laurel")
		(Precio 0.1))

	([ProtegeMenu_Class20019] of  Plato

		(Calidad 2)
		(Complejidad 1)
		(Componentes
			[ProtegeMenu_Class20008]
			[Proyect2_Class10011]
			[Proyect2_Class10030]
			[ProtegeMenu_Class10007]
			[Proyect2_Class20007]
			[Proyect2_Class20004]
			[Proyect2_Class20016]
			[ProtegeMenu_Class10021])
		(Especiales vegano vegetariano sin_gluten sin_lactosa)
		(NombreP "calabazin relleno")
		(Orden Primero)
		(Temporada todas))

	([ProtegeMenu_Class3] of  Ingredientes

		(NombreI "alioli")
		(Precio 0.1))

	([ProtegeMenu_Class4] of  Plato

		(Calidad 2)
		(Complejidad 3)
		(Componentes
			[ProtegeMenu_Class5]
			[Proyect2_Class10000]
			[ProtegeMenu_Class6]
			[ProtegeMenu_Class7]
			[Proyect2_Class10028]
			[Proyect2_Class10022]
			[Proyect2_Class10014]
			[ProtegeMenu_Class8])
		(Especiales japones ligero)
		(NombreP "sushi")
		(Orden Segundo)
		(Temporada todas))

	([ProtegeMenu_Class5] of  Ingredientes

		(NombreI "alga")
		(Precio 0.6))

	([ProtegeMenu_Class6] of  Ingredientes

		(NombreI "vinagre arroz")
		(Precio 0.2))

	([ProtegeMenu_Class7] of  Ingredientes

		(NombreI "pepino")
		(Precio 0.4))

	([ProtegeMenu_Class8] of  Ingredientes

		(NombreI "aguacate")
		(Precio 0.5))

	([ProtegeMenu_Class9] of  Plato

		(Calidad 3)
		(Caliente TRUE)
		(Complejidad 3)
		(Componentes
			[ProtegeMenu_Class10]
			[Proyect2_Class20020]
			[Proyect2_Class10024]
			[Proyect2_Class10011]
			[ProtegeMenu_Class11]
			[ProtegeMenu_Class12])
		(Especiales vegetariano italiano)
		(NombreP "canelones con espinacas")
		(Orden Segundo)
		(Temporada todas))

	([Proyect2_Class0] of  Plato

		(Calidad 1)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class20000]
			[Proyect2_Class3]
			[Proyect2_Class20016]
			[Proyect2_Class20007])
		(NombreP "bocata de mortadela")
		(Orden Segundo)
		(Temporada todas))

	([Proyect2_Class1] of  Ingredientes

		(NombreI "huevo gallina")
		(Precio 0.2))

	([Proyect2_Class10000] of  Ingredientes

		(NombreI "azucar")
		(Precio 0.5))

	([Proyect2_Class10001] of  Ingredientes

		(NombreI "aceituna")
		(Precio 0.7))

	([Proyect2_Class10002] of  Ingredientes

		(NombreI "cerdo")
		(Precio 3.0))

	([Proyect2_Class10003] of  Ingredientes

		(NombreI "cerdo ecologico")
		(Precio 4.0))

	([Proyect2_Class10004] of  Ingredientes

		(NombreI "caviar")
		(Precio 15.0))

	([Proyect2_Class10005] of  Ingredientes

		(NombreI "margarina")
		(Precio 0.5))

	([Proyect2_Class10006] of  Ingredientes

		(NombreI "margarina buena")
		(Precio 2.0))

	([Proyect2_Class10007] of  Plato

		(Calidad 5)
		(Caliente FALSE)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class20000]
			[Proyect2_Class10004]
			[Proyect2_Class10024])
		(Especiales sin_lactosa ligero)
		(NombreP "tostadas con caviar")
		(Orden Primero)
		(Temporada todas))

	([Proyect2_Class10008] of  Ingredientes

		(NombreI "lechuga")
		(Precio 0.0))

	([Proyect2_Class10009] of  Ingredientes

		(NombreI "lechuga buena")
		(Precio 1.0))

	([Proyect2_Class10011] of  Ingredientes

		(NombreI "cebolla")
		(Precio 0.5))

	([Proyect2_Class10012] of  Ingredientes

		(NombreI "lentejas")
		(Precio 0.5))

	([Proyect2_Class10013] of  Ingredientes

		(NombreI "garbanzos")
		(Precio 0.5))

	([Proyect2_Class10014] of  Ingredientes

		(NombreI "arroz")
		(Precio 0.3))

	([Proyect2_Class10015] of  Ingredientes

		(NombreI "pato")
		(Precio 4.0))

	([Proyect2_Class10016] of  Ingredientes

		(NombreI "pollo")
		(Precio 2.0))

	([Proyect2_Class10017] of  Ingredientes

		(NombreI "ternera")
		(Precio 2.5))

	([Proyect2_Class10018] of  Ingredientes

		(NombreI "gamba")
		(Precio 4.0))

	([Proyect2_Class10019] of  Ingredientes

		(NombreI "calamar")
		(Precio 3.0))

	([Proyect2_Class10020] of  Ingredientes

		(NombreI "conejo")
		(Precio 3.0))

	([Proyect2_Class10021] of  Ingredientes

		(NombreI "pavo")
		(Precio 3.5))

	([Proyect2_Class10022] of  Ingredientes

		(NombreI "salmon")
		(Precio 4.0))

	([Proyect2_Class10023] of  Ingredientes

		(NombreI "merluza")
		(Precio 2.5))

	([Proyect2_Class10024] of  Ingredientes

		(NombreI "mantequilla")
		(Precio 0.5))

	([Proyect2_Class10025] of  Ingredientes

		(NombreI "mantequilla buena")
		(Precio 2.0))

	([Proyect2_Class10026] of  Ingredientes

		(NombreI "bacalao")
		(Precio 2.0))

	([Proyect2_Class10027] of  Ingredientes

		(NombreI "alubias")
		(Precio 0.5))

	([Proyect2_Class10028] of  Ingredientes

		(NombreI "zanahoria")
		(Precio 0.5))

	([Proyect2_Class10029] of  Ingredientes

		(NombreI "ajo")
		(Precio 0.5))

	([Proyect2_Class10030] of  Ingredientes

		(NombreI "pimiento")
		(Precio 0.5))

	([Proyect2_Class10031] of  Ingredientes

		(NombreI "brocoli")
		(Precio 1.0))

	([Proyect2_Class10032] of  Ingredientes

		(NombreI "col")
		(Precio 0.2))

	([Proyect2_Class10033] of  Ingredientes

		(NombreI "coliflor")
		(Precio 0.7))

	([Proyect2_Class10034] of  Ingredientes

		(NombreI "rabano")
		(Precio 0.5))

	([Proyect2_Class10035] of  Ingredientes

		(NombreI "pasta trigo")
		(Precio 1.5))

	([Proyect2_Class10036] of  Ingredientes

		(NombreI "quinoa")
		(Precio 2.0))

	([Proyect2_Class10037] of  Ingredientes

		(NombreI "avena")
		(Precio 1.0))

	([Proyect2_Class10038] of  Ingredientes

		(NombreI "pasta maiz")
		(Precio 2.0))

	([Proyect2_Class2] of  Ingredientes

		(NombreI "nocilla")
		(Precio 2.0))

	([Proyect2_Class20000] of  Ingredientes

		(NombreI "pan")
		(Precio 0.3))

	([Proyect2_Class20001] of  Ingredientes

		(NombreI "azucar moreno")
		(Precio 0.4))

	([Proyect2_Class20002] of  Ingredientes

		(NombreI "pimienta")
		(Precio 0.1))

	([Proyect2_Class20003] of  Ingredientes

		(NombreI "pimenton")
		(Precio 0.1))

	([Proyect2_Class20004] of  Ingredientes

		(NombreI "sal")
		(Precio 0.0))

	([Proyect2_Class20005] of  Ingredientes

		(NombreI "curry")
		(Precio 0.1))

	([Proyect2_Class20006] of  Ingredientes

		(NombreI "oregano")
		(Precio 0.2))

	([Proyect2_Class20007] of  Ingredientes

		(NombreI "tomate")
		(Precio 0.5))

	([Proyect2_Class20008] of  Ingredientes

		(NombreI "manzana")
		(Precio 0.5))

	([Proyect2_Class20009] of  Ingredientes

		(NombreI "pera")
		(Precio 0.5))

	([Proyect2_Class20010] of  Ingredientes

		(NombreI "naranja")
		(Precio 0.5))

	([Proyect2_Class20011] of  Ingredientes

		(NombreI "kiwi")
		(Precio 0.6))

	([Proyect2_Class20012] of  Ingredientes

		(NombreI "fresa")
		(Precio 1.0))

	([Proyect2_Class20013] of  Ingredientes

		(NombreI "melon")
		(Precio 0.7))

	([Proyect2_Class20014] of  Ingredientes

		(NombreI "miel")
		(Precio 0.7))

	([Proyect2_Class20015] of  Ingredientes

		(NombreI "sandia")
		(Precio 0.6))

	([Proyect2_Class20016] of  Ingredientes

		(NombreI "aceite")
		(Precio 0.5))

	([Proyect2_Class20017] of  Ingredientes

		(NombreI "cheddar")
		(Precio 3.0))

	([Proyect2_Class20018] of  Ingredientes

		(NombreI "emmental")
		(Precio 3.0))

	([Proyect2_Class20019] of  Ingredientes

		(NombreI "queso azul")
		(Precio 3.5))

	([Proyect2_Class20020] of  Ingredientes

		(NombreI "leche")
		(Precio 0.7))

	([Proyect2_Class20021] of  Ingredientes

		(NombreI "nata")
		(Precio 1.5))

	([Proyect2_Class20022] of  Ingredientes

		(NombreI "yogur")
		(Precio 1.0))

	([Proyect2_Class3] of  Ingredientes

		(NombreI "mortadela")
		(Precio 1.0))

	([Proyect2_Class30000] of  NoAlcohol

		(NombreB "agua")
		(PrecioB 0.0))

	([Proyect2_Class30008] of  Plato

		(Calidad 5)
		(Caliente FALSE)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class20000]
			[Proyect2_Class10004]
			[Proyect2_Class10005])
		(Especiales sin_lactosa vegetariano ligero sibarita)
		(NombreP "tostadas con caviar vegetariana")
		(Orden Primero)
		(Temporada todas))

	([Proyect2_Class30011] of  Plato

		(Calidad 2)
		(Caliente TRUE)
		(Complejidad 3)
		(Componentes
			[Proyect2_Class10014]
			[Proyect2_Class10012]
			[Proyect2_Class10029]
			[Proyect2_Class20004])
		(Especiales pesado vegano vegetariano sin_gluten sin_lactosa)
		(NombreP "arroz con lentejas")
		(Orden Primero)
		(Temporada todas))

	([Proyect2_Class30012] of  Ingredientes

		(NombreI "jamon")
		(Precio 2.0))

	([Proyect2_Class30013] of  Plato

		(Calidad 1)
		(Caliente TRUE)
		(Complejidad 2)
		(Componentes
			[Proyect2_Class10017]
			[Proyect2_Class10016]
			[Proyect2_Class10008]
			[Proyect2_Class10011]
			[Proyect2_Class20007])
		(Especiales pesado)
		(NombreP "kebab")
		(Orden PlatoCombinado))

	([Proyect2_Class40000] of  Alcohol

		(Gama baja)
		(NombreB "sanmiguel")
		(PrecioB 0.7)
		(TipoA cerveza))

	([Proyect2_Class40001] of  NoAlcohol

		(NombreB "cocacola")
		(PrecioB 0.7)
		(Refresco TRUE))

	([Proyect2_Class40002] of  NoAlcohol

		(NombreB "fanta naranja")
		(PrecioB 0.7)
		(Refresco TRUE))

	([Proyect2_Class40003] of  NoAlcohol

		(NombreB "fanta limon")
		(PrecioB 0.7)
		(Refresco TRUE))

	([Proyect2_Class40004] of  NoAlcohol

		(NombreB "acuarius")
		(PrecioB 0.9)
		(Refresco TRUE))

	([Proyect2_Class40005] of  NoAlcohol

		(NombreB "zumo de naranja")
		(PrecioB 1.0))

	([Proyect2_Class40006] of  NoAlcohol

		(NombreB "limonada")
		(PrecioB 0.9))

	([Proyect2_Class40007] of  NoAlcohol

		(NombreB "camomila")
		(PrecioB 0.5))

	([Proyect2_Class5] of  Plato

		(Calidad 2)
		(Caliente FALSE)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class20000]
			[Proyect2_Class2])
		(Especiales vegano vegetariano)
		(NombreP "bocata de nocilla")
		(Orden Postre)
		(Temporada todas))

	([Proyect2_Class50003] of  Alcohol

		(Gama media)
		(NombreB "estrelladam")
		(PrecioB 0.9)
		(TipoA cerveza))

	([Proyect2_Class50004] of  Alcohol

		(Gama alta)
		(NombreB "taramay")
		(PrecioB 1.5)
		(TipoA cerveza))

	([Proyect2_Class50005] of  Alcohol

		(Gama baja)
		(NombreB "cava eroski")
		(PrecioB 1.0)
		(TipoA cava))

	([Proyect2_Class50006] of  Alcohol

		(Gama media)
		(NombreB "codorniu brut")
		(PrecioB 6.0)
		(TipoA cava))

	([Proyect2_Class50007] of  Alcohol

		(Gama alta)
		(NombreB "codorniu gran reserva")
		(PrecioB 13.0)
		(TipoA cava))

	([Proyect2_Class50008] of  Alcohol

		(Gama baja)
		(NombreB "don simon blanco")
		(PrecioB 0.7)
		(TipoA vino_blanco))

	([Proyect2_Class50009] of  Alcohol

		(Gama baja)
		(NombreB "don simon tinto")
		(PrecioB 1.0)
		(TipoA vino_tinto))

	([Proyect2_Class50010] of  Alcohol

		(Gama baja)
		(NombreB "don simon negro")
		(PrecioB 1.0)
		(TipoA vino_negro))

	([Proyect2_Class50011] of  Alcohol

		(Gama media)
		(NombreB "blanc pescador")
		(PrecioB 7.0)
		(TipoA vino_blanco))

	([Proyect2_Class50012] of  Alcohol

		(Gama alta)
		(NombreB "perro verde")
		(PrecioB 20.0)
		(TipoA vino_blanco))

	([Proyect2_Class50013] of  Alcohol

		(Gama media)
		(NombreB "bodegas vivanco tinto")
		(PrecioB 7.0)
		(TipoA vino_tinto))

	([Proyect2_Class50014] of  Alcohol

		(Gama media)
		(NombreB "bodegas vivanco negro")
		(PrecioB 7.0)
		(TipoA vino_negro))

	([Proyect2_Class50015] of  Alcohol

		(Gama alta)
		(NombreB "alabaster gran reserva tinto")
		(PrecioB 15.0)
		(TipoA vino_tinto))

	([Proyect2_Class50016] of  Alcohol

		(Gama alta)
		(NombreB "alabaster gran reserva negro")
		(PrecioB 15.0)
		(TipoA vino_negro))

	([Proyect2_Class50017] of  Plato

		(Calidad 3)
		(Caliente TRUE)
		(Complejidad 3)
		(Componentes
			[Proyect2_Class10016]
			[Proyect2_Class10014]
			[Proyect2_Class20005]
			[Proyect2_Class20020]
			[Proyect2_Class20004]
			[Proyect2_Class10029])
		(Especiales sin_gluten sin_lactosa)
		(NombreP "pollo con curry")
		(Orden Segundo)
		(Temporada todas))

	([Proyect2_Class50018] of  Plato

		(Calidad 2)
		(Caliente FALSE)
		(Complejidad 0)
		(Componentes [Proyect2_Class20015])
		(Especiales vegano sin_gluten sin_lactosa vegetariano ligero)
		(NombreP "sandia")
		(Orden Postre)
		(Temporada verano))

	([Proyect2_Class50019] of  Plato

		(Calidad 4)
		(Caliente FALSE)
		(Complejidad 0)
		(Componentes [Proyect2_Class20012])
		(Especiales vegano sin_gluten sin_lactosa vegetariano ligero)
		(NombreP "fresas")
		(Orden Postre)
		(Temporada primavera))

	([Proyect2_Class50020] of  Plato

		(Calidad 3)
		(Caliente FALSE)
		(Complejidad 0)
		(Componentes [Proyect2_Class20008])
		(Especiales vegano sin_gluten sin_lactosa vegetariano ligero)
		(NombreP "manzana")
		(Orden Postre)
		(Temporada verano))

	([Proyect2_Class50021] of  Plato

		(Calidad 3)
		(Caliente FALSE)
		(Complejidad 0)
		(Componentes [Proyect2_Class20009])
		(Especiales vegano sin_gluten sin_lactosa vegetariano ligero)
		(NombreP "pera")
		(Orden Postre)
		(Temporada oto%C3%B1o))

	([Proyect2_Class50022] of  Plato

		(Calidad 4)
		(Caliente FALSE)
		(Complejidad 0)
		(Componentes [Proyect2_Class20013])
		(Especiales vegano sin_gluten sin_lactosa vegetariano ligero)
		(NombreP "melon")
		(Orden Postre)
		(Temporada verano))

	([Proyect2_Class50023] of  Plato

		(Calidad 3)
		(Caliente FALSE)
		(Complejidad 0)
		(Componentes [Proyect2_Class20010])
		(Especiales vegano sin_gluten sin_lactosa vegetariano ligero)
		(NombreP "naranja")
		(Orden Postre)
		(Temporada invierno))

	([Proyect2_Class50024] of  Plato

		(Calidad 3)
		(Caliente FALSE)
		(Complejidad 0)
		(Componentes [Proyect2_Class20011])
		(Especiales vegano sin_gluten sin_lactosa vegetariano ligero)
		(NombreP "kiwi")
		(Orden Postre)
		(Temporada invierno))

	([Proyect2_Class50025] of  Plato

		(Calidad 2)
		(Complejidad 0)
		(Componentes [Proyect2_Class20022])
		(Especiales vegetariano sin_gluten ligero)
		(NombreP "yogur")
		(Orden Postre)
		(Temporada todas))

	([Proyect2_Class50026] of  Plato

		(Calidad 3)
		(Caliente FALSE)
		(Complejidad 2)
		(Componentes
			[Proyect2_Class20018]
			[Proyect2_Class20004]
			[Proyect2_Class20016]
			[Proyect2_Class10038])
		(Especiales vegetariano sin_gluten)
		(NombreP "pasta con queso fundido sin gluten")
		(Orden Primero))

	([Proyect2_Class50027] of  Plato

		(Calidad 4)
		(Complejidad 1)
		(Componentes
			[Proyect2_Class20013]
			[Proyect2_Class30012])
		(Especiales sin_gluten sin_lactosa ligero)
		(NombreP "melon con jamon")
		(Orden Primero)
		(Temporada verano))

	)










;;****************
;;* DEFFUNCTIONS *
;;****************

(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer)
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer)
          then (bind ?answer (lowcase ?answer))))
   ?answer)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then TRUE
       else FALSE))

(deffunction cuanto (?question)
	(printout t ?question)
	(bind ?answer (read))
	(if (lexemep ?answer)
		then (bind ?answer (lowcase ?answer))
		)
	;(if (test (or (!= ?answer "no") (!= ?answer "n")))
		; (bind $?ingredientes (find-all-instances ((?inst Ingredientes get-NombreI)) TRUE))
		; (while (not (member ?answer ?ingredientes)) do
		; 	(printout t "Ingrediente desconocido")
		; 	(printout t ?question)
		; 	(bind ?answer (read))
		; 	(if (lexemep ?answer)
		; 		then (bind ?answer (lowcase ?answer))
		; 		)
		; )
	;)
		?answer
 )

;;; Funcion para hacer una pregunta con respuesta en un rango dado
(deffunction pregunta-numerica (?pregunta ?rangini ?rangfi)
	(format t "%s [%d, %d] " ?pregunta ?rangini ?rangfi)
	(bind ?respuesta (read))
	(while (not(and(>= ?respuesta ?rangini)(<= ?respuesta ?rangfi))) do
		(format t "�%s? [%d, %d] " ?pregunta ?rangini ?rangfi)
		(bind ?respuesta (read))
	)
	?respuesta
)

(deffunction printa-menu "" (?menu)
(bind ?prim (send ?menu get-Primero))
(bind ?seg (send ?menu get-Segundo))
(bind ?postr (send ?menu get-Postre))
(bind ?prec (send ?menu get-PrecioMenu))
(printout t crlf "Primero: "(send ?prim get-NombreP) crlf)
(printout t "Segundo: "(send ?seg get-NombreP) crlf)
(printout t "Postre: "(send ?postr get-NombreP) crlf)
(printout t "Precio: "?prec crlf crlf)
)
;;calcula el precio de un plato
(deffunction sumapreuComp "" ( $?comp )
  (bind ?x 0)
	;(printout t "suma dels preus ")
  (loop-for-count (?i 1 (length ?comp)) do
    (bind ?var (nth$ ?i ?comp))
    (bind ?precio (send ?var get-Precio))
    (bind ?x (+ ?x ?precio))
  )
 ?x
)

(deffunction evaluable "" ( ?menu )
  (bind ?x TRUE)
  (bind ?prim (send ?menu get-Primero))
  (bind ?x (and ?x (not (eq ?prim nil))))
  (bind ?seg (send ?menu get-Segundo))
  (bind ?x (and ?x (not (eq ?seg nil))))
  (bind ?postr (send ?menu get-Postre))
  (bind ?x (and ?x (not (eq ?postr nil))))
	;(printout t "evaluable " ?x crlf)
  ?x
)


(deffunction tiene-especial (?plato ?simbolo)
	(bind $?especiales (send ?plato get-Especiales))
	(bind ?ans FALSE)
	(if (> (length$ ?especiales ) 0)
		then (loop-for-count (?i 1  (length$ ?especiales)) do
			(bind ?cur (nth$ ?i ?especiales))
			(bind ?ans (or ?ans (eq ?simbolo ?cur)) )
		)
	)
	?ans
)

;menu es japones tiene un plato japones
(deffunction japones-menu  (?menu)
	(bind ?ans FALSE)
	(bind ?prim (send ?menu get-Primero))
	(bind ?seg (send ?menu get-Segundo))
	(bind ?post (send ?menu get-Postre))
	(bind ?ans (or (tiene-especial ?prim japones) ?ans))
	(bind ?ans (or (tiene-especial ?seg japones) ?ans))
	(bind ?ans (or (tiene-especial ?post japones) ?ans))
	?ans
)

;menu es italiano tiene un plato japones
(deffunction italiano-menu  (?menu)
    (bind ?ans FALSE)
    (bind ?prim (send ?menu get-Primero))
    (bind ?seg (send ?menu get-Segundo))
    (bind ?post (send ?menu get-Postre))
    (bind ?ans (or (tiene-especial ?prim italiano) ?ans))
    (bind ?ans (or (tiene-especial ?seg italiano) ?ans))
    (bind ?ans (or (tiene-especial ?post italiano) ?ans))
    ?ans
)

;menu es frances tiene un plato frances
(deffunction frances-menu  (?menu)
	(bind ?ans FALSE)
	(bind ?prim (send ?menu get-Primero))
	(bind ?seg (send ?menu get-Segundo))
	(bind ?post (send ?menu get-Postre))
	(bind ?ans (or (tiene-especial ?prim frances) ?ans))
	(bind ?ans (or (tiene-especial ?seg frances) ?ans))
	(bind ?ans (or (tiene-especial ?post frances) ?ans))
	?ans
)

(deffunction sibarita-menu  (?menu)
	(bind ?ans FALSE)
	(bind ?prim (send ?menu get-Primero))
	(bind ?seg (send ?menu get-Segundo))
	(bind ?post (send ?menu get-Postre))
	(bind ?ans (or (tiene-especial ?prim sibarita) ?ans))
	(bind ?ans (or (tiene-especial ?seg sibarita) ?ans))
	(bind ?ans (or (tiene-especial ?post sibarita) ?ans))
	?ans
)

(deffunction vegano-menu  (?menu)

	(bind ?prim (send ?menu get-Primero))
	(bind ?seg (send ?menu get-Segundo))
	(bind ?post (send ?menu get-Postre))
	(bind ?ans (and (tiene-especial ?prim vegano) (tiene-especial ?seg vegano)(tiene-especial ?post vegano) ))

	?ans
)

(deffunction vegetariano-menu  (?menu)
	(bind ?prim (send ?menu get-Primero))
	(bind ?seg (send ?menu get-Segundo))
	(bind ?post (send ?menu get-Postre))
	(bind ?ans (and (tiene-especial ?prim vegetariano) (and (tiene-especial ?seg vegetariano) (tiene-especial ?post vegetariano) )))
	?ans
)

; ;;NUMERO DE MENUS QUE CUMPLAN LA PROPIEDAD
; QUE DEVUELVE LA FUNCION ?foo
(deffunction numero-propiedad (?foo)
   (bind ?x 0)
	 (bind $?allmenus (find-all-instances ((?inst Menu)) TRUE))
	 (loop-for-count (?i 1 (length$ ?allmenus)) do
			(bind ?menu (nth$ ?i ?allmenus))
			(if (funcall ?foo ?menu) then (bind ?x (+ ?x 1)))
		)
		?x
)
(deffunction numero-menus ()
	(bind $?allmenus (find-all-instances ((?inst Menu)) TRUE))
	(bind ?x (length$ ?allmenus))
	?x
)

;;elimina los platos para los que la función foo da cierto
(deffunction eliminar-propiedad (?foo)
	(bind $?allmenus (find-all-instances ((?inst Menu)) TRUE))
	(loop-for-count (?i 1 (length$ ?allmenus)) do
		 (bind ?menu (nth$ ?i ?allmenus))
		 (if (funcall ?foo ?menu) then (send ?menu delete)
		 ;(printout t "Eliminando menu1 " (numero-menus) " restantes" crlf )
		 )
	 )
)
;;elimina los platos para los que la función foo da false
(deffunction eliminar-propiedad-not (?foo)
	(bind $?allmenus (find-all-instances ((?inst Menu)) TRUE))
	(loop-for-count (?i 1 (length$ ?allmenus)) do
		 (bind ?menu (nth$ ?i ?allmenus))
		 (if (not (funcall ?foo ?menu)) then (send ?menu delete)
		 ;(printout t "Eliminando menu2"  (numero-menus) " restantes" crlf )
		 )
	 )
)



;;ELIMINA DE LA LISTA DE INSTANCIAS AQUELLAS QUE POR EL MULTISLOT SL NO
;;;CONTENGAN EL VALOR ?CONST  PAGINA 44 FAQ
(deffunction filtrar-multi-por (?li ?sl ?const)
 (bind ?encontrado FALSE)
 (if (neq ?li FALSE) then

 	(bind ?li (create$ ?li))

 	(if (> (length ?li) 0) then
 		(loop-for-count (?i 1 (length ?li))
 			(bind $?v (send (nth$ ?i ?li) ?sl))

 				(if (member$ ?const $?v) then
 					(if (eq ?encontrado FALSE) then
 						(bind ?encontrado TRUE)
 						(bind ?ins (nth$ ?i ?li))
 						else
 						(bind ?ins (create$ ?ins (nth$ ?i ?li)))
 					)
 				)
 			)
 		)
 	)
 	(if (eq ?encontrado FALSE) then
 		(bind ?ins FALSE)
 	)
	(return ?ins)
)

(deffunction menus-nombre (?menu)
	(bind ?prim (send ?menu get-Primero))
	(bind ?seg (send ?menu get-Segundo))
	(bind ?pos (send ?menu get-Postre))
	(bind ?beb (send ?menu get-BebidaM))

	(bind ?p1 (send ?prim get-NombreP))
	(bind ?p2 (send ?seg get-NombreP))
	(bind ?p3 (send ?pos get-NombreP))
	(bind ?p4 (send ?beb get-NombreB))
	(str-cat ?p1 "," ?p2 "," ?p3 "," ?p4 "," clrf)
)


(deffunction menus-iguales (?menu1 ?menu2)
	(bind ?prim1 (send ?menu1 get-Primero))
	(bind ?seg1 (send ?menu1 get-Segundo))
	(bind ?postr1 (send ?menu1 get-Postre))
	(bind ?prim2 (send ?menu2 get-Primero))
	(bind ?seg2 (send ?menu2 get-Segundo))
	(bind ?postr2 (send ?menu2 get-Postre))
	(bind ?x TRUE)
	(bind ?x (and ?x (eq ?prim1 ?prim2)))
	(bind ?x (and ?x (eq ?seg1 ?seg2)))
	(bind ?x (and ?x (eq ?postr1 ?postr2)))
	?x
)

(deffunction string-menu (?menu)
	(bind ?prim (send ?menu get-Primero))
	(bind ?seg (send ?menu get-Segundo))
	(bind ?postr (send ?menu get-Postre))
	(bind ?beb (send ?menu get-BebidaM))
	(bind ?prec (send ?menu get-PrecioMenu))
	(bind ?x (str-cat "
	Primero: " (send ?prim get-NombreP)"
	Segundo: " (send ?seg get-NombreP)"
	Postre: " (send ?postr get-NombreP)"
	Bebida: " (send ?beb get-NombreB)"
	Precio: "?prec "
	"))
	?x
)

(deffunction random-slot ( ?li )
  (bind ?li (create$ ?li))
  (bind ?max (length ?li))
  (bind ?r (random 1 ?max))
  (bind ?ins (nth$ ?r ?li))
  (return ?ins)
)

(deffunction get-random-menus (?li)
		 (bind ?x (random-slot ?li))
)

		(deffunction question-loop (?x ?y ?z $?li)
		    (switch   (ask-question (str-cat "Estos son tus menus, escribe su numero para cambiarlos o 1 para acabar:(1/2/3/4)
		        1:Acabar
		        2:" (string-menu ?x)"
		        3:" (string-menu ?y)"
		        4:" (string-menu ?z)"
		>")
		         1 2 3 4)
		    (case 1 then (- 1 1))
		    (case 2 then (question-loop (get-random-menus $?li) ?y ?z $?li))
		    (case 3 then (question-loop ?x (get-random-menus $?li) ?z $?li))
		    (case 4 then (question-loop ?x ?y (get-random-menus $?li) $?li))
		    ))

;;;**************************************
;;;
;;;---------      MAIN       -----------
;;;
;;;**************************************
(defmodule MAIN (export ?ALL))

(defrule system-begin ""
  (initial-fact)
  (not (menu-nuevo))
  =>
  (printout t crlf)
  (printout t "----------------------------" crlf)
  (printout t "The Menu Maker Expert System" crlf)
  (printout t "----------------------------" crlf)
  (printout t crlf)
  (assert (menu-nuevo))
  (focus make-questions)
)


;;;****************************
;;;
;;;***** Questions Module *****
;;;
;;;****************************
(defmodule make-questions
    (import MAIN ?ALL)
    (export ?ALL)
)



(defrule tipoEvento "regla para saber el tipo de evento"
(not (questions end))
  (not (Evento Tipo ?))
  =>
  (switch (ask-question "Elija el tipo de evento:
    1:Fiesta Infantil
    2:Cumpleagnos
    3:Fin de agno
    4:Cena de empresa
    5:Boda
    >"
      1 2 3 4 5)
			(case 1 then (assert (Evento Calidad 0)) (assert (Evento SinAlcohol)) )
	    (case 2 then (assert (Evento Calidad 1)))
	    (case 3 then (assert (Evento Calidad 2)))
	    (case 4 then (assert (Evento Calidad 3)))
	    (case 5 then (assert (Evento Calidad 4)))
    (default (printout t "No te he entendido"))
    )
)


(defrule determine-num-com "regla para saber el numero aproximado de invitados"
(not (questions end))
 ;(declare (salience 900))
 (not (Evento Num_com ?) )
 =>
 (switch   (ask-question "Cuanta gente calculas tener?
     1:10
     2:25
     3:50
     4:75
		 5:100 o mas
>"
      1 2 3 4 5)
   (case 1 then (assert (Evento Num_com 10)) (assert (Evento Complejidad 5)) )
   (case 2 then (assert (Evento Num_com 25)) (assert (Evento Complejidad 5)) )
   (case 3 then (assert (Evento Num_com 50)) (assert (Evento Complejidad 4)) )
   (case 4 then (assert (Evento Num_com 75)) (assert (Evento Complejidad 3)) )
	 (case 5 then (assert (Evento Num_com 100)) (assert (Evento Complejidad 2)))
   (default (printout t "No te he entendido"))
  )
)

(defrule pregunta-presupuesto "regla para saber el presupuesto"
(not (questions end))
(not (Evento Presupuesto ?) )
;(declare (salience 1))
=>
(switch   (ask-question "Cuanta presupuesto tienes?
    1:200
    2:500
    3:750
    4:1500
		5:2500
		6:5000
>"
     1 2 3 4 5 6)
  (case 1 then (assert (Evento Presupuesto 200)))
  (case 2 then (assert (Evento Presupuesto 500)))
  (case 3 then (assert (Evento Presupuesto 750)))
  (case 4 then (assert (Evento Presupuesto 1500)))
	(case 5 then (assert (Evento Presupuesto 2500)))
	(case 6 then (assert (Evento Presupuesto 5000)))
  (default (printout t "No te he entendido"))
 )
)


(defrule pregunta-temporada "regla para saber el presupuesto"
(not (questions end))
(not (Evento Temporada ?) )
=>
(switch   (ask-question "En que estacion se produce el evento?
    1:Primavera
    2:Verano
    3:Otono
    4:Invierno
>"
     1 2 3 4)
  (case 1 then (assert (Evento Temporada primavera)))
  (case 2 then (assert (Evento Temporada verano )))
  (case 3 then (assert (Evento Temporada otono)))
  (case 4 then (assert (Evento Temporada invierno)))
  (default (printout t "No te he entendido"))
 )
)

; (defrule pregunta-alergia "regla para saber si existe alguna alergia"
; 	(not (questions end))
; 	(not (Evento EsAlergia ?))
; 	=>
; 	(if (yes-or-no-p "Hay algun ingediente que debamos excluir (yes/no)?")
; 			then (assert (Evento EsAlergia Si))
; 			else (assert (Evento EsAlergia No))
; 			)
; )
;
; (defrule pregunta-alergia2 "regla para saber la alergia"
; 	(declare (salience 1))
; 	(not (questions end))
; 	(Evento EsAlergia Si)
; 	=>
; 	(bind ?ans (cuanto "que ingrediente excluimos?"))
; 	(assert (Evento Alergia ?ans))
; )

(defrule end-questions "regla para pasar al siguiente modulo"
    ;(declare (salience -3))
		(not (questions end))
		(Evento Presupuesto ?)
		(Evento Num_com ?)
		(Evento Calidad ?)
		(Evento Temporada ?)
		;(Evento EsAlergia ?)
    ;(menu-nuevo)
    =>
    (printout t "fin de las preguntas" crlf)
    (focus inferir_datos)
		(assert (menusGenerar))
		(assert (questions end))
		)



;;;------------------------------------------------------------------------------------------------------------------------------------------------------
;;;----------  					MODULO DE INFERENCIAS DE DATOS				---------- 				MODULO DE INFERENCIAS DE DATOS
;;;------------------------------------------------------------------------------------------------------------------------------------------------------

;; En este modulo se hace la abstraccion de los datos obtenidos del modulo de pregunatas

(defmodule inferir_datos
    (import MAIN ?ALL)
    (import make-questions ?ALL)
    (export ?ALL)
)
(defrule presupuesto-por-invitado "regla para establecer el presupuesto-por-invitado maximo"
			(declare (salience 20))
			(not (filtrado-2))
			(Evento Num_com ?numcom)
		  (Evento Presupuesto  ?presu)
		  (not (presupuesto-por-invitado ?))
		  =>
		  (assert (presupuesto-por-invitado (/ ?presu ?numcom)))
		  (assert (inference end))
)

(defrule quitar-platos-temporada
	(declare (salience 15))
	(not (filtrado-2))
  ?plato <- (object (is-a Plato) (Temporada ?x))
	(Evento Temporada ?temp)
	(test (not (eq ?x ?temp)))
	;(test (printout t ?x ", " ?temp "= " (eq ?x ?temp) crlf))
  (test (not (eq ?x todas)))
	;(test (printout t ?x ", " todas "= " (eq ?x todas) crlf))

	=>
	;(printout t ?x ", " ?temp "= " (eq ?x ?temp) crlf)
	;(printout t ?x ", " todas "= " (eq ?x todas) crlf)
	(printout t "Eliminando plato por estacion: ")
	(printout t (send ?plato get-NombreP) crlf)
  (send ?plato delete)
	)

(defrule quitar-bebidas-alcohol
		 (declare (salience 15))
		 ?beb <- (object (is-a Alcohol))
		 (Evento SinAlcohol)
		 =>
		 (printout t "Eliminando bebidas alcoholicas: ")
		 (printout t (send ?beb get-NombreB) crlf)
		 (send ?beb delete)
	 )

(defrule quitar-platos-calidad
	 	(declare (salience 15))
	 	?plato <- (object (is-a Plato) (Calidad ?x))
	 	(Evento Calidad ?c)
	 	(test ( < ?x ?c))
	 	=>
	 	(printout t "Eliminando plato por calidad: ")
	 	(printout t (send ?plato get-NombreP) crlf)
	 	(send ?plato delete)
	 )

(defrule quitar-platos-complejidad
	 	(declare (salience 15))
	 	?plato <- (object (is-a Plato) (Complejidad ?x))
	 	(Evento Complejidad ?c)
	 	(test ( > ?x ?c))
	 	=>
	 	(printout t "Eliminando plato por complejidad: ")
	 	(printout t (send ?plato get-NombreP) crlf)
	 	(send ?plato delete)
	 	)

; (defrule quitar-platos-alergia
; 		  (declare (salience 10))
; 		  ?plato <- (object (is-a Plato) (Componentes ?x))
; 		  (Evento Alergia ?y)
; 			;(test (printout t "alergia " ?y " x: " (send ?x get-NombreI) " |" ))
;
; 			(test (= (str-compare (send ?x get-NombreI) ?y) 0) )
;
; 		  =>
; 		  (printout t "Eliminando plato por alergia: ")
; 		  (printout t (send ?plato get-NombreP) crlf)
; 		  (send ?plato delete)
; 			)

(defrule insertaMenuses
	(declare (salience 10))
	(not (filtrado-2))
		(not (Menuses))
		=>
		(make-instance (gensym*) of AllMenus)
		(assert (Menuses))
		)


 (defrule addmembers-menu
	 (declare (salience 5))
	 (not (filtrado-2))
		 (Menuses)
		 ?men <- (object (is-a AllMenus) )
		 ?plato1 <- (object (is-a Plato) (Orden Primero))
		 ?plato2 <- (object (is-a Plato) (Orden Segundo))
		 ?plato3 <- (object (is-a Plato) (Orden Postre))
		 ?bebida <- (object (is-a Bebida))
		 =>
		 ;(printout t "creando menu " crlf)
		 (bind ?menu1 (make-instance  (gensym*) of Menu))
		 ;(printout t "menu creado " crlf)
		 ;(printout t "addmembers-menu" crlf)
		 (bind ?x (sumapreuComp (send ?plato1 get-Componentes)))
		 (bind ?y  (sumapreuComp (send ?plato2 get-Componentes)))
		 (bind ?z (sumapreuComp (send ?plato3 get-Componentes)))
		 (bind ?w (send ?bebida get-PrecioB))
		 ;(printout t "binded" crlf)
		 (send ?menu1 put-Primero ?plato1)
		 (send ?menu1 put-Segundo ?plato2)
		 (send ?menu1 put-Postre ?plato3)
		 (send ?menu1 put-BebidaM ?bebida)
		 (send ?menu1 put-PrecioMenu (+ ?x (+ ?y (+ ?z ?w))))

		 ;(printout t  crlf (menus-nombre ?menu1) crlf)
		 ;(if (japones-menu ?menu1) then (printout t "tengo un menu japo" crlf))
		 ;(slot-insert$ ?men MenuP 1 ?menu1)
		 )


(defrule filtrar-por-precio "quitar todos los que se pasan del presupuesto por invitado"
(not (filtrado-2))
?filt <- (object(is-a Menu) (PrecioMenu ?y))
(presupuesto-por-invitado ?x)
(test (evaluable ?filt))
(test (< ?x ?y))
=>
(send ?filt delete)
;(printout t "Eliminando menu por precio: " ?y crlf )
;(printout t ?y crlf )

)


(defrule finInferir "regla para pasar al modulo siguiente"
	(declare (salience -1))
      (inference end)
			;(presupuesto-por-invitado ?)
      (menu-nuevo)
			(not (filtrado-2))
      =>
	  (printout t "Inferencia de datos hecha, pasando al filtrado por preferencias" crlf)
		(printout t "Menus restantes : "  (numero-menus) crlf)
			(assert (filtrado-2))
			(focus filtrado)
)


;;;****************************
;;;
;;;***** Filtering Module *****
;;;
;;;****************************

(defmodule filtrado
    (import MAIN ?ALL)
    (import make-questions ?ALL)
    (import inferir_datos ?ALL)
    (export ?ALL))

(defrule preguntar-japones
	(declare ( salience 20))
	(not (filtrado end))
	(not (preguntar-japones))
	(filtrado-2)
	(test (< 4 (numero-propiedad japones-menu)))
	(test (< 4
		 (- (numero-menus) (numero-propiedad japones-menu) )))
	;(test (printout t "pregunta a los japos" crlf))
	(test (< 10 (numero-menus)))
	=>
	(switch   (ask-question "Prefieres comida japonesa?(1/2/3)
	    1:Si
	    2:No
	    3:Es indiferente
	>"
	     1 2 3)
	  (case 1 then (eliminar-propiedad-not japones-menu))
	  (case 2 then (eliminar-propiedad japones-menu))
	  (case 3 then (- 1 1))
	  (default (printout t "No te he entendido"))
	 )
	 (printout t "quedan " (numero-menus) "menus" crlf)
	(assert (preguntar-japones))
)


(defrule preguntar-italiano
	(declare ( salience 20))
	(not (filtrado end))
	(not (preguntar-italiano))
	(filtrado-2)
	(test (< 4 (numero-propiedad italiano-menu)))
	;(test (printout t "pregunta a los italianos" crlf))
	(test (< 4
		 (-  (numero-menus) (numero-propiedad italiano-menu) )))
	(test (< 10 (numero-menus)))
	=>
	(switch   (ask-question "Prefieres comida italiana?(1/2/3)
	    1:Si
	    2:No
	    3:Es indiferente
	>"
	     1 2 3)
	  (case 1 then (eliminar-propiedad-not italiano-menu))
	  (case 2 then (eliminar-propiedad italiano-menu))
	  (case 3 then (- 1 1))
	  (default (printout t "No te he entendido"))
	 )
	  (printout t "quedan " (numero-menus) "menus" crlf)
	(assert (preguntar-italiano))
)

(defrule preguntar-frances
	(declare ( salience 20))
	(not (filtrado end))
	(not (preguntar-frances))
	(filtrado-2)
	(test (< 4 (numero-propiedad frances-menu)))
	(test (< 4
		 (- (numero-menus) (numero-propiedad frances-menu) )))
	;(test (printout t "pregunta a los franceses" crlf))
	(test (< 10 (numero-menus)))
	=>
	(switch   (ask-question "Prefieres comida francesa?(1/2/3)
	    1:Si
	    2:No
	    3:Es indiferente
	>"
	     1 2 3)
	  (case 1 then (eliminar-propiedad-not frances-menu))
	  (case 2 then (eliminar-propiedad frances-menu))
	  (case 3 then (- 1 1))
	  (default (printout t "No te he entendido"))
	 )
	(assert (preguntar-frances))
	(printout t "quedan " (numero-menus) "menus" crlf)
)

 (defrule preguntar-vegano
 	(declare ( salience 20))
 	(not (filtrado end))
 	(not (preguntar-vegano ?))
 	(filtrado-2)
 	(test (< 4 (numero-propiedad vegano-menu)))
 	(test (< 4
 		 (- (numero-menus) (numero-propiedad vegano-menu) )))
 	;(test (printout t "pregunta vegano" crlf))
 	(test (< 10 (numero-menus)))
 	=>
 	(switch   (ask-question "Prefieres comida vegana?(1/2/3)
 	    1:Si
 	    2:No
 	    3:Es indiferente
>"
 	     1 2 3)
 	  (case 1 then (eliminar-propiedad-not vegano-menu) (assert (preguntar-vegano Si)))
 	  (case 2 then (eliminar-propiedad vegano-menu) (assert (preguntar-vegano No)))
 	  (case 3 then (- 1 1) (assert (preguntar-vegano)))
 	  (default (printout t "No te he entendido"))
 	 )
	 (printout t "quedan " (numero-menus) "menus" crlf)

 )

 (defrule preguntar-vegetariano
 	(declare ( salience 20))
 	(not (filtrado end))
 	(not (preguntar-vegetariano ?))
	(not (preguntar-vegano Si))
 	(filtrado-2)
 	(test (< 4 (numero-propiedad vegetariano-menu)))
 	(test (< 4
 		 (- (numero-menus) (numero-propiedad vegetariano-menu) )))
 	;(test (printout t "pregunta vegetariano" crlf))
 	(test (< 10 (numero-menus)))
 	=>
 	(switch   (ask-question "Prefieres comida vegetariana?(1/2/3)
 	    1:Si
 	    2:No
 	    3:Es indiferente
 	>"
 	     1 2 3)
 	  (case 1 then (eliminar-propiedad-not vegetariano-menu))
 	  (case 2 then (eliminar-propiedad vegetariano-menu) )
 	  (case 3 then (- 1 1) )
 	  (default (printout t "No te he entendido"))
 	 )
 	 (assert (preguntar-vegetariano))
	 (printout t "quedan " (numero-menus) "menus" crlf)

 )

 (defrule preguntar-sibarita
 	(declare ( salience 20))
 	(not (filtrado end))
 	(not (preguntar-sibarita))
 	(filtrado-2)
 	(test (< 4 (numero-propiedad sibarita-menu)))
 	(test (< 4
 		 (- (numero-menus) (numero-propiedad sibarita-menu) )))
 	;(test (printout t "sibaritas" (numero-propiedad sibarita-menu) crlf))
 	(test (< 10 (numero-menus)))
 	=>
 	(switch   (ask-question "Prefieres comida sibarita?(1/2/3)
 	    1:Si
 	    2:No
 	    3:Es indiferente
 	>"
 	     1 2 3)
 	  (case 1 then (eliminar-propiedad-not sibarita-menu))
 	  (case 2 then (eliminar-propiedad sibarita-menu))
 	  (case 3 then (- 1 1))
 	  (default (printout t "No te he entendido"))
 	 )
 	(assert (preguntar-sibarita))
	(printout t "quedan " (numero-menus) "menus" crlf)

 )


(defrule fin-filtrado
    (declare (salience 10))
    (not (filtrado end))
    (filtrado-2)
    ;(test (printout t "testeando fin filtrado, Japo:" preguntar-japones "  Ita:" preguntar-italiano crlf (numero-menus) crlf))
  =>
  (printout t "fin de Refinamiento,quedan " (numero-menus) "Menus" crlf)
   (if ( > (numero-menus) 4)
	 		then (focus recomendaciones)
			else (printout t "No nos quedan menus, desgraciadamente no hay ninguno compatible con
	    tus preferencias" crlf))
    (assert (filtrado end))
)

(defrule no-platos "norma para si no quedan menus compatibles antes de escojer pref"
    ;(declare (salience 110))
    (not (filtrado end))
    (filtrado-2)
		(test (printout t "numero de menus: " (numero-menus) crlf))
    (test (> 1 (numero-menus)))
    =>
    (printout t "No nos quedan menus, desgraciadamente no hay ninguno compatible con
    tus preferencias basicas" crlf)
    (assert (filtrado end))
)


;;;------------------------------------------------------------------------------------------------------------------------------------------------------
;;;-
;;;---------  				MODULO DE RECOMENDACIONES		---------- 				MODULO DE RECOMENDACIONES
;;;------------------------------------------------------------------------------------------------------------------------------------------------------

;; En este modulo se obtendran todas las solcuiones y se mostrara la solcuion
;; si hay mas de 6 solcuiones se mostraran las 6 con valor cuantitativo mas alto y
;; si hay menos pues se mostraran todas

 (defmodule recomendaciones
 	(import MAIN ?ALL)
 	(import inferir_datos ?ALL)
 	(import filtrado ?ALL)
 	;(import valorar_preferencias ?ALL)
 	(export ?ALL)
)

(defrule rellenar-AllMenus
    (declare (salience 10))
    (filtrado end)
    ?men <- (object (is-a AllMenus) )
    ?x <- (object (is-a Menu))
    =>
    (slot-insert$ ?men MenuP 1 ?x)
		)

(defrule recomendar-menu2
    (declare (salience -50))
    (filtrado end)
    (object (is-a AllMenus) (MenuP $?li))
    (not (FIN1))
    ;(test (halt))
    ;(test (printout t "Entrando a la ultima norma para decidir" crlf))
    =>
    ;(printout t "ultima funcion!" crlf)
    (bind ?x (get-random-menus $?li))
    (bind ?y (get-random-menus $?li))
    (bind ?z (get-random-menus $?li))
    ;(printout t "ultima funcion!"  crlf)
    (question-loop ?x ?y ?z $?li)
    (printout t "Gracias por usar nuestra aplicacion para recomendar menus!" crlf)
    (assert (FIN1))
    (halt)
    )

; (defrule recomendar-menu1
; 	?mimenu <-(object (is-a Menu))
; 	(object (is-a AllMenus) (MenuP $?all))
; 	(not (FIN1))
; 	=>
; 	(printa-menu ?mimenu)
; 	(printout t "Soluciones: "(length$ ?all) crlf)
; 	(assert (FIN1))
; 	)

; (defrule printa-menu
;   (object (is-a Menu) (Primero ?p) (Segundo ?s) (Postre ?po)  (BebidaM ?drink)(PrecioMenu ?preciom))
;   (nuevo_menu)
;   (not (FIN))
;   =>
;   (printout t "Primero: " (?p get-nombrePlato)
;   "Segondo: " (?s get-nombrePlato)
;   "Postre: " (?po get-nombrePlato)
;   "Bebida: " (?drink get-NombreB)
;   "Precio: " (?preciom get-PrecioMenu))
;   (assert (FIN))
;   )
