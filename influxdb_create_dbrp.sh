influx config create --config-name ROBOTFRAMEWORK \
  --host-url http://localhost:8086 \
  --org robotframework \
  --token z2JUbQpw6meZnfKcDdD_yIBgUcIsFUCbXlBAjJILOS7TZu5WSyPx2aFbGEHGUlRjPPr8J4DTXK2jpUDUQeJ4xw== \
  --active

influx v1 dbrp list

influx v1 dbrp update \
  --id 75693aec5d233d49 \
  --rp robot-rp \
  --default