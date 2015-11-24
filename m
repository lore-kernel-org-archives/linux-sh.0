From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 24 Nov 2015 21:32:23 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7794: remove deprecated #gpio-range-cells from dtsi
Message-Id: <1448400743-18104-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
declares the above property deprecated. That was more than 2 years ago.
Remove it, so it doesn't get copied around needlessly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7794.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 018ff56470b6da..5246a1978f24b7 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -217,7 +217,6 @@
 	pfc: pin-controller@e6060000 {
 		compatible = "renesas,pfc-r8a7794";
 		reg = <0 0xe6060000 0 0x11c>;
-		#gpio-range-cells = <3>;
 	};
 
 	dmac0: dma-controller@e6700000 {
-- 
2.1.4

