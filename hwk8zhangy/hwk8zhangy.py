import json
import pymysql.cursors

# global variables
host = ''
port = 0
database = ''
connection = None
cursor = None
genre = ''


def config():
    with open('config.json', 'r') as f:
        data = json.load(f)

    global host, port, database
    host = data["host"]
    port = data["port"]
    database = data["database"]


# Q1. Prompt the user and password
# Q2. Create global variables connection and cursor for future use and connect via the user and password
def conn():
    global connection, cursor
    while True:
        user = input("Please enter MySQL username: ")
        password = input("Please enter MySQL password: ")
        try:
            connection = pymysql.connect(host=host,
                                         port=port,
                                         user=user,
                                         password=password,
                                         database=database)
        except pymysql.err.OperationalError as e:
            print(e)
            print("Oops! It seems that something is wrong here. Please check your hostname and port "
                  "or re-enter the user and password")
            continue

        print("Welcome!")
        break
    cursor = connection.cursor()


# Q3. Similar to the input of user and password
# Q4. Retrieve the genre list by using the cursor and SQL
# Q5. Input the book genre and store in a global variable. Validate the input in a while loop and
# print error message if the input is invalid
def promptBookGenre():
    cursor.execute("SELECT name FROM genre")
    genre_list = [row[0] for row in cursor.fetchall()]

    # Display list of genres to user
    print("Available genres: ")
    print(*genre_list, sep=", ")

    # Prompt user for a valid genre
    while True:
        global genre
        genre = input("Please enter a book genre: ")
        if genre in genre_list:
            break
        else:
            print("Oops! Your entered genre is not in our list, please choose from the list of available genres.")


# Q6. call the procedure here using cursor.callproc method
# Q7. print all the result
def getLists():
    cursor.callproc('book_has_genre', (genre,))
    print(cursor.fetchall())


# Q8. close the global variables cursor and the mysql connection
def close():
    cursor.close()
    connection.close()


if __name__ == '__main__':
    config()
    conn()
    promptBookGenre()
    getLists()
    close()
