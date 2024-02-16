from robot.api import ExecutionResult
from pytablewriter import MarkdownTableWriter


class SuitesWithTestsVisitor(ResultVisitor):
    def __init__(self):
        self.suites_with_tests=[]
    def start_suite(self, suite):
        if suite.tests:
            self.suites_with_tests.append(suite)


result = ExecutionResult('results/output.xml')
stats = result.statistics

with open('test_overview_chart.md', "w") as f:
    f.write("```mermaid\n")
    f.write("%%{init: {'theme': 'base', 'themeVariables': { 'pie1': '#00FF00', 'pie2': '#FF0000', 'pie3': '#FFFF00'}}}%%\n")
    f.write("pie title Test Status\n")
    f.write(f'    "Passed" : {stats.total.passed}\n')
    f.write(f'    "Failed" : {stats.total.failed}\n')
    f.write(f'    "Skipped" : {stats.total.skipped}\n')
    f.write("```")

# ```mermaid
# %%{init: {'theme': 'base', 'themeVariables': { 'pie1': '#00FF00', 'pie2': '#FF0000', 'pie3': '#FFFF00'}}}%%
# pie title Test Status
#     "Passed" : 386
#     "Failed" : 85
#     "Skipped" : 15
# ```

suite_visitor = SuitesWithTestsVisitor()
result.visit(suite_visitor)
suites_with_tests = suite_visitor.suites_with_tests

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
if "GITHUB_STEP_SUMMARY" in os.environ :
    with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as f :
        chart = open('test_overview_chart.md', "r").read()
        overview = open('test_overview.md', "r").read()
        results = open('test_results.md', "r").read()
        print(chart + "\n" + overview + "\n" + results, file=f)