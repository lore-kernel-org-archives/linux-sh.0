From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Nov 2015 01:55:48 +0000
Subject: [PATCH 05/15] ARM: shmobile: r8a7791: remove deprecated #gpio-range-cells from dtsi
Message-Id: <d3b2385577317d8b51fc3b3b75106dd2de7e7439.1448586938.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1448586938.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1448586938.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
declares the above property deprecated. That was more than 2 years ago.
Remove it, so it doesn't get copied around needlessly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3776974e3273..12b2b0f95806 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -509,7 +509,6 @@
 	pfc: pfc@e6060000 {
 		compatible = "renesas,pfc-r8a7791";
 		reg = <0 0xe6060000 0 0x250>;
-		#gpio-range-cells = <3>;
 	};
 
 	mmcif0: mmc@ee200000 {
-- 
2.1.4

