API_KEY="<reportPortalApiToken>"

robot --listener robotframework_reportportal.listener \
--variable RP_ENDPOINT:"https://saas.reportportal.io" \
--variable RP_API_KEY:$API_KEY \
--variable RP_PROJECT:"robocon-io" \
--variable RP_LAUNCH:"Restful Booker" \
--variable RP_LAUNCH_ATTRIBUTES:"robocon version:3.0 type:regression component:booker" \
tests/01/booker

robot --listener robotframework_reportportal.listener \
--variable BROWSER:chromium \
--variable RP_ENDPOINT:"https://saas.reportportal.io" \
--variable RP_API_KEY:$API_KEY \
--variable RP_PROJECT:"robocon-io" \
--variable RP_LAUNCH:"MFA Login Chromium" \
--variable RP_LAUNCH_ATTRIBUTES:"robocon version:3.0 type:regression component:login browser:chromium" \
tests/01/login

robot --listener robotframework_reportportal.listener \
--variable BROWSER:chromium \
--variable RP_ENDPOINT:"https://saas.reportportal.io" \
--variable RP_API_KEY:$API_KEY \
--variable RP_PROJECT:"robocon-io" \
--variable RP_LAUNCH:"ToDo Chromium" \
--variable RP_LAUNCH_ATTRIBUTES:"robocon version:3.0 type:regression component:todo browser:chromium" \
tests/01/todo

robot --listener robotframework_reportportal.listener \
--variable BROWSER:firefox \
--variable RP_ENDPOINT:"https://saas.reportportal.io" \
--variable RP_API_KEY:$API_KEY \
--variable RP_PROJECT:"robocon-io" \
--variable RP_LAUNCH:"MFA Login Firefox" \
--variable RP_LAUNCH_ATTRIBUTES:"robocon version:3.0 type:regression component:login browser:firefox" \
tests/01/login

robot --listener robotframework_reportportal.listener \
--variable BROWSER:firefox \
--variable RP_ENDPOINT:"https://saas.reportportal.io" \
--variable RP_API_KEY:$API_KEY \
--variable RP_PROJECT:"robocon-io" \
--variable RP_LAUNCH:"ToDo Firefox" \
--variable RP_LAUNCH_ATTRIBUTES:"robocon version:3.0 type:regression component:todo browser:firefox" \
tests/01/todo