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

//consultas DB

//Ingresando datos a la table de usuarios
async function newUser(dni, email, name, lastName, password,rol, forDate) {
    try{
        const result = await pool.query(
            `INSERT INTO users (name, last_name , email, password, rol, phone, dni, auth, create_at) values ('${name}', '${lastName}', '${email}', '${password}', '${rol}', 'user', '${dni}',false,'${forDate}') RETURNING * `
        );
        const usuario = result.rows[0];
        return usuario;

    }catch(e){
        return e;
    }
    
};

//Ingresando datos clientes a la table usuarios
async function newClient(dni, email, name, lastName, phone, forDate) {
    try{
        const result = await pool.query(
            `INSERT INTO users (name, last_name , email,password,rol, phone, dni, auth, create_at) values ('${name}', '${lastName}', '${email}', '456', 'cliente' ,'${phone}', '${dni}',false,'${forDate}') RETURNING * `
        );
        const usuario = result.rows[0];
        return usuario;
    }catch(e){
        return e;
    }
};


//enviando todos los usuarios 
async function getUsuarios(){
    const result = await pool.query('SELECT * FROM users ORDER BY id_users');
    return result.rows;
};

//actualizando de la tabla users el auth
async function setUsuarioStatus(id, auth) {
    const result = await pool.query(
        `UPDATE users SET auth = ${auth} WHERE id_users = ${id} RETURNING *`
    );
    const usuario = result.rows[0];
    return usuario;
}

//enviando email y pass para verificar sesion
async function getUsuario(email, password) {
    const result = await pool.query(
        `SELECT * FROM users WHERE email = '${email}' AND password = '${password}'`
    );
    return result.rows[0];
}

//eliminando usuario
const deleteUser = async (id_users) => {
    const dbQuery = {
      text: "DELETE FROM users WHERE id_users = $1",
      values: [`${id_users}`],
    };
    const result = await pool.query(dbQuery);
    return result;
  };


//agregar rol
async function newRol(nombre, date) {
    const result = await pool.query(
        `INSERT INTO rol (name, create_at) values ($1, $2) RETURNING * `,
        [`${nombre}`, `${date}`]
    );
    const rol = result.rows[0];
    return rol;
}

//const secret = process.env.JWT_SECRET
//const hash = process.env.PASSWORD_HASH
module.exports = {
    newUser,
    newRol,
    getUsuarios,
    setUsuarioStatus,
    getUsuario,
    newClient,
    deleteUser
}