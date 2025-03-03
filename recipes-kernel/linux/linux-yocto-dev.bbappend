# do not override KBRANCH and SRCREV_machine, use default ones.
COMPATIBLE_MACHINE:qcom = "(qcom)"

FILESEXTRAPATHS:prepend:qcom := "${THISDIR}/${PN}:"

SRC_URI:append:qcom = " \
    file://qcm6490-board-dts/0001-FROMLIST-arm64-dts-qcom-qcm6490-idp-Update-protected.patch \
    file://qcm6490-board-dts/0001-dt-bindings-PCI-Add-binding-for-qps615.patch \
    file://qcm6490-board-dts/0002-arm64-dts-qcom-qcs6490-rb3gen2-Add-node-for-qps615.patch \
    file://qcm6490-board-dts/0001-arm64-dts-qcom-qcs6490-rb3gen2-Plumb-the-QPS615-and-.patch \
    file://qcm6490-board-dts/0001-dt-bindings-clock-qcom-Add-compatible-for.patch \
    file://qcm6490-board-dts/0003-arm64-dts-qcom-qcm6490-idp-Update-the-LPASS.patch \
    file://qcm6490-board-dts/0004-arm64-dts-qcom-qcs6490-rb3gen2-Update-the-LPASS-audi.patch \
    file://qcm6490-board-dts/0001-dt-bindings-PCI-qcom-pcie-sc7280-Add-global-interrup.patch \
    file://qcm6490-board-dts/0001-arm64-dts-qcom-sc7280-Add-global-interrupt-to-the-PC.patch \
    file://workarounds/0001-QCLINUX-arm64-dts-qcom-qcm6490-disable-sdhc1-for-ufs.patch \
    file://workarounds/0001-PENDING-arm64-dts-qcom-Remove-voltage-vote-support-f.patch \
    file://workarounds/0003-PCI-Add-new-start_link-stop_link-function-ops.patch \
    file://workarounds/0004-PCI-dwc-Add-support-for-new-pci-function-op.patch \
    file://workarounds/0005-PCI-qcom-Add-support-for-host_stop_link-host_start_l.patch \
    file://workarounds/0006-PCI-pwrctl-Add-power-control-driver-for-qps615.patch \
    file://workarounds/0002-clk-qcom-lpassaudiocc-sc7280-Add-support-for-LPASS-r.patch \
"

# Include additional kernel configs.
SRC_URI:append:qcom = " \
    file://configs/qcom.cfg \
"

# When a defconfig is provided, the linux-yocto configuration
# uses the filename as a trigger to use a 'allnoconfig' baseline
# before merging the defconfig into the build.
#
# If the defconfig file was created with make_savedefconfig,
# not all options are specified, and should be restored with their
# defaults, not set to 'n'. To properly expand a defconfig like
# this, specify: KCONFIG_MODE="--alldefconfig" in the kernel
# recipe.
KCONFIG_MODE:qcom = "--alldefconfig"

KBUILD_DEFCONFIG:qcom ?= "defconfig"

do_install:append:qcom() {
	sed -i 's:${TMPDIR}::g' ${WORKDIR}/linux-${PACKAGE_ARCH}-${LINUX_KERNEL_TYPE}-build/drivers/gpu/drm/msm/generated/*
}
