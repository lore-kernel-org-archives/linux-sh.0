From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 21 Dec 2015 10:33:46 +0000
Subject: [PATCH v2 2/9] ARM: mvebu: kirkwood: Add compatible property to "partitions" node
Message-Id: <1450694033-27717-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
property to "partitions" node"), the "partitions" subnode of an SPI
FLASH device node must have a compatible property. The partitions are no
longer detected if it is not present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
index 1db6f2c506cce320..8082d64266a37c33 100644
--- a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
+++ b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
@@ -131,6 +131,7 @@
 	chip-delay = <40>;
 	status = "okay";
 	partitions {
+		compatible = "fixed-partitions";
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-- 
1.9.1

