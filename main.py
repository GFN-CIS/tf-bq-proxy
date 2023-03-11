import os, sys, json
from google.cloud import bigquery
from google.oauth2 import service_account
import tempfile
# import pydevd_pycharm
#
# pydevd_pycharm.settrace('localhost', port=6456, stdoutToServer=True, stderrToServer=True)
try:
    data = json.load(sys.stdin)
except:
    data = json.loads(os.environ['TF_BQ_PROXY_DATA'])
credentials = service_account.Credentials.from_service_account_file(data['access_token'])

client = bigquery.Client(credentials=credentials, project=data['project_id'], location=data['location'])
query_job = client.query(
    data['query']
)

df = query_job.to_dataframe()

print(json.dumps({"result": json.dumps(df.to_json(orient='records'))}))
