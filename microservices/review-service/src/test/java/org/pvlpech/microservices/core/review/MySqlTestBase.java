package org.pvlpech.microservices.core.review;

import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.MySQLContainer;

public abstract class MySqlTestBase {

    private static MySQLContainer database = new MySQLContainer("mysql:9.0.0");

    //A static block is used to start the database container before any JUnit code is
    //invoked.
    static {
        database.start();
    }

    //The database container will get some properties defined when started up,
    //such as which port to use. To register these dynamically created properties in
    //the application context, a static method databaseProperties() is defined. The
    //method is annotated with @DynamicPropertySource to override the database
    //configuration in the application context, such as the configuration from an
    //application.yml file
    @DynamicPropertySource
    static void databaseProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", database::getJdbcUrl);
        registry.add("spring.datasource.username", database::getUsername);
        registry.add("spring.datasource.password", database::getPassword);
    }

}
