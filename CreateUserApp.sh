#!/bin/sh
echo "########"


set -x

echo "Creating User App : " $1 $2 $3 $4 $5 $6

echo "Application Id    :" $1
echo "User Id           :" $2
echo "Bundle Identifier :" $3
echo "Application Name  :" $4
echo "Excution Directory:" $5

echo "runtime-configuration:" $6

CMIOS=$5

cd $CMIOS

RTCONFIG=$6
PLATFORM=HYBRID_IOS

APP_ID=$1
UUID=$2
APP_TITLE=$4
TEMPLATE_DIRECTORY=$CMIOS"CMIOSAppTemplate/"
DST_DIRECTORY=/buildTmp/$UUID/$APP_ID-$PLATFORM-$RTCONFIG
rm -rf /buildTmp/$UUID/
USER_PROJECT_DIR="CMIOSApp.xcodeproj"

BUNDLE_ID=$3
#BUNDLE_ID="com.pm.ibizamedia"
BUNDLE_FILE="LBAExample-Info.plist"



#APP_ID="TestApp"

#echo "Copy to tmp : " "${DST_DIRECTORY}"

#DST_DIRECTORY=\"$DST_DIRECTORY_RAW\"
#appIdentifier=ibizamedia5&uuid=11166763-e89c-44ba-aba7-4e9f4fdf97a9
#echo "destination directory " $DST_DIRECTORY
rm -rf "${DST_DIRECTORY}"
mkdir -p "${DST_DIRECTORY}"
#sed -i '' -e 's/CMIOSApp.app/MyApp.app/g' project.pbxproj
#echo "copy template" $TEMPLATE_DIRECTORY " to " $DST_DIRECTORY
#cp -rf $TEMPLATE_DIRECTORY \"$DST_DIRECTORY\"

rm -rf "${DST_DIRECTORY}"
rsync -aC $TEMPLATE_DIRECTORY "${DST_DIRECTORY}"

#echo "${DST_DIRECTORY}"/"${USER_PROJECT_DIR}"

#echo "${DST_DIRECTORY}/${USER_PROJECT_DIR}" "${DST_DIRECTORY}/${APP_ID}.xcodeproj"

mv "${DST_DIRECTORY}/${USER_PROJECT_DIR}" "${DST_DIRECTORY}/${APP_ID}.xcodeproj"



################## Adjust Xcode Project File

# SETTING PROJECT DIR


echo "Adjust XCode Project File"

USER_PROJECT_DIR="${DST_DIRECTORY}/${APP_ID}.xcodeproj"

USER_PROJECT_FILE="${USER_PROJECT_DIR}/project.pbxproj"
#echo "User Project File : " $USER_PROJECT_FILE

#CMIOS_PRODUCT_NAME
APP_ID_STRING=$APP_ID".app"



#APP_ID_STRING2="test App"

SED_APP_REPLACE_STRING="s/CMIOSApp.app/\"$APP_ID.app\"/g"
SED_APP_REPLACE_STRING_2="s/XTARGETNAME/\"$APP_ID\"/g"
#SED_APP_REPLACE_STRING_3="s/CMIOS_PRODUCT_NAME/\"${APP_ID}\"/g"
SED_APP_REPLACE_STRING_3="s/CMIOS_PRODUCT_NAME.app/\"$APP_ID_STRING\"/g"
SED_APP_REPLACE_STRING_4="s/CMIOS_PRODUCT_NAME/\"$APP_TITLE\"/g"

#echo $SED_APP_REPLACE_STRING
sed -i '' -e "${SED_APP_REPLACE_STRING}" "${USER_PROJECT_FILE}"
sed -i '' -e "${SED_APP_REPLACE_STRING_2}" "${USER_PROJECT_FILE}"
sed -i '' -e "${SED_APP_REPLACE_STRING_3}" "${USER_PROJECT_FILE}"
sed -i '' -e "${SED_APP_REPLACE_STRING_4}" "${USER_PROJECT_FILE}"


#echo \'$SED_APP_REPLACE_STRING\'
#echo $APP_ID_STRING

####### Cleanup Application's Project Folder
rm -rf "${USER_PROJECT_DIR}/cleaned"
rm -rf "${USER_PROJECT_DIR}/project.xcworkspace"
rm -rf "${USER_PROJECT_DIR}/xcuserdata"



################### Adjust Applications Info Plist file

echo "Adjust XCode Info plist"

PLIST_FILE="${DST_DIRECTORY}/${BUNDLE_FILE}"
SED_APP_REPLACE_STRING="s/com.pm.jiosbase/${BUNDLE_ID}/g"
sed -i '' -e "${SED_APP_REPLACE_STRING}" "${PLIST_FILE}"

################### Copy Libraries
rm -rf "${DST_DIRECTORY}/libs/"
mkdir -p "${DST_DIRECTORY}/libs/"

mkdir -p "${DST_DIRECTORY}/libs/CloudMade"
mkdir -p "${DST_DIRECTORY}/libs/Proj4"

cp $TEMPLATE_DIRECTORY"/libs/CloudMade/libCloudMadeApi.a" "${DST_DIRECTORY}/libs/CloudMade/"
cp $TEMPLATE_DIRECTORY"/libs/Proj4/libProj4.a" "${DST_DIRECTORY}/libs/Proj4/"
#cp "${TEMPLATE_DIRECTORY}/libs/*" "${DST_DIRECTORY}/libs/"
#cp -r "${TEMPLATE_DIRECTORY}libs/lib*" "${DST_DIRECTORY}/libs/"

rsync --include "lib*" -aC "${TEMPLATE_DIRECTORY}libs/" "${DST_DIRECTORY}/libs/"

#rm -rf "${DST_DIRECTORY}/libs/Debug-iphoneos"
#rm -rf "${DST_DIRECTORY}/libs/Release-iphoneos"
#rm -rf "${DST_DIRECTORY}/libs/Debug-iphonesimulator"
#rm -rf "${DST_DIRECTORY}/libs/Release-iphonesimulator"


####### Extracts Meta and ApplicationData

#echo "extract"  "/buildTmp/${UUID}${APP_ID}meta.zip" "to" "${DST_DIRECTORY}/"
#unzip -o -v "/tmp/${UUID}${APP_ID}meta.zip" -d "${DST_DIRECTORY}/"
echo "${DST_DIRECTORY}/"
cd /buildTmp
cp -v "$UUID""$APP_ID""meta.zip" "$DST_DIRECTORY"
cd "$DST_DIRECTORY"
unzip -o "$UUID""$APP_ID""meta.zip"
rm "$UUID""$APP_ID""meta.zip"

cp -v "cmapp/""$APP_ID"/"appSettings.xml" ./
cp -v "cmapp/""$APP_ID"/"index.html" ./www/index.html
mv  "cmapp/""$APP_ID"/* ./wwws
rm ./www/Assets/backgrounds/meta/Default.png
rm ./www/Assets/backgrounds/meta/Default@2x.png
rm ./www/Assets/icons/meta/xappolixIcon.png
rm ./www/Assets/icons/meta/xappolixIcon@2x.png
rm ./www/images/xappolixIcon.png
rm ./www/images/xappolixIcon@2x.png




#cp "${UUID}${APP_ID}meta.zip" " ${DST_DIRECTORY}/"
#unzip -o "$UUID""$APP_ID""meta.zip" " -d " "$DST_DIRECTORY"
#unzip "/tmp/11166763-e89c-44ba-aba7-4e9f4fdf97a9ibizamedia5meta.zip"

#unzip -o -v "${UUID}${APP_ID}meta.zip" -d "/tmp/"
#cp "/tmp/"$UUID""$APP_ID"-meta.zip /tmp/ap.zip"
#cp "/tmp/${UUID}${APP_ID}meta.zip" "/tmp/ap.zip"

#11166763-e89c-44ba-aba7-4e9f4fdf97a9-ibizamedia5-meta.zip
#11166763-e89c-44ba-aba7-4e9f4fdf97a9-ibizamedia5-meta.zip
#echo "${TEMPLATE_DIRECTORY}libs/.*" "${DST_DIRECTORY}/libs/"
cd ..
cd ..

#echo "zipping : " "$UUID"/"$APP_ID""/*"  "${UUID}${APP_ID}.zip"
rm -rf "${UUID}${APP_ID}-${PLATFORM}-{$RTCONFIG}.zip"
echo -------------------------------------"$DST_DIRECTORY"
cd "$DST_DIRECTORY"
cd ..
ls
zip -q -r ../"${UUID}${APP_ID}-${PLATFORM}-$RTCONFIG.zip" .
echo "CMIOSBUILD_FINISH:1"