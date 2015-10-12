From: ahaslam@baylibre.com
Date: Mon, 12 Oct 2015 17:41:09 +0000
Subject: [RFC/RFT 1/6] ARM: shmobile: r8a7790: configure arch timer at boot
Message-Id: <1444671674-19275-2-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam@baylibre.com>

it seems that the A7 arch timer is incorrectly configured and gives
wrong random timestamps at boot. This can be seen by enabling kernel
timestamps for dmesg. By adding the cpu-registers-not-fw-configured
property on the device tree for the arch timer, only the physical arch
timer is used and configured giving coherent timestamps for all cpu's.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a0b2a79..91b0eb0 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -212,6 +212,7 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
+		arm,cpu-registers-not-fw-configured;
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <1 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <1 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.4.5

