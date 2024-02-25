API_KEY="<reportPortalApiToken>"

python $PWD/post_report.py \
--variable RP_ENDPOINT:"https://saas.reportportal.io" \
--variable RP_API_KEY:"$API_KEY" \
--variable RP_PROJECT:"robocon-io" \
--variable RP_LAUNCH:"Robot Framework Launch" \
--variable RP_LAUNCH_ATTRIBUTES:"robocon version:1.0 type:regression" \
/workspace/robot-framework-reporting/results/output.xml