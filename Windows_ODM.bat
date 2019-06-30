@echo off
rmdir %2\odm_georeferencing /s /q
rmdir %2\odm_orthophoto /s /q
rmdir %2\odm_texturing /s /q
rmdir %2\odm_meshing /s /q
rmdir %2\opensfm /s /q
rmdir %2\odm_dem /s /q

mkdir %2\odm_georeferencing
mkdir %2\odm_orthophoto
mkdir %2\odm_texturing
mkdir %2\odm_meshing
mkdir %2\opensfm
mkdir %2\odm_dem




docker run -it --rm -v "%1\images:/code/images" -v "%2\odm_orthophoto:/code/odm_orthophoto" -v "%2\odm_texturing:/code/odm_texturing" -v "%2\odm_meshing:/code/odm_meshing" -v "%2\odm_georeferencing:/code/odm_georeferencing" -v "%2\opensfm:/code/opensfm" -v "%2\odm_dem:/code/odm_dem" opendronemap/odm

pause