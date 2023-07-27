useradd --shell /bin/false --home /home/user1 --create-home user1
passwd user1
usermod -aG sudo user1
su - user1 -s /bin/bash
git clone https://github.com/xja/localsend
# Refer to https://developer.android.com/studio for latest link
mkdir -p ~/Library/Android/sdk/cmdline-tools/
cd ~/Library/Android/sdk/cmdline-tools/
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
unzip commandlinetools-linux-9477386_latest.zip
mv cmdline-tools/ latest/
# May append following two lines to ~/.bash_profile and source it
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin
sudo apt update && sudo apt install openjdk-11-jdk
sdkmanager "platform-tools" "platforms;android-33"
sdkmanager --licenses
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
cd ~/localsend
cat > android/key.properties << EOF
storePassword=<storeFilePassword>
keyPassword=<storeFilePassword>
keyAlias=upload
storeFile=/home/user1/upload-keystore.jks
EOF
bash -i scripts/compile_android_apk.sh
# Compilation failed several times on my vps, just `cd /tmp/build` and 
# `submodules/flutter/bin/flutter build apk` and `while true; do !! && break; done`
