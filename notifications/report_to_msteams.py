from robot.api import ExecutionResult, ResultVisitor
from pytablewriter import MarkdownTableWriter

class SuitesWithTestsVisitor(ResultVisitor):
    def __init__(self):
        self.suites_with_tests=[]
    def start_suite(self, suite):
        if suite.tests:
            self.suites_with_tests.append(suite)

result = ExecutionResult('results/output.xml')

stats = result.statistics
pass_rate = (stats.total.passed / stats.total.total) * 100

suite_visitor = SuitesWithTestsVisitor()
result.visit(suite_visitor)
suites_with_tests = suite_visitor.suites_with_tests

run_columns = ["Pass Rate", "Passed ✅", "Failed ❌", "Skipped 🛑", "Total", "Elapsed Time ⏱️"]    

with open('run_overview.md', "w") as f:
    writer = MarkdownTableWriter(table_name= "Run Overview", headers = run_columns, value_matrix = [[f"{pass_rate:.2f}%", stats.total.passed, stats.total.failed, stats.total.skipped, stats.total.total, result.suite.elapsed_time.total_seconds()]])
    writer.stream = f
    writer.write_table()
    f.write("\n\n<br>\n\n")

suite_results = []
for suite in suites_with_tests:
    suite_results.append([suite.full_name, suite.statistics.passed, suite.statistics.failed, suite.statistics.skipped, suite.statistics.total, suite.elapsed_time.total_seconds()])

table_columns = ["Test Suite", "Passed ✅", "Failed ❌", "Skipped 🛑", "Total", "Elapsed Time ⏱️"]

with open('suite_overview.md', "w") as f:
    writer = MarkdownTableWriter(table_name= "Test Status", headers = table_columns, value_matrix = suite_results)
    writer.stream = f
    writer.write_table()
    f.write("\n\n<br>\n\n")

test_results = {}
for suite in suites_with_tests:
    tests_in_suite = []
    for test in suite.tests:
        if test.status != "PASS":
            status = lambda test: "✅ PASS" if test.status == "PASS" else ("❌ FAIL" if test.status == "FAIL" else "🛑 SKIP")
            tests_in_suite.append([test.name, status(test), test.message, test.elapsed_time.total_seconds()])
    test_results[suite.full_name] = tests_in_suite

with open('test_results.md', "w") as f:

    for suite in test_results:
        table_columns = ["Test Case <img width=100/>", "Status <img width=70/>", "Message", "Elapsed Time ⏱️ <img width=100/>"]
        writer = MarkdownTableWriter(table_name= f"Failed and skipped tests in {suite}", headers = table_columns, value_matrix = test_results[suite])
        writer.stream = f
        writer.write_table()
        f.write("\n\n<br>\n\n")


run_overview = open('run_overview.md', "r").read()
suite_overview = open('suite_overview.md', "r").read()
results = open('test_results.md', "r").read()

import apprise
from apprise import NotifyType
from apprise import NotifyFormat

apobj = apprise.Apprise()

apobj.add('msteams://<teamName>/<tokenA>/<tokenB>/<tokenC>')

if stats.total.failed == 0:
    title_message = "Test run completed successfully"
    body_message = run_overview + suite_overview
    apobj.notify(body=body_message, title=title_message, notify_type=NotifyType.SUCCESS)
else:
    title_message = f"Test run completed with {stats.total.failed} failures"
    body_message = run_overview + suite_overview + results
    apobj.notify(body=body_message, title=title_message, notify_type=NotifyType.FAILURE)