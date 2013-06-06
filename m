From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:48:24 +0000
Subject: [PATCH v2 6/6] ARM: shmobile: armadillo800eva-reference: add DMA support for MMCIF and SDHI
Message-Id: <1370533704-23734-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1366194847-9879-6-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1366194847-9879-6-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DMA bindings to SDHI and MMCIF DT nodes on armadillo800eva-reference.
Since SDHI and MMCIF devices can use any of the 3 DMAC instances on
r8a7740, we point to the DMA multiplexer node instead of a specific DMAC
DT node.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 3752637..1983d49 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -47,6 +47,9 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
 	non-removable;
+	dmas = <&dmac 0xd1
+		&dmac 0xd2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
@@ -54,11 +57,17 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
 	broken-cd;
+	dmas = <&dmac 0xc1
+		&dmac 0xc2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
 &sdhi1 {
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
+	dmas = <&dmac 0xc9
+		&dmac 0xca>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
-- 
1.7.2.5

