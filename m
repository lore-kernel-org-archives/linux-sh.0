From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 21 Dec 2015 10:33:51 +0000
Subject: [PATCH v2 7/9] ARM: shmobile: gose dts: Add compatible property to "partitions" node
Message-Id: <1450694033-27717-8-git-send-email-geert+renesas@glider.be>
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
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/r8a7793-gose.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 077ab9423f5e17d6..3d4bd3c02c4fece0 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -128,6 +128,7 @@
 		m25p,fast-read;
 
 		partitions {
+			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
1.9.1

