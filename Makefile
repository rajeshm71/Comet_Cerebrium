.PHONY: init data baseline train deploy prepare-deployment test-endpoint

DEPLOYMENT_DIR = deployment_dir
CEREBRIUM_API_KEY = private-bfd39f9a575b4c09ab87

init:
	curl -sSL https://install.python-poetry.org | python -
	poetry install
	
data:
	poetry run python src/data.py

baseline:
	poetry run python src/baseline_model.py

train:
	poetry run python src/train.py


# prepare-deployment:
# 	rm -rf $(DEPLOYMENT_DIR) && mkdir $(DEPLOYMENT_DIR)
# 	poetry export -f requirements.txt --output $(DEPLOYMENT_DIR)/requirements.txt --without-hashes
# 	cp -r src/predict.py $(DEPLOYMENT_DIR)/main.py
# 	cp -r src $(DEPLOYMENT_DIR)/src/
# 	# pip install cerebrium --upgrade # otherwise cerebrium deploy might fail
#
# deploy: prepare-deployment
# 	cd $(DEPLOYMENT_DIR) && poetry run cerebrium deploy eth-price-1-hour-predictor $(CEREBRIUM_API_KEY) --hardware CPU

prepare-deployment:
	rm -rf $(DEPLOYMENT_DIR) && mkdir $(DEPLOYMENT_DIR)
	/C/Users/rajes/AppData/Roaming/Python/Scripts/poetry export -f requirements.txt --output $(DEPLOYMENT_DIR)/requirements.txt --without-hashes
	cp -r src/predict.py $(DEPLOYMENT_DIR)/main.py
	cp -r src $(DEPLOYMENT_DIR)/src/
	pip install cerebrium --upgrade # otherwise cerebrium deploy might fail

deploy: prepare-deployment
	cd $(DEPLOYMENT_DIR) && /C/Users/rajes/AppData/Roaming/Python/Scripts/poetry run cerebrium deploy eth-price-1-hour-predictor --api-key $(CEREBRIUM_API_KEY) --hardware CPU


test-endpoint:
	poetry run python src/test_endpoint.py