From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Nov 2015 04:26:20 +0000
Subject: [PATCH] ARM: shmobile: r8a7793: remove deprecated #gpio-range-cells
Message-Id: <1448511980-12173-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
declares the above property deprecated. That was more than 2 years ago.
Remove it, so it doesn't get copied around needlessly.

Based on similar work for the r8a7791 and r8a7794 by Wolfram Sang.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
* Lightly tested on renesas-devel-20151126-v4.4-rc2
---
 arch/arm/boot/dts/r8a7793.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index cbcda80f4658..4c74a9229e71 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -233,7 +233,6 @@
 	pfc: pfc@e6060000 {
 		compatible = "renesas,pfc-r8a7793";
 		reg = <0 0xe6060000 0 0x250>;
-		#gpio-range-cells = <3>;
 	};
 
 	dmac0: dma-controller@e6700000 {
-- 
2.1.4

