From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 13:16:19 +0000
Subject: [PATCH 4/6] ARM: shmobile: armadillo800eva-reference: add DMA to SDHI and MMCIF
Message-Id: <1374498981-5263-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DMA bindings to SDHI and MMCIF DT nodes on armadillo800eva-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 1acf1bd..146a855 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -105,6 +105,9 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
 	non-removable;
+	dmas = <&dmac 0xd1
+		&dmac 0xd2>;
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	status = "okay";
@@ -116,6 +119,9 @@
 	cap-power-off-card;
 	bus-width = <4>;
 	cd-gpios = <&pfc 167 GPIO_ACTIVE_LOW>;
+	dmas = <&dmac 0xc1
+		&dmac 0xc2>;
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdhi0_pins>;
 	status = "okay";
@@ -126,6 +132,9 @@
 	cap-power-off-card;
 	bus-width = <4>;
 	cd-gpios = <&pfc 72 GPIO_ACTIVE_LOW>;
+	dmas = <&dmac 0xc9
+		&dmac 0xca>;
+	dma-names = "tx", "rx";
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdhi1_pins>;
 	status = "okay";
-- 
1.7.2.5

