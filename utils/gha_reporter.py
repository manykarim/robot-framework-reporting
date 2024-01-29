from robot.api import ExecutionResult
from pytablewriter import MarkdownTableWriter


def get_suites_with_tests(suite):
    """
    Recursively walk through the suites to find suites containing tests.
    """
    suites_with_tests = []
    if suite.tests:
        # This suite has tests, add it to the list
        suites_with_tests.append(suite)
    else:
        # This suite does not have tests, check its child suites
        for sub_suite in suite.suites:
            suites_with_tests.extend(get_suites_with_tests(sub_suite))
    return suites_with_tests

result = ExecutionResult('results/output.xml')
stats = result.statistics
# print(stats.total.failed)
# print(stats.total.passed)

suites_with_tests = get_suites_with_tests(result.suite)

suite_results = []
for suite in suites_with_tests:
    suite_results.append([suite.full_name, suite.statistics.passed, suite.statistics.failed, suite.statistics.skipped, suite.statistics.total, suite.elapsed_time.total_seconds()])

table_columns = ["Test Suite", "Passed ✅", "Failed ❌", "Skipped 🛑", "Total", "Elapsed Time ⏱️"]

with open('test_overview.md', "w") as f:
    writer = MarkdownTableWriter(table_name= "Test Status", headers = table_columns, value_matrix = suite_results)
    writer.stream = f
    writer.write_table()

test_results = {}
for suite in suites_with_tests:
    tests_in_suite = []
    for test in suite.tests:
        status = lambda test: "✅ PASS" if test.status == "PASS" else ("❌ FAIL" if test.status == "FAIL" else "🛑 SKIP")
        tests_in_suite.append([test.name, status(test), test.elapsed_time.total_seconds()])
    test_results[suite.full_name] = tests_in_suite

with open('test_results.md', "w") as f:

    for suite in test_results:
        table_columns = ["Test Case", "Status", "Elapsed Time ⏱️"]
        writer = MarkdownTableWriter(table_name= suite, headers = table_columns, value_matrix = test_results[suite])
        writer.stream = f
        writer.write_table()

import os

with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f :
    overview = open('test_overview.md', "r").read()
    results = open('test_results.md', "r").read()
    print(overview + "\n" + results, file=f)