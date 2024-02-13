import influxdb_client, os, time
from influxdb_client import InfluxDBClient, Point, WritePrecision, client
from influxdb_client.client.write_api import SYNCHRONOUS
from robot.api import ExecutionResult, ResultVisitor
from datetime import datetime,timezone

influxdb_token = "z2JUbQpw6meZnfKcDdD_yIBgUcIsFUCbXlBAjJILOS7TZu5WSyPx2aFbGEHGUlRjPPr8J4DTXK2jpUDUQeJ4xw=="
influxdb_org = "robotframework"
influxdb_url = "http://localhost:8086"


class Influx_Reporter(ResultVisitor):
  def __init__(self):
    self.write_client = influxdb_client.InfluxDBClient(url=influxdb_url, token=influxdb_token, org=influxdb_org)
    self.bucket="results"
    self.write_api = self.write_client.write_api(write_options=SYNCHRONOUS)
    self.test = {"name": None, "longname": None}

  def start_test(self, test):
    self.test["name"] = test.name
    self.test["longname"] = test.longname

  def end_test(self, test):
    point = (
        Point("testresult")
        .tag("name", test.name)
        .tag("suite", test.parent.name)
        .tag("release", "v5")
        .tag("status", test.status)
        .tag("message", test.message)
        .field("message", test.message)
        .field("status", test.status)
        .field("elapsedtime", test.elapsed_time.total_seconds())
        .field("starttime", test.start_time.timestamp())
        .field("endtime", test.end_time.timestamp())
        .time(test.end_time)
      )
    self.write_api.write(bucket=self.bucket, org="robotframework", record=point)

  def end_keyword(self, keyword):
    point = (
      Point("keyword")
      .tag("name", keyword.kwname)
      .tag("library", keyword.libname)
      .tag("testname", self.test["name"])
      .tag("testlongname", self.test["longname"])
      .field("status", keyword.status)
      .field("elapsedtime", keyword.elapsed_time.total_seconds())
      .field("starttime", keyword.start_time.timestamp())
      .field("endtime", keyword.end_time.timestamp())
      .time(keyword.end_time)
    )
    self.write_api.write(bucket=self.bucket, org="robotframework", record=point)

result = ExecutionResult("results/output.xml")
result.visit(Influx_Reporter())