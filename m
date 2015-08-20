From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 20 Aug 2015 15:45:55 +0000
Subject: [PATCH v2 2/3] ARM: shmobile: r8a7778: enable IRLM setup via DT
Message-Id: <1440085556-4340-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make use of the IRLM setup feature in the renesas-intc-irqpin driver.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4b1fa9f..4b0acae23 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -78,7 +78,8 @@
 			<0xfe780010 4>,
 			<0xfe780024 4>,
 			<0xfe780044 4>,
-			<0xfe780064 4>;
+			<0xfe780064 4>,
+			<0xfe780000 4>;
 		interrupts =   <0 27 IRQ_TYPE_LEVEL_HIGH
 				0 28 IRQ_TYPE_LEVEL_HIGH
 				0 29 IRQ_TYPE_LEVEL_HIGH
-- 
2.4.6

