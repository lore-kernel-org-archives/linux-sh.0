From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 17:35:58 +0000
Subject: [PATCH 2/4] ARM: shmobile: koelsch dts: Enable Quad SPI transfers for the SPI FLASH
Message-Id: <1397496960-27848-3-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index a9149a703601..ad34a5dbc20d 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -354,6 +354,8 @@
 		compatible = "spansion,s25fl512s";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 		m25p,fast-read;
 
 		partition@0 {
-- 
1.7.9.5

