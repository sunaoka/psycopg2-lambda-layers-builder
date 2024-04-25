# psycopg2 AWS Lambda layers builder

AWS Lambda layer for psycopg2

## Build

### For Python 3.12

```bash
make PYTHON=3.12 ARCH=x86_64
```

## Creating a layer

<https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html#configuration-layers-create>

```bash
aws lambda publish-layer-version \
    --layer-name psycopg2-2.9.9-python3.12-x86_64 \
    --zip-file fileb://psycopg2-2.9.9-python3.12-x86_64.zip \
    --compatible-runtimes python3.12
```

## Testing on AWS Lambda

```python
import psycopg2

def handler(event, context):
    return psycopg2.__version__
```
