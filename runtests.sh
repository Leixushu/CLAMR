#!/bin/sh

echo "./clamr_gpuonly -n 256 -i 100 -t 1000"
./clamr_gpuonly -n 256 -i 100 -t 1000
echo ""
echo ""


echo "./clamr_gpuonly -n 128 -i 100 -t 600"
./clamr_gpuonly -n 128 -i 100 -t 600
echo ""
echo ""

echo "mpirun -n 1 ./clamr_checkall -n 256 -i 100 -t 1000"
mpirun -n 1 ./clamr_checkall -n 256 -i 100 -t 1000
echo ""
echo ""

#mpirun -n 4 ./clamr_checkall -n 256 -i 100 -t 1000
echo "mpirun -n 1 ./clamr_checkall -n 128 -i 100 -t 600"
mpirun -n 1 ./clamr_checkall -n 128 -i 100 -t 600
echo ""
echo ""

echo "mpirun -n 2 ./clamr_checkall -n 128 -i 100 -t 600"
mpirun -n 2 ./clamr_checkall -n 128 -i 100 -t 600
echo ""
echo ""

echo "mpirun -n 3 ./clamr_checkall -n 4 -i 1 -t 1 -z"
mpirun -n 3 ./clamr_checkall -n 4 -i 1 -t 1 -z
echo ""
echo ""

#mpirun -n 3 ./clamr_checkall -n 4 -i 1 -t 1