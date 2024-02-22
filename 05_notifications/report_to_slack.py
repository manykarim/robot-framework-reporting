from robot.api import ExecutionResult, ResultVisitor
from pytablewriter import MarkdownTableWriter


class SuitesWithTestsVisitor(ResultVisitor):
    def __init__(self):
        self.suites_with_tests = []

    def start_suite(self, suite):
        if suite.tests:
            self.suites_with_tests.append(suite)


result = ExecutionResult("results/output.xml")

stats = result.statistics
pass_rate = (stats.total.passed / stats.total.total) * 100

suite_visitor = SuitesWithTestsVisitor()
result.visit(suite_visitor)
suites_with_tests = suite_visitor.suites_with_tests


run_overview = f"""
*Run Overview*
*Pass Rate:* {pass_rate:.2f}%\n
*Passed ✅:* {stats.total.passed}\n
*Failed ❌:* {stats.total.failed}\n
*Skipped 🛑:* {stats.total.skipped}\n
*Total:* {stats.total.total}\n
*Elapsed Time ⏱️:* {result.suite.elapsed_time.total_seconds()}\n
\n\n
"""

failed_tests = []
failed_tests.append("*Failed Tests*")

for test in result.suite.all_tests:
    if test.status == 'FAIL':
        failed_tests.append(f"* {test.name}")
failed_tests_overview = "\n".join(failed_tests)

import apprise
from apprise import NotifyType

apobj = apprise.Apprise()
apobj.add("slack://T02TC517HV5/B06L0SULDHQ/Zqep3AO3Suwo2xbPS7ZBmwdX")

import os
report_path = os.path.abspath("results/report.html")
report = f"file://{report_path}"

if stats.total.failed == 0:
    title_message = "Test run completed successfully"
    body_message = run_overview
    apobj.notify(body=body_message, title=title_message, notify_type=NotifyType.SUCCESS)
else:
    title_message = f"Test run completed with {stats.total.failed} failures"
    body_message = run_overview + failed_tests_overview
    apobj.notify(body=body_message, title=title_message, notify_type=NotifyType.FAILURE, attach=report)