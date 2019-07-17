echo "Welcome to ODM docker."
echo "Follow command below"
echo "filename.bat DroneImagesfileLocation ResultsPath"
set PICTURE_SOURCE_DIR=%1
set RESULT_DIR=%2

cd %RESULT_DIR%

rmdir working_dir /s /q
rmdir results /s /q
rmdir "working_dir/images" /s /q

mkdir working_dir
mkdir results
mkdir "working_dir/images"

xcopy "%PICTURE_SOURCE_DIR%" "working_dir/images" /e /i

mkdir "working_dir/odm_orthophoto"
mkdir "working_dir/odm_georeferencing"
mkdir "working_dir/odm_meshing"
mkdir "working_dir/odm_texturing"
mkdir "working_dir\opensfm"
mkdir "working_dir\odm_dem"
pause

docker run -it --rm -v "%RESULT_DIR%/working_dir/images:/code/images" -v "%RESULT_DIR%/working_dir/odm_georeferencing:/code/odm_georeferencing" -v "%RESULT_DIR%/working_dir/odm_meshing:/code/odm_meshing"  -v "%RESULT_DIR%/working_dir/odm_orthophoto:/code/odm_orthophoto" -v "%RESULT_DIR%/working_dir/odm_texturing:/code/odm_texturing" -v "%RESULT_DIR%/working_dir/opensfm:/code/opensfm" -v "%RESULT_DIR%/working_dir/odm_dem:/code/odm_dem" opendronemap/odm

mkdir "results/odm_orthophoto"
xcopy "working_dir/odm_orthophoto" "results/odm_orthophoto" /e /i

mkdir "results/ODM_Products"

xcopy "working_dir" "results/ODM_Products" /e /i
rmdir "results/ODM_Products/images" /s /q
rmdir "working_dir" /s /q

mkdir "results/QGIS/Analysis_results"


docker run --name test_qgis3_model -it --rm -v %cd%/results/odm_orthophoto:/data/input -v "%cd%/results/QGIS/Analysis_results":/data/output  ismailsunni/qgis3-model /bin/bash start.sh odm_orthophoto.tif Ortho-DroneMapper_ndvi.tif






pause
