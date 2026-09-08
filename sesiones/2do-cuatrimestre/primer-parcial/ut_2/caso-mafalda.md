# Extraigo datos del enunciado
## Entidades / relaciones
- asistentes
- evento
- invitaciones
- inscripciones
- asistencia

## Atributos
-  nombre, domicilio, telefonos, profesión, temas de interés
- capacidad máxima
- día de realización

## Verificadores

## Restricciones

## Secuencia de hechos
- Invitación
- Inscripción
- Asistencia

# Pasos

## 1.-Entidades potenciales
- inscribir
- asistencia
- evento
- invitaciones
- diplomas
- persona

## 2.-Atributos potenciales

## 3.-Agrego atributos a las entidades potenciales
- **persona**
- **evento**
- **temas de interés**


### Identificamos las entidades aplicando la FN 1, busco multivalorados y creo una nueva entidad con la PK de la entidad que se desprende.
### **Persona**
-  *teléfono*
-  *tema de interés*: al ser una entidad identificada previamente, también se crea una tabla pivote con persona

### **Evento**
- *evento_fecha*
- *evento_temas*

## 4.- Identificamos las entidades según la sucesión de hechos
### **Persona**
- *invitacion*
- *inscripción*, se puede inscribir o no. Entonces esta entidad es de G/E, es de especialización con invitaciones (es un subconjunto de aquel). Debe poseer los siguientes atributos: cod_persona, cod_evento, fecha_inscripción. Debe poser la PK de la entidad padre y conforma una única FK. Se establece la cardinalidad, en este caso 0 1, ya que puedo o no inscribirse.
- *asistencia*, es un subconjunto de la entidad inscripcion, al igual que el anterior es relación G/E con cardinalidad 0 1, ya que pudo o no asistir.
- *diplomas*

### **Evento**

## 5.- Relaciones
### **Cardinalidad**

Se analiza la entidad del lado de muchos (débil).
- Eliminación en cascada para verificar si es una relación de Identidad o de No identidad
- persona 1:1 - 1:N telefono. Si elimino persona puedo eliminar telefono entonces es relación de identidad
- persona 1:1 - 1:N temas_personas 1:M - 1:1 temas_interes. En este caso la tabla intermedia tiene el muchos y la relación ID y NI se realiza con la tabla pivote o intermedia y generalmente de un lado está la relación ID y del otro lado la relación de NI. La eliminación en cascada es decisión del diseñador, y la pregunta es ¿si al eliminar la entidad fuerte automáticamente se elimina la débil y no queda afectada o no se pierde información?
- 
