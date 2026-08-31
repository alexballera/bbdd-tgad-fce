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


### Aplico FN 1, busco multivalorados y creo una nueva entidad con la PK de la entidad que se desprende. p.e
### **persona**
-  *teléfono*
-  *tema de interés*: al ser una entidad identificada previamente, también se crea una tabla pivote con persona

### **evento**
- *evento_fecha*
- *evento_temas*

