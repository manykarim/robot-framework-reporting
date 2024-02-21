import influxdb_client, os, time
from influxdb_client import InfluxDBClient, Point, WritePrecision, client
from influxdb_client.client.write_api import SYNCHRONOUS
import datetime

influxdb_token = "z2JUbQpw6meZnfKcDdD_yIBgUcIsFUCbXlBAjJILOS7TZu5WSyPx2aFbGEHGUlRjPPr8J4DTXK2jpUDUQeJ4xw=="
influxdb_org = "robotframework"
influxdb_url = "http://localhost:8086"


class InfluxListener:

    ROBOT_LIBRARY_SCOPE = "GLOBAL"
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self):
        self.write_client = influxdb_client.InfluxDBClient(
            url=influxdb_url, token=influxdb_token, org=influxdb_org
        )
        self.bucket = "results"
        self.write_api = self.write_client.write_api(write_options=SYNCHRONOUS)
        self.test = {"name": None, "longname": None}

    def start_test(self, test, result):
        self.test["name"] = test.name
        self.test["longname"] = test.longname

    def end_test(self, test, result):
        point = (
            Point("testresult")
            .tag("name", result.name)
            .tag("suite", result.parent.name)
            .field("elapsedtime", result.elapsed_time.total_seconds())
            .field("status", result.status)
            .field("message", result.message)
            .time(result.end_time)
        )
        self.write_api.write(bucket=self.bucket, org="robotframework", record=point)

    def end_keyword(self, keyword, result):
        point = (
            Point("keyword")
            .tag("name", result.kwname)
            .tag("library", result.libname)
            .tag("testname", self.test["name"])
            .tag("testlongname", self.test["longname"])
            .field("status", result.status)
            .field("elapsedtime", result.elapsed_time.total_seconds())
            .time(result.end_time)
        )
        self.write_api.write(bucket=self.bucket, org="robotframework", record=point)
