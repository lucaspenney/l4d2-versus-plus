mkdir -p build
cd build
if [ -d addons/ ]; then
	echo "Sourcemod already downloaded, skipping"
else
	curl -O https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6488-windows.zip
	unzip sourcemod-1.10.0-git6488-windows.zip
fi
cd ..
./build/addons/sourcemod/scripting/spcomp.exe ./l4d2-versus-plus.sp
