import json, sys, os, boto3
# to gain access to handler_functions
sys.path.insert(0, os.getenv("PWD"))

import pandas as pd
from handler_functions.s3_handler import pull_csv_from_s3
from handler_functions.token_handler import get_bearer_token
from handler_functions.db_connection import query_from_oracle
from handler_functions.queries import get_germplasm_pedigree

import ssodomino
ssodomino.auth()

boto3.setup_default_session(profile_name= '319254005391/standard-user')

observed_phenotype = pd.read_csv('../datasets/BRA_027_run_pheno_geno.csv')

observed_phenotype[observed_phenotype.BASE_INBRED == 'WH7718A6-B0YBN']

lims_id = '20SSGA018'
s3_bucket = 'globalit-analytics-qc-np-319254005391'
s3_lims_folder = 'projects/selection_analytics/' + lims_id + '/'
s3_client = boto3.client('s3')
s3_lims_marker_key = s3_lims_folder + 'marker_calls.csv'
project_imputed_calls = pd.DataFrame()
# pull in the csv file from s3
project_marker_calls = pull_csv_from_s3(s3_bucket = s3_bucket, s3_key = s3_lims_marker_key)

# get the PEDIGREE from germplasm_id and attach it to the current dataframe
germ_pedigree_query = get_germplasm_pedigree([item.astype(str) for item in project_marker_calls.GERMPLASM_ID.unique()])
token = get_bearer_token(client_id=os.getenv('CLIENT_ID'), client_secret=os.getenv('CLIENT_SECRET'), env = 'prod')
germ_pedigree = query_from_oracle(query = germ_pedigree_query, token = token)
project_marker_calls = project_marker_calls.merge(germ_pedigree, on = 'GERMPLASM_ID', how = 'left')

# now connect the observed phenotype with the project calls using the Pedigree

project_marker_calls.merge(observed_phenotype, left_on = 'PEDIGREE_NAME', right_on = )

project_marker_calls[project_marker_calls.PEDIGREE_NAME.isna()]

pd.crosstab(observed_phenotype['Phenotype data from Breeding'], observed_phenotype['RP Fingerprinting Data'])