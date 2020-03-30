#!/usr/bin/env node
'use strict'
const { Worker, parentWorkerProcess} =require("worker_threads");
const mysql      = require('mysql');

const fs= require('fs');
const parse=require('csv-parse');
const csvHeaders = require('csv-headers');
const async=require("async");
const dbhost = process.argv[2];
const dbuser = process.argv[3];
const dbpass = process.argv[4];
const dbname = process.argv[5];
const tblnm  = process.argv[6];
const csvfn  = process.argv[7];
const idJob  = process.argv[8]
const config= require("./config.json");
const countThreads=config['countThreads'];
var errInsertData=false;
const errData= "data:text/csv;charset=utf-8,";
//const table = process.ar
var db;

var dbManager;
//writeFile('errData.csv', errData);
createErrFile();
//process.exit();
    if (fs.existsSync(csvfn)) {
      //file exists
      connectDB();
      dbManager.query(`SELECT * FROM jobs where (file="${csvfn}") `,(err, data)=>{
        if(data){  
            //throw "file imported";
            console.log(data);
        }
      });
    fs.createReadStream(csvfn).pipe(parse({
        delimiter: ',',
        columns: true,
        relax_column_count: true
    }, (err, data) => {
        /**
         * //if (err) console.log(err);
        async.eachSeries(data, (datum, next) => {
            // console.log(`about to run INSERT INTO ${tblnm} ( ${context.fieldnms} ) VALUES ( ${context.qs} )`);
           console.log(datum);
           next();
        });*/
        //console.log(data.length);
        let length=data.length;
        var datum=[];
        let range=data.length/countThreads;
        let start=0;
        //let idJob=0;
        let date=new Date();
        date=date.toISOString().split('T')[0] + ' '  
        + date.toTimeString().split(' ')[0];
        dbManager.query(`UPDATE ${config["tbljob"]} SET file="${csvfn}",progress="0",status="0",created_at="${date}",updated_at="${date}"  where (id= "${idJob}")`,(err,data) => {
            if (err) { console.error(err);  }
            else{
                //console.log(
                  //  idJob=data.insertId;
            }
        });
       // console.log(range);
        for(var i=0;i<countThreads;i++){
            let temp=[]
            for(var j= start ;j < start+range;j++){
                temp.push(data[j]);
               // console.log(data[j]);
            }
            datum[i]=temp;
            start+=range;

        }
        //console.log(data);
       // { workerData: { id, index } }
        //console.log(datum[1]);
        var progress=0;
        const wordker_list=[];
        for(var index=0;index<countThreads;index++){
            let data=datum[index]
            wordker_list[i]=new Worker('./csvmysql.js',{workerData:{
                csvfn,
                dbhost,
                dbuser,
                dbpass,
                dbname,
                data,
                tblnm,
                idJob,
                //dbManager
            }});
            
            wordker_list[i].on('exit',(msg)=>{
                //console.log("exit worker " + wordker_list[i].threadId);
                progress+=100/countThreads;
                dbManager.query(`INSERT INTO ${config["tblworker"]} (type,address,status,last_heathy,jobId) VALUES ("node","/node/","1","${date}","${idJob}")`);
                console.log(`UPDATE ${config["tbljob"]} SET progress ="${progress}" where ('id'="${idJob}")`);
                dbManager.query(`UPDATE ${config["tbljob"]} SET progress ="${progress}" where (id="${idJob}" )`,err => {
                    if (err) { console.error(err);  }
                    
                });
            });
            wordker_list[i].on("message",(msg)=>{
                hanldMSgWorker(msg);
            })
            
            //console.log(datum[index]);
        }
        //console.log(errInsertData);
        
       // console.log(progress);
        err => {
            if (err) reject(err);
            else resolve(context);
        }}));
        
    }
   else {
    console.error("file not exits")
  }
 
  
function connectDB(){
    db=mysql.createConnection({
        host     : dbhost,
        user     : dbuser,
        password : dbpass,
        database : dbname
    });
    dbManager=mysql.createConnection({
        host     : config['dbhost'],
        user     : config['dbuser'],
        password : config['dbpass'],
        database : config['dbname']
    });
    dbManager.connect(function(err,data){
        if(err){
            console.log("err connect to database manager jobs" +e);
        }
        else{
            console.log("connect to database manager jobs success");

        }


    });
    db.connect(function(err,data){
        if(err){
            console.log("err connect to database" +e);
        }
        else{
            console.log("connect to database success");

        }


    });
}
function hanldMSgWorker(msg){
    if(msg.status=='err'){
        hanldErrWorker(msg.data);
    }
    else{
        console.log(msg.data);
    }
}
function hanldErrWorker(d){
    errInsertData = true;
    for(var i=0;i<d.length;i++){
        //if(d[i].indexOf(",")){d[i]='"'+d[i]+'"'};
        d[i]='"'+d[i]+'"';
    }
    
  /**  
    let data=d.map(item=>{
        let value=toString(item);
        if(value.includes(",")){
           //console.log(`"`+value+`"`);
           console.log(value);
            return `"`+value+`"`;
        }
        /**else{
            return value;
        }
          });
        */
    //Array.fliter
    let row = d.join(",");
    row += "\r\n";
    //errData += row;
    if(errInsertData){
        /**csvContent="";
        errData.forEach(function(rowArray) {
            let row = rowArray.join(",");
            csvContent += row + "\r\n";
        });*/
        //writeFile(errData);
        //console.log(errData);
        //console.log(data);
        fs.appendFile('errData.csv', row, function (err) {
            if (err) return console.log(err);
            //console.log(row);
          });
    
    
      }
}
function getHeaderCsvFile(file){
   return  new Promise((resolve, reject) => {
        //dbManager
        csvHeaders({
            file      : file,
            delimiter : ','
        }, function(err, headers) {
            if (err) reject(err);
            //else resolve({ headers });
            else {
                
               let value;
               //console.log(value);
               value = headers.join(",") + "\r\n" ;
               //console.log(value);
               return resolve(value);

            }
        });
    })
}
function writeFile(file,data){
    fs.appendFile(file,data,function(err){
        throw err;
    })
}
function createErrFile(){
    getHeaderCsvFile(csvfn).then(values=>{ console.log(values); writeFile('errData.csv', values)});
}