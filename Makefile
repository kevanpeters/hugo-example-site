#########################################################
#
# REPLACE THESE VALUES
#prod values
prod_bucket = # example.com
prod_dist_id = #K39UNTAKEEF3XF   
# dev values
dev_bucket = #stage.example.com
dev_dist_id = #D1IH4Q01BJE1W7
# REPLACE THESE VALUES
#########################################################

setup-check:
	hugo version
	aws --version
	cdk --version

local: 
	hugo server -D

build-site:
	hugo

dev:
	aws s3 sync public/ s3://${dev_bucket}/ --acl public-read
	aws cloudfront create-invalidation --distribution-id ${dev_dist_id} --paths /

upload-prod:
	aws s3 sync public/ s3://${prod_bucket}/ --acl public-read
	
invalidate-cache:	
	aws cloudfront create-invalidation --distribution-id ${prod_dist_id} --paths /

publish: build-site upload-prod invalidate-cache