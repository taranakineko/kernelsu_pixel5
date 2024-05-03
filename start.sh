echo 'Preparing packages'
sudo apt-get update -y
sudo apt-get install -y repo git
echo 'cloning itself'
git clone https://github.com/CZB666-wdnmd/kernelsu_redbull
mkdir android-kernel && cd android-kernel
echo 'pulling kernel source'
repo init -u https://android.googlesource.com/kernel/manifest -b android-msm-redbull-4.19-android13-qpr3
repo sync
cd private/msm-google
echo 'cloning kernelsu'
git clone https://github.com/tiann/KernelSU
echo 'patching files'
ln -sf "/home/runner/android-kernel/private/msm-google/KernelSU/kernel" "/home/runner/android-kernel/private/msm-google/drivers/kernelsu"
echo "obj-y += kernelsu/" >> /home/runner/android-kernel/private/msm-google/drivers/Makefile
cp /home/runner/kernelsu_redbull/ksu.c /home/runner/android-kernel/private/msm-google/KernelSU/kernel/ksu.c
cp /home/runner/kernelsu_redbull/open.c /home/runner/android-kernel/private/msm-google/fs/open.c
cp /home/runner/kernelsu_redbull/exec.c /home/runner/android-kernel/private/msm-google/fs/exec.c
cp /home/runner/kernelsu_redbull/read_write.c /home/runner/android-kernel/private/msm-google/fs/read_write.c
cp /home/runner/kernelsu_redbull/stat.c /home/runner/android-kernel/private/msm-google/fs/stat.c
cp /home/runner/kernelsu_redbull/input.c /home/runner/android-kernel/private/msm-google/drivers/input/input.c
cd /home/runner/android-kernel
./build_redbull-gki.sh
