from robot.api import ExecutionResult, ResultVisitor
import sqlalchemy
import pandas as pd
from sqlalchemy import JSON
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy import create_engine
import json
import sys
import argparse


class SuitesWithTestsVisitor(ResultVisitor):
    def __init__(self):
        self.suites_with_tests = []

    def start_suite(self, suite):
        if suite.tests:
            self.suites_with_tests.append(suite)


def upload_results(output, run, project, version):

    # Some metadata in a dictionary (I will later use that for filtering in Grafana)
    run_metadata = {
        "test_run": run,
        "environment": "dev",
        "branch": "main",
        "version": version,
        "build": "1.0.0",
        "project": project,
    }

    # Set up DB connection
    engine = create_engine(
        "postgresql://postgres:robotframework@localhost:5432/robotframework_json"
    )

    result = ExecutionResult(output)
    stats = result.statistics
    suite_visitor = SuitesWithTestsVisitor()
    result.visit(suite_visitor)

    suites_with_tests = suite_visitor.suites_with_tests

    suite_results_columns = [
        "testsuite",
        "passed",
        "failed",
        "skipped",
        "total",
        "elapsedtime",
        "metadata",
        "starttime",
        "endtime",
    ]

    suite_results = []
    for suite in suites_with_tests:
        suite_results.append(
            [
                suite.name,
                suite.statistics.passed,
                suite.statistics.failed,
                suite.statistics.skipped,
                suite.statistics.total,
                suite.elapsed_time.total_seconds(),
                run_metadata,
                suite.start_time,
                suite.end_time,
            ]
        )


    test_results_columns = [
        "test",
        "status",
        "elapsedtime",
        "testsuite",
        "metadata",
        "starttime",
        "endtime",
    ]

    test_results = []
    test_json = []
    for suite in suites_with_tests:
        tests_in_suite = []
        for test in suite.tests:
            test_results.append(
                [
                    test.name,
                    test.status,
                    test.elapsed_time.total_seconds(),
                    suite.name,
                    run_metadata,
                    test.start_time,
                    test.end_time,
                ]
            )
            test_json.append([test.to_dict()])

    test_run_results_columns = [
        "testsuite",
        "passed",
        "failed",
        "skipped",
        "total",
        "elapsedtime",
        "metadata",
        "starttime",
        "endtime",
    ]
    test_run_results = [
        [
            result.suite.name,
            result.statistics.total.passed,
            result.statistics.total.failed,
            result.statistics.total.skipped,
            result.statistics.total.total,
            result.suite.elapsed_time.total_seconds(),
            run_metadata,
            result.suite.start_time,
            result.suite.end_time,
        ]
    ]

    # Combining Lists with Data and Lists with columns into Dataframes
    test_run_results_df = pd.DataFrame(
        test_run_results, columns=test_run_results_columns
    )
    testresults_df = pd.DataFrame(test_results, columns=test_results_columns)
    testresults_json_df = pd.DataFrame(test_json, columns=["json"])
    testsuite_results_df = pd.DataFrame(suite_results, columns=suite_results_columns)

    # Write to database - Columns and column types are mapped automatically
    test_run_results_df.to_sql(
        "testrun_results",
        engine,
        if_exists="append",
        index=True,
        dtype={"metadata": JSONB},
    )

    testsuite_results_df.to_sql(
        "testsuite_results",
        engine,
        if_exists="append",
        index=True,
        dtype={"metadata": JSONB},
    )

    testresults_df.to_sql(
        "test_results",
        engine,
        if_exists="append",
        index=True,
        dtype={"metadata": JSONB},
    )
    testresults_json_df.to_sql(
        "test_results_json",
        engine,
        if_exists="append",
        index=True,
        dtype={"json": JSONB},
    )


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--run", default="1")
    parser.add_argument("--output", default="output.xml")
    parser.add_argument("--project", default="myproject")
    parser.add_argument("--version", default="1.0.0")
    args = parser.parse_args()
    return args


def main():
    print("this is the main function")
    inputs = parse_args()
    print(inputs)
    upload_results(
        output=inputs.output,
        run=inputs.run,
        project=inputs.project,
        version=inputs.version,
    )


if __name__ == "__main__":
    main()
