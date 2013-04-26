From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Apr 2013 16:27:47 +0000
Subject: [PATCH 6/6] ARM: shmobile: armadillo800eva-reference: add DMA support for MMCIF and SDHI
Message-Id: <1366993667-23294-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add DMA bindings to SDHI and MMCIF DT nodes on armadillo800eva-reference.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 3752637..c201445 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -47,6 +47,9 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
 	non-removable;
+	dmas = <&dma0 0xd1
+		&dma0 0xd2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
@@ -54,11 +57,17 @@
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
 	broken-cd;
+	dmas = <&dma0 0xc1
+		&dma0 0xc2>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
 
 &sdhi1 {
 	vmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
+	dmas = <&dma0 0xc9
+		&dma0 0xca>;
+	dma-names = "tx", "rx";
 	status = "okay";
 };
-- 
1.7.2.5

