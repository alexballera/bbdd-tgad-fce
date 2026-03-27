# Bases de Datos — TGAD · FCE · UBA

Repositorio oficial de la materia **Bases de Datos** de la **Tecnicatura en Gestión de Datos (TGAD)**, Facultad de Ciencias Económicas, Universidad de Buenos Aires — Ciclo lectivo **2026**.

---

## Índice

- [Acerca de la materia](#acerca-de-la-materia)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Programa y cronograma](#programa-y-cronograma)
- [Bibliografía](#bibliografía)
- [Actividades y ejercicios](#actividades-y-ejercicios)
- [Tutor con IA](#tutor-con-ia)
- [Cómo usar este repositorio](#cómo-usar-este-repositorio)

---

## Acerca de la materia

La materia introduce los fundamentos del diseño, implementación y administración de **bases de datos relacionales**. Los alumnos adquieren competencias en:

- Modelado conceptual y lógico de datos (MER/DER)
- Diseño del modelo relacional y aplicación de formas normales
- Lenguaje SQL (definición y manipulación de datos)
- Comprensión del rol estratégico del dato en organizaciones, incluyendo Big Data

La cursada se divide en dos parciales con su correspondiente recuperatorio.

---

## Estructura del repositorio

```
bbdd-tgad-fce/
├── actividades/          → Guías de ejercicios prácticos
├── fuentes/              → Bibliografía, capítulos y cronograma
├── sesiones/
│   ├── primer-parcial/   → Material de UT1 y UT2
│   └── segundo-parcial/  → Material de UT3 a UT6 (en preparación)
└── .github/
    ├── agents/           → Agente tutor IA
    └── skills/           → Workflows de estudio asistido
```

---

## Programa y cronograma

El cronograma detallado se encuentra en [`fuentes/CRONOGRAMA-2026-01.pdf`](fuentes/CRONOGRAMA-2026-01.pdf).

### Primer parcial

| Unidad | Tema | Material |
|--------|------|----------|
| **UT 1** | Introducción a las Bases de Datos — conceptos fundamentales, SGBD, arquitectura ANSI/SPARC | [UT_1_Introduccion_2026_v1.pdf](sesiones/primer-parcial/UT_1_Introduccion_2026_v1.pdf) |
| **UT 2** | Diseño Conceptual y Lógico — Modelo Entidad-Relación (MER/DER), cardinalidad, participación, entidades débiles | [UT_2_Diseno_Conceptual _y_logico_2026_v1.pdf](sesiones/primer-parcial/UT_2_Diseno_Conceptual%20_y_logico_2026_v1.pdf) · [UT_2_MER.pdf](sesiones/primer-parcial/UT_2_MER.pdf) |

### Segundo parcial

| Unidad | Tema |
|--------|------|
| **UT 3** | Modelo Relacional — tablas, claves, integridad referencial |
| **UT 4** | Normalización — dependencias funcionales, 1FN, 2FN, 3FN, BCNF |
| **UT 5** | SQL — DDL, DML, consultas, joins, subconsultas |
| **UT 6** | Big Data — el dato como recurso estratégico |

> El material del segundo parcial se irá subiendo a `sesiones/segundo-parcial/` a medida que avance la cursada.

---

## Bibliografía

| Archivo | Descripción |
|---------|-------------|
| [Connolly — Cap. 11](fuentes/Capitulo_11_Connolly.pdf) | Modelo relacional |
| [Connolly — Cap. 13-15](fuentes/Capitulo_13_15_Connolly.pdf) | Diseño de bases de datos |
| [Chinkes — Modelado y normalización](fuentes/Chinkes_Modelado_de_datos_y_normalizacion.pdf) | Modelado de datos y formas normales |
| [Big Data — JAADS 2015](fuentes/Big_Data_El_dato_en_un_rol_estrategico_JAADS_2015.pdf) | El dato en un rol estratégico |

---

## Actividades y ejercicios

| Archivo | Descripción |
|---------|-------------|
| [Guía de ejercicios](actividades/GUIA_DE_EJERCICIOS_TECNICATURA_EN_SISTEMAS_v1.pdf) | Ejercicios prácticos de la tecnicatura |
| [Casos de Diseño Conceptual](actividades/Guia_de_casos_habituales_de_Diseno_Conceptual.pdf) | Casos habituales para practicar MER/DER |

Se recomienda resolver cada ejercicio **antes** de consultar la solución o al tutor.

---

## Tutor con IA

Este repositorio incluye un **agente tutor** integrado en GitHub Copilot (VS Code) que actúa como profesor de la materia.

### Cómo activarlo

1. Abrí este repositorio en **VS Code** con la extensión **GitHub Copilot Chat** instalada.
2. En el chat de Copilot, hacé clic en el selector de agente y elegí **"Tutor BBDD - TGAD FCE UBA"**.
3. Escribí tu consulta en español.

### Qué podés preguntarle

- _"Explicame qué es una entidad débil con un ejemplo"_
- _"Revisá mi diagrama MER: [descripción del ejercicio]"_
- _"¿Cómo paso este esquema de 2FN a 3FN?"_
- _"Armame unos ejercicios tipo parcial sobre normalización"_
- _"¿Cuál es la diferencia entre participación total y parcial?"_

El tutor no te da la respuesta directa: te guía para que llegues vos. Si te equivocás, te explica por qué antes de mostrarte lo correcto.

---

## Cómo usar este repositorio

1. **Clonar** el repositorio en tu máquina local.
2. **Leer el cronograma** en `fuentes/CRONOGRAMA-2026-01.pdf` para saber qué temas corresponden a cada semana.
3. **Estudiar el material** de la sesión correspondiente en `sesiones/`.
4. **Practicar** con los ejercicios de `actividades/`.
5. **Consultar al tutor IA** cuando tengas dudas o quieras que revise tu trabajo.

---

> Facultad de Ciencias Económicas · Universidad de Buenos Aires · 2026
