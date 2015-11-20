From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 01:05:13 +0000
Subject: [PATCH 06/29] ARM: shmobile: r8a7790: fix "gpio-ranges" props
Message-Id: <56a2182f6ada123759041bf28d066bb509fe358b.1447981420.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On R8A7790, GPIO banks 1 and 2 are missing  pins 30 and 31.  Correct the
"gpio-ranges" properties of the corresponding device nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ae5eb281d43a..b545fef3f7db 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -143,7 +143,7 @@
 		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		gpio-ranges = <&pfc 0 32 32>;
+		gpio-ranges = <&pfc 0 32 30>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
@@ -156,7 +156,7 @@
 		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		gpio-ranges = <&pfc 0 64 32>;
+		gpio-ranges = <&pfc 0 64 30>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
-- 
2.1.4

