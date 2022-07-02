# git clone https://github.com/GoogleCloudPlatform/appengine-guestbook-python app_engine
# cd app_engine


git submodule update --init --recursive
cd app_engine

DEV_NAME="app-engine-dev"
CONFIG_EXISTS="False"

for NAMES in $(gcloud config configurations list --format="csv(name:sort=1)")
do
    if [[ $NAMES == $DEV_NAME ]]
        then CONFIG_EXISTS="True"
    fi
done

echo $CONFIG_EXISTS

if [[ $CONFIG_EXISTS == "False" ]]
    then gcloud config configurations create $DEV_NAME
    else gcloud config configurations activate $DEV_NAME
fi

# Set project and account config
# gcloud config set region us-east1
# gcloud config set account ACCOUNT
# gcloud config set stop_previous_version True

gcloud app deploy ./index.yaml ./app.yaml

# datastore.googleapis.com