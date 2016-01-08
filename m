From: "=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>
Date: Fri, 08 Jan 2016 08:23:06 +0000
Subject: [RFC 4/4] enable ipmmu for devcies connected to ipmmu_ds
Message-Id: <1452241386-22830-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This commits shows how I test DMAC+IPMMU.
---
 arch/arm/boot/dts/r8a7790.dtsi      | 2 +-
 arch/arm/configs/shmobile_defconfig | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 23af349..c2402f2 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1818,7 +1818,7 @@
 		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
-		status = "disabled";
+		status = "okay";
 	};
 
 	ipmmu_mp: mmu@ec680000 {
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3aef019..e9a1194 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -21,6 +21,7 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
+CONFIG_ARM_LPAE=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
@@ -180,7 +181,7 @@ CONFIG_RTC_DRV_RX8581=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_RCAR_DMAC=y
-# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IPMMU_VMSA=y
 CONFIG_IIO=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
-- 
2.6.4

