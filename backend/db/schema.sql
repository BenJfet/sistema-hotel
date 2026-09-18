CREATE TABLE habitaciones(
    Nro_Habitacion INTEGER PRIMARY KEY,
    capacidad INTEGER NOT NULL,
    ESTADO VARCHAR(20) CHECK (estado IN ('Ocupado', 'Limpieza', 'Desocupado'))
);

CREATE TABLE metodos_pago(
    ID_metodo SERIAL PRIMARY KEY,
    metodo VARCHAR(20) CHECK(metodo IN('Efectivo', 'Tarjeta', 'QR')) NOT NULL
);

CREATE TABLE clientes(
    ID_cliente SERIAL PRIMARY KEY,
    dni VARCHAR(15) UNIQUE NOT NULL,
    nombres VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    sexo CHAR(1) CHECK(sexo IN('M', 'F')) NOT NULL,
    ciudad VARCHAR(15) NOT NULL,
    pais VARCHAR(15) NOT NULL
);

CREATE TABLE reservas(
    ID_cliente INTEGER NOT NULL,
    FOREIGN KEY (ID_cliente) REFERENCES clientes(ID_cliente),
    Nro_habitacion INTEGER NOT NULL,
    FOREIGN KEY (Nro_habitacion) REFERENCES habitaciones(Nro_habitacion),
    ID_metodo INTEGER NOT NULL,
    FOREIGN KEY (ID_metodo) REFERENCES metodos_pago(ID_metodo),
    ID_reserva SERIAL PRIMARY KEY,
    cantidad_horas INTEGER NOT NULL,
    costo NUMERIC(6,2) NOT NULL,
    hora_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hora_salida TIMESTAMP GENERATED ALWAYS AS (hora_entrada + (cantidad_horas * INTERVAL '1 hour')) STORED
);