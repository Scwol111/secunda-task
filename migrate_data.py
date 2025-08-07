
import os
import sys

from sqlalchemy import create_engine, text


engine = create_engine('postgresql://postgres:postgres@localhost/secunda')
with engine.connect() as con:
    for i in con.execute(text('SELECT datname FROM pg_database')):
        if i[0] == 'secunda':
            sys.exit(0)
    with open("db_dump.sql", 'r', encoding='utf-8') as file:
        query = text(file.read())
        con.execute(query)
