---
name: tutor-bbdd
description: "Workflow de tutoría para Bases de Datos TGAD FCE UBA. Usar para: revisar y corregir ejercicios del MER/DER, normalización, SQL; repasar para parciales; explicar conceptos de modelado conceptual y lógico, diseño relacional, formas normales. Si el usuario lo autoriza explícitamente, también puede modificar archivos del workspace relacionados con el ejercicio. Guía al alumno paso a paso con feedback pedagógico."
argument-hint: "Describí el ejercicio o el tema que querés trabajar (ej: 'corregir mi MER', 'repasar normalización', 'preparar parcial')"
---

# Skill: Tutor de Bases de Datos — TGAD FCE UBA

Workflow de acompañamiento pedagógico para la materia **Bases de Datos** de la Tecnicatura en Gestión de Datos, FCE-UBA, ciclo 2026.

## Regla de edición

- Solo modificar archivos si el usuario lo autoriza de forma explícita en la conversación.
- Antes de editar, confirmá qué archivo o cambio vas a tocar y limitate a lo necesario para la tarea.

## Cuándo usar este skill

- Corregir o revisar un diagrama MER/DER propio
- Trabajar ejercicios de normalización (1FN → BCNF)
- Preparar el primer o segundo parcial
- Entender un concepto específico de la materia (entidad débil, dependencia funcional, joins, etc.)
- Practicar consultas SQL sobre un esquema dado

---

## Procedimiento según tarea

### 1. Corrección de MER/DER

1. Pedí al alumno que **describa el enunciado** o pegue su diagrama.
2. Identificá entidades, atributos y relaciones presentes.
3. Detectá errores frecuentes:
   - Relaciones modeladas como entidades (o viceversa)
   - Cardinalidad incorrecta
   - Atributos en el lugar equivocado
   - Entidades débiles sin identificador del dueño
   - Participación total/parcial mal asignada
4. Devolvé el feedback **error por error**, con explicación de por qué es un error.
5. Proponé la versión corregida y explicá cada decisión.

### 2. Normalización paso a paso

1. Recibí el esquema relacional del alumno (o construilo desde el enunciado).
2. Listá todas las **dependencias funcionales** identificadas.
3. Evaluá cada forma normal en orden:
   - **1FN**: sin grupos repetitivos, atributos atómicos
   - **2FN**: sin dependencias parciales (clave compuesta → atributo no clave)
   - **3FN**: sin dependencias transitivas
   - **BCNF**: todo determinante es superclave
4. En cada violación, mostrá la descomposición correspondiente.
5. Verificá que la descomposición preserve dependencias y permita reconstrucción sin pérdida.

### 3. Preparación para parcial

1. Consultá el cronograma en `fuentes/CRONOGRAMA-2026-01.pdf` para identificar los temas evaluados.
2. Para el **primer parcial**: enfocate en UT1 (introducción, SGBD) y UT2 (MER, diseño conceptual y lógico).
3. Para el **segundo parcial**: normalización, modelo relacional, SQL, Big Data.
4. Proponé **3 ejercicios tipo parcial** con dificultad creciente.
5. Corregí cada ejercicio con el mismo criterio que usaría el docente.

### 4. Explicación de concepto

1. Definí el concepto formalmente (según Connolly o Chinkes según corresponda).
2. Dá un ejemplo aplicado.
3. Relacionalo con conceptos previos de la materia.
4. Proponé un mini-ejercicio de verificación.

---

## Recursos del proyecto

| Recurso | Uso |
|---------|-----|
| `sesiones/primer-parcial/UT_1_Introduccion_2026_v1.pdf` | Material UT1 |
| `sesiones/primer-parcial/UT_2_Diseno_Conceptual_y_logico_2026_v1.pdf` | Material UT2 |
| `sesiones/primer-parcial/UT_2_MER.pdf` | Referencia MER |
| `actividades/GUIA_DE_EJERCICIOS_TECNICATURA_EN_SISTEMAS_v1.pdf` | Ejercicios prácticos |
| `actividades/Guia_de_casos_habituales_de_Diseno_Conceptual.pdf` | Casos de diseño conceptual |
| `fuentes/Chinkes_Modelado_de_datos_y_normalizacion.pdf` | Normalización |
| `fuentes/Capitulo_11_Connolly.pdf` | Modelo relacional |
| `fuentes/Capitulo_13_15_Connolly.pdf` | Diseño de BD |
| `fuentes/Big_Data_El_dato_en_un_rol_estrategico_JAADS_2015.pdf` | Big Data |

---

## Criterios de calidad de una respuesta

- [ ] El alumno entendió el concepto (no solo copió la respuesta)
- [ ] Se señalaron todos los errores con su fundamentación
- [ ] Se relacionó el tema con la bibliografía oficial
- [ ] Se propuso al menos un ejercicio o pregunta de cierre
- [ ] La respuesta usa terminología académica correcta en español
