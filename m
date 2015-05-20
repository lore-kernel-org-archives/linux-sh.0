From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 May 2015 18:16:53 +0000
Subject: [PATCH 4/5] ARM: shmobile: henninger dts: Replace "nor-jedec" by "jedec,spi-nor"
Message-Id: <1432145814-12442-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432145814-12442-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Cfr. commit 8947e396a8296c52 ('Documentation: dt: mtd: replace
"nor-jedec" binding with "jedec, spi-nor"')

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index bb80122b4113bd8a..655d1804e5e9ceda 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -226,7 +226,7 @@
 	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,s25fl512s", "nor-jedec";
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <30000000>;
 		spi-tx-bus-width = <4>;
-- 
1.9.1

