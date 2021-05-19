# psycopg2 AWS Lambda layers builder

## Build

### For Python 3.8

```bash
make PYTHON=3.8
```

### For Python 3.7

```bash
make PYTHON=3.7
```

## Testing on AWS Lambda

```python
import psycopg2

def lambda_handler(event, context):
    return psycopg2.__version__
```
