#! /bin/bash

echo "Executing setup..."
rm -rf build/
mkdir build/

markdown-pdf README.md
cd 01-projeto/ && markdown-pdf README.md && cd ..
cd 02-controller/ && markdown-pdf README.md && cd ..
cd 03-repositorio/ && markdown-pdf README.md && cd ..
cd 04-service/ && markdown-pdf README.md && cd ..
cd 05-controller-refactoring/ && markdown-pdf README.md && cd ..
cd 06-tests/ && markdown-pdf README.md && cd ..
cd 07-ci/ && markdown-pdf README.md && cd ..
cd 08-deploy/ && markdown-pdf README.md && cd ..

echo " "
echo "Generating all pdfs..."
mv README.pdf build/00.pdf
mv 01-projeto/README.pdf build/01.pdf
mv 02-controller/README.pdf build/03.pdf
mv 03-repositorio/README.pdf build/03.pdf
mv 04-service/README.pdf build/04.pdf
mv 05-controller-refactoring/README.pdf build/05.pdf
mv 06-tests/README.pdf build/06.pdf
mv 07-ci/README.pdf build/07.pdf
mv 08-deploy/README.pdf build/08.pdf

echo " "
echo "Generating book..."
cd build/
pdftk *.pdf cat output book.pdf

echo " "
echo "Executing clean..."
rm -f 00.pdf
rm -f 01.pdf
rm -f 02.pdf
rm -f 03.pdf
rm -f 04.pdf
rm -f 05.pdf
rm -f 06.pdf
rm -f 07.pdf
rm -f 08.pdf
cd ..

echo " "
echo "---------------------------"
echo "Build executed Succesfully!"
echo "---------------------------"
