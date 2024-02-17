from robot.api import ExecutionResult, ResultVisitor
from pytablewriter import MarkdownTableWriter

result = ExecutionResult('output.xml')

# Result Object

stats = result.statistics

result_dict =   {
    "Passed": f"{stats.total.passed}",
    "Failed": f"{stats.total.failed}",
    "Skipped": f"{stats.total.skipped}",
    "Total": f"{stats.total.total}"
                }

print(result_dict)

# Test Suite and Test Case object

root_suite = result.suite

for test in root_suite.all_tests:
    test_dict = {
        "Test": test.name,
        "Suite": test.parent.name,
        "Status": test.status,
        "Elapsed": test.elapsed_time.total_seconds()
                }
    print(test_dict)


class SuitesWithTestsVisitor(ResultVisitor):
    def __init__(self):
        self.suites_with_tests=[]
    def start_suite(self, suite):
        if suite.tests:
            self.suites_with_tests.append(suite)

suite_visitor = SuitesWithTestsVisitor()
result.visit(suite_visitor)


suites_with_tests = suite_visitor.suites_with_tests

for suite in suites_with_tests:
    suite_result =  {
        "Suite Name":   suite.name,
        "Passed":   suite.statistics.passed,
        "Failed":   suite.statistics.failed,
        "Skipped":  suite.statistics.skipped,
        "Total":    suite.statistics.total,
        "Elapsed Time": suite.elapsed_time.total_seconds()
                    }
    print(suite_result)
