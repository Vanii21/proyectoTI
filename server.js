import express from "express"
import session from "express-session"
import dotenv from "dotenv"
import mysql from "mysql"
import myConnection from "express-myconnection"
import Swal from 'sweetalert2'

// Cargar variables
dotenv.config();

// Star Server
const app = express();

app.use(express.static("public"));
app.use(express.json());
app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));
    // Middleware para analizar solicitudes de formularios
app.use(express.urlencoded({ extended: false }));

//Home Route
app.get('/', (req, res) => {
    res.sendFile("index.html", { root: "public" });
});
    // Cart
app.get('/cart.html', (req, res) => {
    res.sendFile("cart.html", { root: "public" });
});

    // Success
app.get('/success.html', (req, res) => {
    res.sendFile("success.html", { root: "public" });
});    

    // Cancel
app.get('/cancel.html', (req, res) => {
    res.sendFile("cancel.html", { root: "public" });
});

    // Loging
app.get('/login', (req, res) => {
    if (req.session.loggedin) {
        Swal.fire('Hola');
        res.sendFile("/", { root: "public" });
    } else {
        res.sendFile("/login.html", { root: "public" });
    } 
});

app.get('/logout', (req, res) => {
    req.session.loggedin = false;
    res.sendFile("/login.html", { root: "public" });
});

// Stripe


// Conexion a la Base de Datos MariaDB
app.use(myConnection(mysql, {
    host: 'localhost',
    user: 'proyecto',
    password: '1234',
    port: 3306,
    database: 'ecommerce'
}, 'single'));

    // Api de datos
app.get('/api', (req, res) => {
    req.getConnection((err, conn) => {
        conn.query("SELECT id_articulo, nombre, precio, ruta FROM articulo", (err, articulos) => {
            if (err) {
                res.status(400).json({err: 'No hay productos'});
            }
            res.status(200).json(articulos)
        });
    });
});

    // Usuario
app.post('/usuario', (req, res) => {
    const txtUsuario = req.body.txtUsuario;
    const txtPassword = req.body.txtPassword;
    req.getConnection((err, conn) => {
        conn.query("SELECT id_usuario, usuario, clave FROM usuario WHERE usuario = ? AND clave = ?", [txtUsuario, txtPassword], (err, us) => {
            if (err) {
                res.status(400).json({err: 'No hay usuarios'});
            }
            if (us.length > 0) {
                req.session.loggedin = true;
                const isUsuario = JSON.parse(JSON.stringify(us));
                req.session.id_usuario = isUsuario[0].id_usuario;
                res.redirect('/');
            } else {
                req.session.loggedin = false;
                res.redirect('/login');
            }
        });
    
        if(err){
            console.error(err);
        }
    });
});

// Usuario
app.post('/registro', (req, res) => {
    const txtNombre = req.body.txtNombre;
    const txtUsuario = req.body.txtUsuario;
    const txtEmail = req.body.txtEmail;
    const selectOp = parseInt(req.body.selectOp);
    const txtPassword = req.body.txtPassword;
    req.getConnection((err, conn) => {
        conn.query("INSERT INTO usuario (usuario, clave, email, nombre, departamento_id_departamento) VALUES (?, ?, ?, ?, ?)", [txtUsuario, txtPassword, txtEmail, txtNombre, selectOp], (err, us) => {
            if (err) {
                res.status(400).json({err: 'No hay usuarios'});
            }
            res.redirect('/login');
        });
    
        if(err){
            console.error(err);
        }
    });
});

app.post('/finalizar', async (req, res) => {
    try {
        let totalVenta = 0; // Variable para almacenar el total de la venta
        for (const item of req.body.items) {
            const articulos = await new Promise((resolve, reject) => {
                req.getConnection((err, conn) => {
                    if (err) {
                        reject(err);
                    } else {
                        conn.query("SELECT id_articulo, precio, stock FROM articulo WHERE id_articulo = ?", [item.id_articulo], (err, result) => {
                            if (err) {
                                reject(err);
                            } else {
                                resolve(result);
                            }
                        });
                    }
                });
            });

            if (articulos.length > 0) {
                let precio = parseFloat(articulos[0].precio);
                let cantidad = parseFloat(item.quantity);
                if (!isNaN(precio) && !isNaN(cantidad)) {
                    totalVenta += precio * cantidad;
                    await new Promise((resolve, reject) => {
                        req.getConnection((err, conn) => {
                            if (err) {
                                reject(err);
                            } else {
                                conn.query("UPDATE articulo SET stock = ? WHERE id_articulo = ?", [articulos[0].stock - cantidad, item.id_articulo], (err, result) => {
                                    if (err) {
                                        reject(err);
                                    } else {
                                        resolve(result);
                                    }
                                });
                            }
                        });
                    });
                } else {
                    console.log("Precio o cantidad no es un número válido");
                }
            }
        }

        const usuario_id = req.session.id_usuario;
        const ventaInsertada = await new Promise((resolve, reject) => {
            req.getConnection((err, conn) => {
                if (err) {
                    reject(err);
                } else {
                    conn.query('INSERT INTO venta (fecha_venta, total, usuario_id_usuario) VALUES (NOW(), ?, ?)', [totalVenta, usuario_id], (err, result) => {
                        if (err) {
                            reject(err);
                        } else {
                            resolve(result);
                        }
                    });
                }
            });
        });

        const ventaId = ventaInsertada.insertId; // ID de la venta recién insertada

        // Insertar los detalles de la venta en la tabla detalle_venta
        for (const item of req.body.items) {
            await new Promise((resolve, reject) => {
                req.getConnection((err, conn) => {
                    if (err) {
                        reject(err);
                    } else {
                        conn.query('INSERT INTO detalle_venta (articulo_id_articulo, venta_id_venta) VALUES (?, ?)', [item.id_articulo, ventaId], (err, result) => {
                            if (err) {
                                reject(err);
                            } else {
                                resolve(result);
                            }
                        });
                    }
                });
            });
        }

        res.json({url: `http://localhost:3001/success.html`});
    } catch (error) {
        console.error("Error:", error);
        res.json({url: `http://localhost:3001/cancel.html`});
    }
});

app.listen(process.env.PORT, () => {
    console.log(`http://localhost:${process.env.PORT}`)
})