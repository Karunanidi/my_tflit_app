# Makefile for deploying Flutter web app to GitHub Pages

deploy-web:
	@echo "Deploying to git repository"
	git add . && \
	git commit -m "update ui" && \
	git push 

	cd ../..
	@echo "Finished Deploy!!"

.PHONY: deploy-web