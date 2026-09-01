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
- *asistencia*
- *diplomas*

### **Evento**
