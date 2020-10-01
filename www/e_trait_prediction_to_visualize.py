import json, sys, os, boto3
# to gain access to handler_functions
sys.path.insert(0, os.getenv("PWD"))

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from io import StringIO
from pandas.io.json import json_normalize
from handler_functions.s3_handler import pull_csv_from_s3

import ssodomino
ssodomino.auth()

boto3.setup_default_session(profile_name= '319254005391/standard-user')

lims_ids = ['20SSGA018', '20SSGA027', '20SSGA025', '20SSGA020', '20SSGA026']
s3_bucket = 'globalit-analytics-qc-np-319254005391'

for lims_id in lims_ids[:2]:
    s3_phenotype_key = 'projects/selection_analytics/' + lims_id + '/predicted_phenotype.csv'
    predicted_phenotypes = pull_csv_from_s3(s3_bucket = s3_bucket, s3_key= s3_phenotype_key)
    confusion_matrix = pd.crosstab(predicted_phenotypes['GBS_based_trait'], predicted_phenotypes['Imputation_based_traits'],
                               rownames=['Only GBS Observed Phenotype'], colnames=['Imputed based phenotype prediction'])
    plt.figure(figsize = (15, 7))
    sns.heatmap(confusion_matrix, annot = True, vmin = 0, vmax = predicted_phenotypes.shape[0]/len(predicted_phenotypes.Imputation_based_traits.unique()), fmt='g')
    plt.title('Comparison between imputation base predicted hilum color vs only gbs observation for project: ' + lims_id)
    plt.show()
    
    individual_probablistic_phenotypes = predicted_phenotypes.set_index('INDIVIDUAL_ID') \
    .apply({'Probablistic_phenotype': lambda x: pd.Series([[k, v] for k, v in json.loads(x.replace("\'", "\""))['hilum'].items()])}) \
    .stack() \
    .reset_index() \
    .drop('level_1', axis = 1)
    # change the column of list of 2 elements into two columns
    individual_probablistic_phenotypes[['phenotype','probability']] = pd.DataFrame(individual_probablistic_phenotypes.Probablistic_phenotype.tolist(), 
                                                      index= individual_probablistic_phenotypes.index) 
    individual_probablistic_phenotypes = individual_probablistic_phenotypes.drop(['Probablistic_phenotype'], axis = 1)
    
    plt.figure(figsize=(20,5))
    individual_phenotype_bar = sns.barplot(data = individual_probablistic_phenotypes, x = 'INDIVIDUAL_ID', y = 'probability', hue = 'phenotype')
    individual_phenotype_bar.set_xticklabels(individual_phenotype_bar.get_xticklabels(), rotation=90)
    plt.show()
    
    #upload the predicted phenoytpes to s3
    csv_buffer = StringIO()
    individual_probablistic_phenotypes.to_csv(csv_buffer, index = False)
    s3_client = boto3.client('s3')
    s3_client.put_object(Bucket = s3_bucket,
                        Key = 'projects/selection_analytics/' + lims_id + '/probablistic_phenotype.csv', 
                        Body = csv_buffer.getvalue())