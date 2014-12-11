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

