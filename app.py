# Task: Create a simple container app (using Docker) using Flask to expose GET and POST methods.
# ------------------------------------------------------------------------------------------------
# -- 1. The app should create the table in the database if it does not exist (for all verbs).
# -- 2. The POST method is used to insert a new record into the table and the GET method returns
#       records in the table.
# -- 3. Use JSON for the request and response formats.
# ------------------------------------------------------------------------------------------------

from wsgiref.validate import validator
from flask import Flask, redirect, render_template, request, Response, url_for
from wtforms import Form, StringField, TextAreaField, validators, IntegerField
import sqlalchemy
from sqlalchemy import text
from connect_tcp import connect_tcp_socket

app = Flask(__name__)


# Initialize database
engine = connect_tcp_socket()  # sqlalchemy.engine.base.Engine


class InfoForm(Form):

    language = StringField('What language are you interested in learning? ', validators=[validators.optional()])
    movie = StringField('What\'s the most memorable movie you\'ve watched?  ', validators=[validators.optional()])
    celebrity = StringField('Which celebrity would you like a photo with? ', validators=[validators.optional()])
    dessert = StringField('What\'s your favourite desert? ', validators=[validators.optional()])
    travel = StringField('Where will you travel next summer? ', validators=[validators.optional()])


def create_table(db_engine: sqlalchemy.engine.base.Engine) -> None:
    with db_engine.connect() as conn:
        conn.execute(
            "CREATE TABLE IF NOT EXISTS favourite (\
                 person_id SERIAL NOT NULL PRIMARY KEY, \
                 language VARCHAR(20), \
                 movie VARCHAR(20), \
                 celebrity VARCHAR(20), \
                 dessert VARCHAR(20), \
                 travel VARCHAR(20) \
             );"
        )


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
        language = info.language.data
        movie = info.movie.data
        celebrity = info.celebrity.data
        dessert = info.dessert.data
        travel = info.travel.data

        stmt = text("INSERT INTO favourite (language, movie, celebrity, dessert, travel) \
                     VALUES (:language, :movie, :celebrity, :dessert, :travel)")

        # Store data in the MySQL database instance
        with engine.connect() as conn:
            conn.execute(stmt, language=language, movie=movie, \
                 celebrity=celebrity, dessert=dessert, travel=travel)

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
          
            favourite_data = conn.execute('SELECT * FROM favourite;')
            favourites = favourite_data.fetchall()  

        return render_template('get.html', favourites=favourites)


if __name__ == "__main__":
    app.run(host='127.0.0.1', port=8080, debug=True)
