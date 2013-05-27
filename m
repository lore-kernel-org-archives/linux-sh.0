From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 27 May 2013 08:59:51 +0000
Subject: [PATCH 6/7] ARM: shmobile: Remove unused r8a7790 GIC CPU interface DT bits
Message-Id: <1369645224-3728-7-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused GIC CPU interface DT bits for r8a7790.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7a17110..339d9b1 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -36,12 +36,6 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
-
-		gic-cpuif@4 {
-			compatible = "arm,gic-cpuif";
-			cpuif-id = <4>;
-			cpu = <&cpu0>;
-		};
 	};
 
 	timer {
-- 
1.7.10.4

