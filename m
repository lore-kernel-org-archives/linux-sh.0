From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 11 Jan 2016 04:32:57 +0000
Subject: [PATCH 1/6] ARM: dts: bockw: Add compatible property to "partitions" node
Message-Id: <b66c1ebae17bf78eb915f1d22a82e1183b0deb8e.1452486598.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1452486598.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1452486598.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index b1aa02599229..a52b359e2ae2 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -199,6 +199,7 @@
 		m25p,fast-read;
 
 		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.7.0.rc3.207.g0ac5344

