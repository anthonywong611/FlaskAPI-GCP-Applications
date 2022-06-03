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
from wtforms import Form, StringField, TextAreaField, validators, IntegerField
import sqlalchemy
from connect_tcp import connect_tcp_socket

app = Flask(__name__)

# app.config['MYSQL_HOST'] = 'localhost'
# app.config['MYSQL_USER'] = 'anthony'
# app.config['MYSQL_PASSWORD'] = 'Huangjianen611?'
# app.config['MYSQL_DB'] = 'flask_app'
# app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# mysql = MySQL(app)

# Initialize database
engine = connect_tcp_socket()  # sqlalchemy.engine.base.Engine


class InfoForm(Form):

    first_name = StringField('First Name ', validators=[validators.input_required()])
    last_name = StringField('Last Name ', validators=[validators.input_required()])
    age = IntegerField('Age ', validators=[validators.NumberRange(min=0, max=120)])
    gender = StringField('Gender ', validators=[validators.optional()])
    ethnicity = StringField('Ethnicity ', validators=[validators.optional()])


def create_table(db_engine: sqlalchemy.engine.base.Engine) -> None:
    with db_engine.connect() as conn:
        conn.execute(
            "CREATE TABLE IF NOT EXISTS person (\
                 person_id SERIAL NOT NULL PRIMARY KEY, \
                 first_name VARCHAR(20) NOT NULL, \
                 last_name VARCHAR(20) NOT NULL, \
                 age INT CHECK (age >= 0 AND age <= 120), \
                 gender VARCHAR(10), \
                 ethnicity VARCHAR(20) \
             );"
        )
        #conn.commit()  # DBAPI connection is non-autocommitting


# Home Page
@app.route('/', methods=['POST', 'GET'])
def home():
    create_table(engine)
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
        with engine.connect() as conn:
            conn.execute("INSERT INTO person (first_name, last_name, age, gender, ethnicity) \
                            VALUES (%s, %s, %s, %s, %s)",  # TODO: Need to check if this format works in Postgres...
                         {"first_name": first_name,
                          "last_name": last_name,
                          "age": str(age),
                          "gender": gender,
                          "ethnicity": ethnicity}
                         )
            #conn.commit()

        return redirect(url_for('enter'))
    else:
        return render_template('post.html', info=info)


# Check the already inputted data
@app.route('/get')
def check():
    if request.method == 'POST':
        return render_template('post.html')
    else:
        with engine.connect() as conn:
          
            people_data = conn.execute('SELECT * FROM person;')
            people = people_data.fetchall()  # TODO: changed conn to people_data... Not sure yet
            #conn.commit()

        return render_template('get.html', people=people)


if __name__ == "__main__":
    app.run(host='127.0.0.1', port=8080, debug=True)
