From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 03:27:59 +0000
Subject: [PATCH] ARM: shmobile: r8a7794: alt: Enable PFC DU for the VGA port
Message-Id: <20151117032759.27590.11692.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Tie in r8a7794 PFC DU support to the VGA port on the
r8a7794 ALT board.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of "renesas-devel-20151113-v4.3" with
 "[PATCH v2 00/03] ARM: shmobile: r8a7794 ALT board DU VGA port enablement V2"

 No other build time dependencies.

 Run time dependency exists on
 "[PATCH 00/04] pinctrl: sh-pfc: r8a7794: DU support"

 arch/arm/boot/dts/r8a7794-alt.dts |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0012/arch/arm/boot/dts/r8a7794-alt.dts
+++ work/arch/arm/boot/dts/r8a7794-alt.dts	2015-11-16 22:18:40.880513000 +0900
@@ -80,6 +80,8 @@
 };
 
 &du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
@@ -100,6 +102,13 @@
 	clock-frequency = <20000000>;
 };
 
+&pfc {
+	du_pins: du {
+		renesas,groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_dotclkout0";
+		renesas,function = "du";
+	};
+};
+
 &cmt0 {
 	status = "okay";
 };
