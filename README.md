
# firefly-api-test-wordpress-data

Pruebas de integración con la herramienta [Karate](https://github.com/intuit/karate) sobre las API de [wordpress-data-api](https://wordpress-data-api-firefly-develop.apps.kinto.azure.firefly.elcorteingles.es/swagger-ui.html)

## [Nomenclatura y estructura de ficheros](https://confluence.azure.firefly.elcorteingles.es/display/FIR/Nomenclatura+y+estructura+de+ficheros+para+proyectos+firefly-api-test)

## [Working Agreements](https://confluence.azure.firefly.elcorteingles.es/display/FIR/Working+Agreements)

## IDE

Se recomienda el uso de [IntelliJ](https://www.jetbrains.com/idea/)

### Plugins necesarios para ejecución desde IDE

- Cucumber for java
- Gherkin

**IMPORTANTE**: Deshabilitar el plugin Substeps IntelliJ Plugin

### Ejecución desde IDE de un test en concreto

Colocar el ratón sobre el scenario o la feature a ejecutar y click derecho "Run"

### Ejecución desde IDE de un test en concreto con entorno

Colocar el ratón sobre el scenario o la feature a ejecutar y click derecho "Run". Posteriormente debemos editar la configuración de ejecucion para ese scenario o feature  en "Run" > "Edit Configurations" y en el valor para "VM Options" indicar -Dkarate.env=int

### Ejecución desde IDE del conjunto de pruebas paralelizadas

Colocar el ratón sobre la clase TestParallel y ejecutar el método "testParallel"

## Maven

### install

    $ mvn clean install -DskipTests

### Ejecución de todas las pruebas

    $ mvn clean test

### Ejecución de las pruebas _gold_

    $ mvn clean test -Dcucumber.options="--tags @gold"

### Ejecución con entorno (dev, int, pre)

    $ mvn clean test -Dkarate.env=${env}

### Ejecución contra una url

    $ mvn clean test -Durl=http://localhost:8080 -Djob_name=users
    
## Lanzador por menú

    $ cd ${project_base}/src/test/java/launcher
    $ docker-compose run menu-launcher

Los resultados pueden consultarse en ${project_base}/target/cucumber-html-reports

## Validador de estilos Gherkin

Se incluye un fichero en la raíz de cada modulo (.gherkin-lintrc) con el fin de validar los estilos de los ficheros Gherkin y asi evitar posibles errores de ejecucion. Para ejecutar esta validacion necesitamos instalar de forma global la libreria js [gherkin-lint](https://www.npmjs.com/package/gherkin-lint)

    $ npm install gherkin-lint -g

Nos posicionamos en la ruta del _src/test/java_ del proyecto que queramos validar y ejecutaríamos el validador indicándole la ruta del fichero con las reglas (.gherkin-lintrc)

    $ src/test/java$ gherkin-lint -c ./.gherkin-lintrc -r ./gherkinRules

## Validador de estilos JS

Se incluye un fichero en la raíz del proyecto (.eslintrc.json) con el fin de validar los estilos de los ficheros js del proyecto y así evitar posibles errores de ejecución. Para ejecutar esta validación necesitamos instalar de forma global la libreria js [eslint](https://www.npmjs.com/package/eslint)

    $ npm install eslint -g

Nos posicionamos en la ruta del _src/test/java_ del proyecto que queramos validar y ejecutaríamos el validador indicándole la ruta del fichero con las reglas (.eslintrc.json)

    $ src/test/java$ eslint -c ./.eslintrc.json ./
    
## githooks

### pre-commit

> Para que el hook pueda ejecutar los validadores necesitamos que el fichero _pre-commit_ tenga permisos de ejecucion

Antes de ejecutar el commit se lanzaran los dos validadores: gherkin-lint y eslint. Si hubiera algun error no dejaria hacer el commit.
    
Para activar los githooks:

    $ git config core.hooksPath ./src/test/java/.githooks
    

## Tags

- @users

### Ejecución de un tag

    $ mvn clean test -Dcucumber.options="--tags @users"
