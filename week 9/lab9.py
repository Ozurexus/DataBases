import psycopg2
from geopy.geocoders import Nominatim

con = psycopg2.connect(database="dvdrental1", user="postgres",
                       password="555666", host="127.0.0.1", port="5432")
cur = con.cursor()
cur.execute('''
CREATE OR REPLACE FUNCTION get_addr()
RETURNS SETOF address
AS $$
BEGIN
    RETURN QUERY SELECT * FROM address WHERE address LIKE '%11%' AND city_id BETWEEN 400 AND 600;
END;
$$ LANGUAGE plpgsql;
SELECT get_addr();
''')
rows = cur.fetchall()
for i in range(len(rows)):
    rows[i] = rows[i][0].split(',')
geolocator = Nominatim(user_agent="maximpin")
cur.execute('''
ALTER TABLE address
ADD COLUMN latitude float,
ADD COLUMN longitude float;
''')
for row in rows:
    loco = row[1]
    id = str(row[0].replace('(', ''))
    try:
        location = geolocator.geocode(loco)
        print(loco, location.latitude, location.longitude)
        cur.execute('''
        UPDATE address
        SET latitude = '''+str(location.latitude)+''', longitude = '''+str(location.longitude)+'''
        WHERE address_id = '''+id+''';
        ''')
    except:
        print(loco, 0, 0)
        cur.execute('''
        UPDATE address
        SET latitude = 0, longitude = 0
        WHERE address_id = '''+id+''';
        ''')
con.commit()
con.close()
