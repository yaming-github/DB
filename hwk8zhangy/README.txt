# hwk8 MySQL connect w/ Python and pymysql

1. Please make sure you have installed Python and pymysql:

```
python -V or python3 -V
pip install pymysql
```

2. Modify the config file:<br>
   NOTE that you could also run the application without any modification because my MySQL server is listening on a
   public machine.<br>
   If you do not want to modify the config, please make sure using the user and password in the config file, which is "
   cs5200hwk8".<br>
   If you want to test on your machine, please make sure to modify the config file! For example:

```
{
  "host": "localhost",
  "port": 3306,
  "database": "librarydb"
}
```

3. Run the application and input the correct user, password and genre!

```
python hwk8zhangy.py
```