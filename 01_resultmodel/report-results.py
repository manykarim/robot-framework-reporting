from robot.api import ExecutionResult, ResultVisitor
import sys

class TestFinder(ResultVisitor):

    def __init__(self, markdown_file):
        self.f = open(f"{markdown_file}", "w")

    def start_result(self, result):
        stats = result.statistics.total
        self.f.write("# Overview\n")
        self.f.write("| Passed | Failed | Skipped |\n")
        self.f.write("| --- | --- | --- |\n")
        self.f.write(f"| {stats.passed} | {stats.failed} | {stats.skipped} |\n\n")

    def start_suite(self, suite):
        if suite.tests:
            stats = suite.statistics
            self.f.write(f"## {suite.name}\n")
            self.f.write("| Passed | Failed | Skipped |\n")
            self.f.write("| --- | --- | --- |\n")
            self.f.write(f"| {stats.passed} | {stats.failed} | {stats.skipped} |\n\n")
            self.f.write(f"### Test Results\n")
            self.f.write("| Test | Status | Elapsed |\n")
            self.f.write("| --- | --- | --- |\n")
    
    def start_test(self, test):
        status_emoji = {
            "PASS": "✅ PASS",
            "FAIL": "❌ FAIL",
            "SKIP": "🛑 SKIP",
            "NOT RUN": "NOT RUN",
            "NOT SET": "❓ NOT SET",
             }
        self.f.write(f"| {test.name} | {status_emoji.get(test.status, "unknown")} | {test.elapsed_time.total_seconds()} |\n")

    def end_suite(self,suite):
        if suite.tests:
            self.f.write("\n")      

def main():
    output_file = sys.argv[1]
    markdown_file = sys.argv[2]
    result = ExecutionResult(output_file)
    visitor = TestFinder(markdown_file)
    result.visit(visitor)

if __name__ == "__main__":
    main()