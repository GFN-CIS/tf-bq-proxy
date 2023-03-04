import os, sys, json
from google.cloud import bigquery
from google.oauth2 import service_account
import tempfile

data = json.load(sys.stdin)
fd, sa_file = tempfile.mkstemp()
with open(sa_file, 'w') as f:
    f.write(data['service_account'])
credentials = service_account.Credentials.from_service_account_file(sa_file)
client = bigquery.Client(credentials=credentials, project=data['project_id'], location=data['location'])
query_job = client.query(
    data['query']
)

df = query_job.to_dataframe()

print(json.dumps({"result": json.dumps(df.to_json(orient='records'))}))