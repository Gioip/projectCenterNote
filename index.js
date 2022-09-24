// importaciones
const express = require("express");
const app = express();
const exphbs = require("express-handlebars");
const expressFileUpload = require("express-fileupload");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const secretKey = "shhhh";

const {
    newRol,
    newUser,
    newClient,
    getUsuarios,
    setUsuarioStatus,
    getUsuario,
    deleteUser
} = require('./services.js')

app.listen(3000, () => console.log("server RUNNING"));

// Middlewares
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.static(__dirname + "/public"));
app.use(expressFileUpload({limits: 5000000, abortOnLimit: true, responseOnLimit: "el tamaño de la imagen supera el limite permitido"}));
app.use("/css", express.static(__dirname + "/node_modules/bootstrap/dist/css"));
app.engine("handlebars", exphbs.engine({defaultLayout: "main", layoutsDir: `${__dirname}/views/mainLayout`}));
app.set("view engine", "handlebars");


// rutas


//vista Home
app.get('/', (req, res) => {
    res.render('Home')
});
// verificacion de inicio sesion
app.post("/verify", async function (req, res) {
    const {email, password} = req.body;
    const user = await getUsuario(email, password);
    
    if (user) {
        if (user.auth) {
            const token = jwt.sign({
                exp: Math.floor(Date.now() / 1000) + 180,
                data: user
            }, secretKey);
            res.send(token);
        } else {
            res.status(401).send({error: "Este usuario esta bloqueado, consulte con el administrador", code: 401});
        }
    } else {
        res.status(404).send({error: "Este usuario no esta registrado", code: 404})
    }
});

//verificar token
app.get('/validartoken', (req, res) =>{
    const {token} =req.query;    
    jwt.verify(token, secretKey,(err, decoded)=>{
        const { data} = decoded;
        const {rol} = data;    
        
        if(rol === 'admin'){
            res.redirect(`/Admin?token=${token}`)
        }
        else if(rol === 'receptor'){
            res.redirect(`/RegisEquip?token=${token}`)
        }
        else if(rol === 'tecnico'){
            res.redirect(`/RegisTechnical?token=${token}`)
        }
    })
})

app.get("/RegisTechnical", function (req, res) {
    res.render("RegisTechnical")
});

// vista registro de usuarios
app.get("/RegisUser", function (req, res) {
    res.render("RegisUser")
});

// captura de los datos del registro usuario
app.post("/usuarios", async (req, res) => {
    const {
        dni,
        email,
        name,
        lastName,        
        password,
        rol
    } = req.body;
    const fecha = new Date();
    const forDate = fecha.toLocaleDateString();
    try {
        const user = await newUser(dni, email, name, lastName, password, rol, forDate);
        res.status(201).send(user);
    } catch (e) {
        res.status(500).send({error: `Algo salio mal... ${e}`, code: 500})
    };
});


// vista registro de clientes
app.get("/RegisClient", (req, res) => {
    res.render("RegisClient")
});
// captura de los datos del registro cliente
app.post("/clientes", async (req, res) => {
    const {
        dni,
        email,
        name,
        lastName,
        phone
    } = req.body;
    const fecha = new Date();
    const forDate = fecha.toLocaleDateString();
    try {
        const user = await newClient(dni, email, name, lastName, phone, forDate);
        res.status(201).send(user);
    } catch (e) {
        res.status(500).send({error: `Algo salio mal... ${e}`, code: 500})
    };
});


// lista de usuario (portal del admin)
app.get('/Admin', async (req, res) => {    
    try {
            const listUser = await getUsuarios();
            const {token} = req.query;
            jwt.verify(token, secretKey, (err, decoded) => {
                const { data} = decoded;                
        const {name, email} = data;
                if(err){
                  res.send(err.message)
                }else{
                    res.render('Admin', {listUser,name, email});
                  
                }
              })
        } catch (e) {
        res.status(500).send({            
            error: "401 Unauthorized",
            message: "usted no esta autorizado para estar aqui",
            token_error: e.message
    })
    };
});

// rebiendo identificador y el autentificador del usuario
app.put("/usuarios", async (req, res) => {
    const {id, auth} = req.body;
    try {
        const usuario = await setUsuarioStatus(id, auth);
        res.status(200).send(usuario);
    } catch (e) {
        res.status(500).send({error: ` Algo salio mal... ${e}`, code: 500})
    };
});

//vista de registro de equipo
app.get("/RegisEquip", (req, res) => {
    res.render("RegisEquip")
})


// buscar por orden de registro
app.get("/buscar", async (req, res) => {
    const {rut} = req.body;
    console.log(req.body)
    const listUser = await getUsuarios();
    const auth = listUser.find((s) => s.dni === rut);

    if (auth) {
        res.send(`<script>alert("cliente existe"); window.location.href = "/RegisEquip"</script>`);

    } else {
        res.send(`<script>alert("el cliente no exite"); window.location.href = "/RegisEquip"</script>`);
    }

});


//eliminar usuarios
app.get("/delete", async (req, res) => {
    try {
      const { id } = req.query;
      console.log(req.query)
      await deleteUser(+id);
      res.status(200).send(`<script>alert("Usuario eliminado"); window.location.href = "/"</script>`);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });



//------------------------------------------------

// app.get('/rol', (req, res) => {
//     res.render('rol')
// })

// app.post("/rols", async (req, res) => {
//     const {rol} = req.body;
//     const fecha = new Date();
//     const forDate = fecha.toLocaleDateString();

//     try {
//         const roles = await newRol(rol, forDate);
//         res.status(201).send(roles);
//     } catch (e) {
//         res.status(500).send({error: `Algo salio mal... ${e}`, code: 500})
//     };
// })
