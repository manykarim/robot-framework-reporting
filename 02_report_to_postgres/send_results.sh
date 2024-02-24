#!/bin/bash
python report_to_postgres.py --run 1 --output results/cars_passed/output.xml --project car-configurator --version 1.0.0
python report_to_postgres.py --run 1 --output results/cars_wrong_amounts/output.xml --project car-configurator --version 2.0.0
python report_to_postgres.py --run 1 --output results/cars_slow/output.xml --project car-configurator --version 3.0.0
python report_to_postgres.py --run 1 --output results/cars_parallel/output.xml --project car-configurator --version 4.0.0
