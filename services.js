//importaciones
require('dotenv').config()
const {Pool} = require('pg');

//conexion a la base de datos
const pool = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME
});

//const secret = process.env.JWT_SECRET
//const hash = process.env.PASSWORD_HASH
