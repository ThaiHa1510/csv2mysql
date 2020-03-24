'use strict'
const {parentPort,parentWorkerProcess,workerData}=require('worker_threads');
const mysql=require('mysql');
const csvHeaders = require('csv-headers');
const async=require('async');
const{
    host,     
    user ,
    password ,
    database ,
    data,
    table
}=workerData;
/**console.log(workerData);
console.log("\n");
console.log(workerData.dbhost);
*/

new Promise((resolve, reject) => {
    //dbManager
    csvHeaders({
        file      : workerData.csvfn,
        delimiter : ','
    }, function(err, headers) {
        if (err) reject(err);
        else resolve({ headers });
    });
})
.then(context => {
    return new Promise((resolve, reject) => {

        context.db = mysql.createConnection({
            host     : workerData.dbhost,
            user     : workerData.dbuser,
            password : workerData.dbpass,
            database : workerData.dbname
        });

        context.db.connect((err) => {
            if (err) {
                console.error('error connecting: ' + err.stack);
                reject(err);
            } else {
                console.log("connect database in worker");
                resolve(context);
            }
        });
    })
})
.then(context => {
    return new Promise((resolve, reject) => {
        var fields = '';
        var fieldnms = '';
        var qs = '';
        context.headers.forEach(hdr => {
            hdr = hdr.replace(' ', '_');
            if (fields !== '') fields += ',';
            if (fieldnms !== '') fieldnms += ','
            if (qs !== '') qs += ',';
            fields += ` ${hdr} TEXT`;
            fieldnms += ` ${hdr}`;
            qs += ' ?';
        });
        context.qs = qs;
        context.fieldnms = fieldnms;
        //console.log(`about to create CREATE TABLE IF NOT EXISTS ${workerData.tblnm} ( ${fields} )`);
        context.db.query(`CREATE TABLE IF NOT EXISTS ${workerData.tblnm} ( ${fields} )`,
        [ ],
        err => {
            if (err) reject(err);
            else resolve(context);
        })
    });
})
.then(context=>{
    return new Promise((resolve, reject) => {
       // console.log(workerData.data);
    async.eachSeries(workerData.data, (datum, next) => {
         //console.log(`about to run INSERT INTO ${workerData.tblnm} ( ${context.fieldnms} ) VALUES ( ${context.qs} )`);
        //console.log(datum['Year']);   
        //return;
        var d = [];
        try {
            context.headers.forEach(hdr => {
                // In some cases the data fields have embedded blanks,
                // which must be trimmed off
                let tp = datum[hdr].trim();
                // For a field with an empty string, send NULL instead
                d.push(tp === '' ? null : tp);
                //console.log(d);
            });
        } catch (e) {
            console.error(e.stack);
        }
           
        // console.log(`${d.length}: ${util.inspect(d)}`);
        if (d.length > 0) {
            //console.log(d);
            insertData(context,d,next);
        } else { console.log(`empty row ${util.inspect(datum)} ${util.inspect(d)}`); next(); }
        
    },
    err => {
        if (err) reject(err);
        else resolve(context);
    });})
})
.then(context=>{
    context.db.end();
    parentPort.unref();
})
.catch(e=>{
    console.log(e)
})
function insertErr(err,data){
    parentPort.postMessage("err")
}
function insertData(context,d,next){
    context.db.query(`INSERT INTO ${workerData.tblnm} ( ${context.fieldnms} ) VALUES ( ${context.qs} )`, d,
            err => {
                if (err) { 
                   // console.error(err); next(err);
                   hanldeErr(err,d);
                   setTimeout(() => { next(); });
                     
                }
                else setTimeout(() => { next(); });
            });
}
function hanldeErr(err,d){
    parentPort.postMessage({
        status:'err',
        data:d
    });
    
}