From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 13:16:21 +0000
Subject: [PATCH 6/6] ARM: shmobile: kzm9g-reference: add DMA channels to MMCIF and SDHI DT
Message-Id: <1374498981-5263-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

MMCIF and SDHI drivers can use DMA for data transfer, add suitable
Device Tree bindings.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index b99e890..e5b84d1c 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -191,6 +191,9 @@
 
 	bus-width = <8>;
 	vmmc-supply = <&reg_1p8v>;
+	dmas = <&dmac 0xd1
+		&dmac 0xd2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
@@ -237,6 +240,9 @@
 
 	vmmc-supply = <&vmmc_sdhi0>;
 	bus-width = <4>;
+	dmas = <&dmac 0xc1
+		&dmac 0xc2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
@@ -247,5 +253,8 @@
 	vmmc-supply = <&vmmc_sdhi2>;
 	bus-width = <4>;
 	broken-cd;
+	dmas = <&dmac 0xcd
+		&dmac 0xce>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
-- 
1.7.2.5

