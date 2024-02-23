#!/bin/bash
rm -R output/allure
mkdir -p output/allure
cp allure-report/history output/allure/history || true
robot --listener allure_robotframework -d results tests/01
allure-2.25.0/bin/allure generate output/allure -o allure-report --clean || allure generate output/allure -o allure-report --clean