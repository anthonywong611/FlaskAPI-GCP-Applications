# Task: Create a simple container app (using Docker) using Flask to expose GET and POST methods.
# ------------------------------------------------------------------------------------------------
# -- 1. The app should create the table in the database if it does not exist (for all verbs). 
# -- 2. The POST method is used to insert a new record into the table and the GET method returns 
#       records in the table.  
# -- 3. Use JSON for the request and response formats. 
# ------------------------------------------------------------------------------------------------

import datetime
import logging
import os
from typing import Dict
from wsgiref.validate import validator

from flask import Flask, redirect, render_template, request, Response, url_for

import sqlalchemy
from sqlalchemy import Column, Integer, String, create_engine
from sqlalchemy.orm import declarative_base

from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, validators, IntegerField


from connect_tcp import connect_tcp_socket

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'anthony'
app.config['MYSQL_PASSWORD'] = 'Huangjianen611?'
app.config['MYSQL_DB'] = 'flask_app'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

class InfoForm(Form):

     first_name = StringField('First Name ', validators=[validators.input_required()])
     last_name = StringField('Last Name ', validators=[validators.input_required()])
     age = IntegerField('Age ', validators=[validators.NumberRange(min=0, max=120)])
     gender = StringField('Gender ', validators=[validators.optional()])
     ethnicity = StringField('Ethnicity ', validators=[validators.optional()])


# engine = connect_tcp_socket()  # -> sqlalchemy.engine.base.Engine

def create_table(db) -> None:
    with db.connection.cursor() as cur:
        cur.execute(
            "CREATE TABLE IF NOT EXISTS person (\
                 person_id INT NOT NULL AUTO_INCREMENT, \
                 first_name VARCHAR(20) NOT NULL, \
                 last_name VARCHAR(20) NOT NULL, \
                 age INT(120), \
                 gender VARCHAR(10), \
                 ethnicity VARCHAR(20), \
                 PRIMARY KEY (person_id) \
             );"
        )

# Home Page
@app.route('/', methods=['POST', 'GET'])
def home():
     create_table(mysql)
     return render_template('home.html')

# Input data into the database
@app.route('/post', methods=['POST', 'GET'])
def enter():

     info = InfoForm(request.form)
     if request.method == 'POST' and info.validate():

          # Retrieved input information from the form
          first_name = info.first_name.data
          last_name = info.last_name.data
          age = info.age.data
          gender = info.gender.data
          ethnicity = info.ethnicity.data

          # Store data in the MySQL database instance
          with mysql.connection.cursor() as cur:
               cur.execute("INSERT INTO person (first_name, last_name, age, gender, ethnicity) \
                            VALUES(%s, %s, %s, %s, %s)", 
               (first_name, last_name, str(age), gender, ethnicity)
               )
               mysql.connection.commit()
     
          return redirect(url_for('enter'))
     else:
          return render_template('post.html', info=info)

# Check the already inputted data
@app.route('/get')
def check():
     if request.method == 'POST': 
          return render_template('post.html')
     else:
          with mysql.connection.cursor() as cur:

               people_data = cur.execute('SELECT * FROM person;')
               people = cur.fetchall()

               return render_template('get.html', people=people)


if __name__ == "__main__":
     app.run(host='127.0.0.1', port=8080, debug=True)
