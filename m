From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Oct 2013 06:36:44 +0000
Subject: [PATCH 10/10] ARM: shmobile: marzen: add SDHI support on DTS
Message-Id: <877gdk1fgn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index ab4110a..f7578d5 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -68,7 +68,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif2_pins &scif4_pins &sdhi0_pins>;
+	pinctrl-0 = <&scif2_pins &scif4_pins>;
 	pinctrl-names = "default";
 
 	lan0_pins: lan0 {
@@ -98,3 +98,12 @@
 		renesas,function = "sdhi0";
 	};
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <4>;
+	status = "okay";
+};
-- 
1.7.9.5

