# robot-framework-reporting

This repository demonstrates multiple approaches towards reporting and monitoring of Robot Framework test results.

It will be used to demonstrate the following:
- Using the [Results Package](https://robot-framework.readthedocs.io/en/master/autodoc/robot.result.html) of the Robot Framework API to generate custom reports
- Creating a Markdown report for GitHub Actions
- Publishing Test Results to a PosgreSQL database and visualizing the results using [Grafana](https://grafana.com/)
- Using a Listener to capture test results and publish them to [InfluxDB](https://www.influxdata.com/) and visualize the results using [Grafana](https://grafana.com/)
- Using [Allure](https://allurereport.org/) to generate a visually appealing [report](https://manykarim.github.io/robot-framework-reporting/9/allure-report/index.html)
- Sending notifications to Slack and MS Teams using [Apprise](https://github.com/caronc/apprise)
- Using [ReportPortal](https://reportportal.io/) to publish test results and visualize them

## Open the project in Gitpod.io
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/manykarim/robotframework-reporting)  
Try it out in  [Gitpod](https://gitpod.io/#https://github.com/manykarim/robotframework-reporting)

## Try it out in Google CoLab
[![Try it out in CoLab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/manykarim/robot-framework-reporting/blob/main/robot_framework_reporting.ipynb)  
Try it out in [CoLab](https://colab.research.google.com/github/manykarim/robot-framework-reporting/blob/main/robot_framework_reporting.ipynb)

## Structure of the repository

The repository is structured as follows:

The repository is structured into the following sections:

- **01_resultmodel**:   
    This section demonstrates how to use the `ExecutionResult` and `ResultVisitor` of the Robot Framework API to generate custom reports.

- **02_report_to_postgres**:  
    This section demonstrates how to publish test results to a PostgreSQL database and visualize the results using Grafana.

- **03_allure**:  
    This section demonstrates how to use Allure to generate a visually appealing report.

- **04_listener_influxdb**:  
    This section demonstrates how to use a Listener to monitor test execution in realtime and publish them to InfluxDB and visualize the results using Grafana.

- **05_notifications**:  
    This section demonstrates how to send notifications to Slack and MS Teams using Apprise.

- **06_reportportal**:  
    This section demonstrates how to publish test results to ReportPortal and visualize them.

## Docker Containers for PostgreSQL, InfluxDB and Grafana

For the examples in folders `02_report_to_postgres` and `04_listener_influxdb` to work, you need to have PostgreSQL, InfluxDB and Grafana running.

You can find starter scripts to run PostgreSQL, InfluxDB and Grafana in Docker containers in the `docker` directory.

- `create_network.sh` creates a Docker network with the name `robot`  
This is necessary to allow the containers to communicate with each other.
- `start_postgres.sh` starts a PostgreSQL container with the name `postgres`
    - User: `postgres`
    - Password: `robotframework`
- `start_influxdb.sh` starts an InfluxDB container with the name `influxdb`
    - User: `admin`
    - Password: `my-password`
    - Organization: `robotframework`
    - Bucket: `results`
- `start_grafana.sh` starts a Grafana container with the name `grafana`  
Datasources for PostgreSQL and InfluxDB are created automatically.
    - User: `admin`
    - Password: `robotframework`  
