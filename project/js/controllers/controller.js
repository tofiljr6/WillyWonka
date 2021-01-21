const mariadb = require('mariadb');
const bcrypt = require('bcryptjs');
const {exec} = require('child_process');
const fs = require('fs');

const poolApp = mariadb.createPool({
  host: 'localhost',
  port: '3306',
  user: 'app',
  password: 'apppassword',
  database: 'wedel',
  dateStrings: true,
  connectionLimit: 5
});

const poolAdmin = mariadb.createPool({
  host: 'localhost',
  port: '3306',
  user: 'admin',
  password: 'adminpassword',
  database: 'wedel',
  dateStrings: true,
  connectionLimit: 5
});

const poolManager = mariadb.createPool({
  host: 'localhost',
  port: '3306',
  user: 'manager',
  password: 'managerpassword',
  database: 'wedel',
  dateStrings: true,
  connectionLimit: 5
});

const poolWorker = mariadb.createPool({
  host: 'localhost',
  port: '3306',
  user: 'worker',
  password: 'workerpassword',
  database: 'wedel',
  dateStrings: true,
  connectionLimit: 5
});

const pool = {
  app: poolApp,
  admin: poolAdmin,
  manager: poolManager,
  worker: poolWorker
};

async function addSupplier(type, name, nip) {
  const conn = await pool[type].getConnection();
  const query = 'INSERT INTO suppliers (name, nip) VALUES (?, ?)';
  await conn.query(query, [name, nip]);
  conn.end();
  return query;
}

async function addClient(type, name, city, street) {
  const conn = await pool[type].getConnection();
  const query = 'INSERT INTO clients (name, city, street_and_number) VALUES (?, ?, ?)';
  await conn.query(query, [name, city, street]);
  conn.end();
  return query;
}

async function addChocolate(userType, name, producer, type, flavour, mass, price) {
  const conn = await pool[userType].getConnection();
  const query = 'CALL addChocolate(?, ?, ?, ?, ?, ?)';
  await conn.query(query, [name, producer, type, flavour, mass, price]);
  conn.end();
}

async function addCandy(userType, name, producer, type, flavour, mass, price) {
  const conn = await pool[userType].getConnection();
  const query = 'CALL addCandy(?, ?, ?, ?, ?, ?)';
  await conn.query(query, [name, producer, type, flavour, mass, price]);
  conn.end();
}

async function addJellyCandy(userType, name, producer, type, flavour, mass, price) {
  const conn = await pool[userType].getConnection();
  const query = 'CALL addJellyCandy(?, ?, ?, ?, ?, ?)';
  await conn.query(query, [name, producer, type, flavour, mass, price]);
  conn.end();
}

async function addChocolateBar(userType, name, producer, flavour, mass, price) {
  const conn = await pool[userType].getConnection();
  const query = 'CALL addChocolateBar(?, ?, ?, ?, ?)';
  await conn.query(query, [name, producer, flavour, mass, price]);
  conn.end();
}

async function getNames(type) {
  const conn = await pool[type].getConnection();
  // const types = ['chocolate', 'candy', 'jelly candy', 'chocolate bar'];
  const types = ['chocolates', 'candies', 'jellyCandies', 'chocolateBars'];
  let productsData = [];
  let suppliers = [];
  try {
    await conn.query('SELECT supplierId, name FROM suppliers')
      .then(result => {
        for (let el of result) {
          if (el !== 'meta') {
            suppliers.push(el);
          }
        }
      });
  } catch (e) {
    console.log(e);
  }
  console.log(suppliers);

  for (type of types) {
    try {
      productsData.push({
        name: type,
        data: (await conn.query(`SELECT id, name, mass FROM ${type}`))
      });
    } catch (e) {
      console.log(e);
    }
  }
  console.log(productsData);
  conn.end();

  return {
    suppliers: suppliers,
    productsData: productsData
  };
}

async function getPlanSaleData(type) {
  const conn = await pool[type].getConnection();
  const types = ['chocolates', 'candies', 'jellyCandies', 'chocolateBars'];
  // const types = ['chocolate', 'candy', 'jelly candy', 'chocolate bar'];
  let productsData = [];
  let clients = [];

  try {
    await conn.query('SELECT clientId, name FROM clients')
      .then(result => {
        for (let el of result) {
          if (el !== 'meta') {
            clients.push(el);
          }
        }
      });
  } catch (e) {
    console.log(e);
  }
  console.log(clients);

  for (type of types) {
    const sql = `SELECT t.id, t.name, t.mass, quantity FROM ${type} t JOIN products p on t.id = p.id`;
    try {
      productsData.push({
        name: type,
        data: (await conn.query(sql))
      });
    } catch (e) {
      console.log(e);
    }
  }
  console.log(productsData);
  conn.end();

  return {
    clients: clients,
    productsData: productsData
  };
}

async function planSale(type, saleData) {
  const client_id = saleData.client;
  const date = saleData.date;
  const products = saleData.products;

  if (new Date(date) < new Date()) {
    throw new Error("You can't plan for the past!")
  } else if (products === undefined || products.length === 0) {
    throw new Error("You can't plan empty sale!")
  }

  const conn = await pool[type].getConnection();
  await conn.beginTransaction()
    .then(async () => {
      const newSale =
        'INSERT INTO sales(date, clientId, done) VALUES (?, ?, ?)';

      await conn.query(newSale, [date, client_id, false])
        .then(async (e) => {
          const lastId = e.insertId;
          console.log('last insert id: ' + lastId);

          for (let product of products) {
            conn.query('INSERT INTO salesInfo(productId, saleId, quantity) VALUES (?, ?, ?)',
              [product.id, lastId, product.quantity]);
          }

          console.log("Inserted");
        });
      conn.commit();
    });

  conn.end();
}

async function planSupply(type, supplyData) {
  const supplier_id = supplyData.supplier;
  // const supplier_id = 2;
  const date = supplyData.date;
  const products = supplyData.products;

  if (new Date(date) < new Date()) {
    throw new Error("You can't plan for the past!")
  } else if (products === undefined || products.length === 0) {
    throw new Error("You can't plan empty supply!")
  }

  const conn = await pool[type].getConnection();
  await conn.beginTransaction()
    .then(async () => {
      const newSupply =
        'INSERT INTO supplies(date, supplierId, done) VALUES (?, ?, ?)';

      console.log(supplyData);

      await conn.query(newSupply, [date, supplier_id, false])
        .then(async (e) => {
          const lastId = e.insertId;
          console.log('last insert id: ' + lastId);

          for (let product of products) {
            conn.query('INSERT INTO suppliesInfo(productId, supplyId, quantity) VALUES (?, ?, ?)',
              [product.id, lastId, product.quantity]);
          }

          console.log("Inserted");
        });
      conn.commit();
    }).catch(e => {
      console.log(e);
      console.log("TUTAJ DAJE FULLA");
      console.log(supplyData);
      console.log(supplier_id)
    });

  conn.end();
}

async function addUser(userType, login, password, type) {
  const conn = await pool[userType].getConnection();
  await bcrypt.hash(password, 10, async function (err, hashPassword) {
    const query = 'INSERT INTO users (login, password, type) VALUES (?, ?, ?)';
    await conn.query(query, [login, hashPassword, type]);
  });
  conn.end();
}

async function login(login, password, session) {
  const conn = await pool['app'].getConnection();
  const query = 'SELECT password, type FROM users WHERE login = ?';
  const result = await conn.query(query, [login]);
  conn.end();

  let response = await bcrypt.compare(password, result[0].password);

  if (response) {
    session.login = login;
    session.type = result[0].type;
  }

  return session;
}

async function getSupplies(type) {
  const conn = await pool[type].getConnection();

  let supplies = [];

  let supplies_ids = (await conn.query('SELECT supplyId FROM supplies WHERE done = 0')).map(e => e.supplyId);

  console.log(supplies_ids);

  for (let supply_id of supplies_ids) {
    try {
      supplies.push({
        supply_id: supply_id,
        date: (await conn.query('SELECT date FROM supplies WHERE supplyId = ?', [supply_id]))[0].date,
        supplier: (await conn.query(
          'SELECT name FROM supplies JOIN suppliers ON supplies.supplierId = suppliers.supplierId WHERE supplyId = ?',
          [supply_id]
        ))[0].name,
        products: (await conn.query('SELECT name, mass, s.quantity' +
          ' FROM suppliesInfo s JOIN products p on s.productId = p.id ' +
          ' WHERE supplyId = ?', [supply_id]))
      });
    } catch (e) {
      console.log(e);
    }
  }

  conn.end();

  return supplies;
}

async function updateSupply(type, supply_id) {
  const conn = await pool[type].getConnection();
  try {
    await conn.query('CALL updateSupply(?)', [supply_id]);
    conn.end();
  } catch (e) {
    console.log(e);
    conn.end();
    throw new Error(e.message);
  }
}

async function getSales(type) {
  const conn = await pool[type].getConnection();

  let sales = [];

  let sales_ids = (await conn.query('SELECT saleId FROM sales WHERE done = 0')).map(e => e.saleId);

  console.log(sales_ids);

  for (let sale_id of sales_ids) {
    try {
      sales.push({
        sale_id: sale_id,
        date: (await conn.query('SELECT date FROM sales WHERE saleId = ?', [sale_id]))[0].date,
        client: (await conn.query(
          'SELECT name FROM sales JOIN clients ON sales.clientId = clients.clientId WHERE saleId = ?',
          [sale_id]
        ))[0].name,
        products: (await conn.query('SELECT name, mass, s.quantity' +
          ' FROM salesInfo s JOIN products p on s.productId = p.id ' +
          ' WHERE saleId = ?', [sale_id]))
      });
    } catch (e) {
      console.log(e);
    }
  }

  conn.end();

  return sales;
}

async function updateSale(type, sale_id) {
  const conn = await pool[type].getConnection();

  try {
    await conn.query('CALL updateSale(?)', [sale_id]);
    conn.end();
  } catch (e) {
    console.log(e);
    conn.end();
    throw new Error(e.message);
  }
}

async function getProducts(type) {
  const conn = await pool[type].getConnection();
  const types = ['chocolates', 'candies', 'jellyCandies', 'chocolateBars'];
  let productsData = [];

  for (type of types) {
    try {
      productsData.push({
        name: type,
        data: (await conn.query(`SELECT id, name, mass FROM ${type}`))
      });
    } catch (e) {
      console.log(e);
    }
  }
  console.log(productsData);
  conn.end();

  return {
    productsData
  };
}

async function quantityOnDate(type, product_id, date) {
  const conn = await pool[type].getConnection();
  let quantity = null;

  console.log(date);

  try {
    // if (date > Date.now()) {
      await conn.query('SELECT quantityOnDate(?, ?) as quantity', [product_id, date])
          .then(e => {
            quantity = e[0].quantity;
          }).catch(e => {
            console.log(e);
          });
      conn.end();



    // } else {
    //   quantity = "please enter future date";
    // }
  } catch (e) {

    console.log(e);
    conn.end();
    return quantity;
  }
  return quantity;
}

function createBackup() {
  const date = new Date();
  exec('mysqldump -u admin -padminpassword wedel', (error, stdout, stderr) => {
  // exec('mysqldump -u admin -p wedel', (error, stdout, stderr) => {
    if (error) {
      console.log(error);
    }
    fs.writeFile(`./backups/${date.getTime()}.sql`, stdout, (err) => {
      if (err) {
        console.log(err);
      }
    });
  });
  console.log('Done');
}

async function getBackups() {
  return await fs.readdirSync('./backups') || [];
}

function restore(backupName) {
  exec(`mysql -u admin -padminpassword wedel < ./backups/${backupName}`, (err, stdout, stderr) => {
    if (err) {
      console.log(err);
    }
  });
}

async function getSchema(type) {
  const conn = await pool[type].getConnection();
  let result = null;
  await conn.query('SELECT table_name, column_name FROM `INFORMATION_SCHEMA`.`columns` WHERE table_schema = "wedel" AND table_name <> "users"')
    .then(schema => {
      result = schema;
    }).catch(err => {
      result = err;
    });
  conn.end();
  return result;
}

async function customQuery(queryData, type) {
  const conn = await pool[type].getConnection();
  console.log(queryData);
  let query = 'SELECT ';
  query += queryData.columns.join(', ');
  query += ' FROM ' + queryData.table;

  let result = [];

  await conn.query(query, [])
    .then(e => {
      result = e;
    }).catch( err => {
      console.log(err);
      result = null;
    });

  console.log(JSON.stringify(result));
  conn.end();
  return result;
}

async function getUsers() {
  const conn = await pool['admin'].getConnection();
  const query = 'SELECT login FROM users';
  const result = await conn.query(query, []);
  conn.end();
  console.log(result);
  return result;
}

async function deleteUser(user) {
  const conn = await pool['admin'].getConnection();
  const query = 'DELETE FROM users WHERE login = ?';
  await conn.query(query, [user]);
  conn.end();
}

module.exports = {
  addSupplier, addUser, login, addClient, addChocolate, addCandy, addJellyCandy,
  addChocolateBar, customQuery, getSchema, getUsers, deleteUser, restore, getBackups, createBackup, quantityOnDate,
  getProducts, planSale, getPlanSaleData, getNames, planSupply, updateSupply, getSupplies,
  getSales, updateSale
}
