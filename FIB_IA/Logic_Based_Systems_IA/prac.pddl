(define (domain logistics)
  (:requirements :strips)
  (:predicates

   (primero ?p1) (segundo ?p2) (calorias ?c) (precio ?pr) (tipo ?t)
   (dia ?d)

   (estipo ?p ?t) ;; plato p es del tipo t  
   (tienec ?p ?c) ;; plato p tiene calorias calorias
   (tienep ?p ?pr) ;; plato p tiene precio pr
   (consecutivo ?d1 ?d2) ;; dos dias d vienen despues uno del otro
   (incdia ?p1 ?p2) ;; un primero y un segundo que no se pueden servir juntos
   (incsemana ?p1 ?p2) ;; dos platos no se pueden servir seguidos
   (en ?p ?d) ;; plato p se servira el dia d
   )
   
  ;; (:action servir 
  ;;  decide servir un primero y un segundo un dia determinado si no son incompatibles en el dia ni la semana
  ;;  :parameters (?p1 ?p2 ?p12 ?p22 ?d1 ?d2) 
  ;;  p12 y p22 son los platos que se sirven el dia consecutivo
  ;;  :precondition (and (primero ?p1) (segundo ?p2) (dia ?d1) (dia ?d2)
  ;;			(consecutivo ?d1 ?d2) (en ?p12 ?d2) (en ?p12 ?d2) (not (incdia ?p1 ?p2)) (not (incsemana ?p1 ?p12)) (not (incsemana ?p2 ?p22)) )
  ;;  :effect (and (en ?p1 ?d)(en ?p2 ?d)))
	
   (:action prohibir ;; hace dos platos incompatibles por ser del mismo tipo
    :parameters (?p1 ?p2 ?t)
    :precondition (and (primero ?p1) (segundo ?p2) (tipo ?t)
			(estipo ?p1 ?t) (estipo ?p2 ?t))
    :effect (incompatibledia ?p1 ?p2))
	
	   
   (:action servir ;; decide servir un primero y un segundo un dia determinado si no son incompatibles en el dia
    :parameters (?p1 ?p2 ?d ) 
    :precondition (and (primero ?p1) (segundo ?p2) (dia ?d1)
			(not (incdia ?p1 ?p2)) )
    :effect (and (en ?p1 ?d)(en ?p2 ?d)))