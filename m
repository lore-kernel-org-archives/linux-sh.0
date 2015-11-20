From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 01:05:17 +0000
Subject: [PATCH 10/29] ARM: shmobile: porter: add CAN0 DT support
Message-Id: <0768fbad7fba1d2793cb4b57e30786e32d203948.1447981420.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Porter board dependent part of the CAN0 device node.

This patch is  analogous to the commit 457acc4a6ce8 ("ARM: shmobile:
henninger: add CAN0 DT support") as there are no differences between the
boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 9f9ffe322d17..3e198e7b3ee4 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -134,6 +134,11 @@
 		renesas,groups = "vin0_data8", "vin0_clk";
 		renesas,function = "vin0";
 	};
+
+	can0_pins: can0 {
+		renesas,groups = "can0_data";
+		renesas,function = "can0";
+	};
 };
 
 &scif0 {
@@ -288,3 +293,10 @@
 &pciec {
 	status = "okay";
 };
+
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.1.4

