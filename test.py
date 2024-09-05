import psycopg2

def handler(event, context):
    return psycopg2.__version__
