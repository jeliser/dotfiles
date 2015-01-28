adbc() {
  adb connect $@
  sleep 1
  adb root
  sleep 1
  adb connect $@
}

adbd() {
  adb disconnect
}

# Make this a bit more generic and better error handling
dexClass() {
  ${ANDROID_DX_DIR}/dexdump classes.dex | grep 'Class descriptor' | grep "$1"
}

