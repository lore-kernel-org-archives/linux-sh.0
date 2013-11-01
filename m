From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Nov 2013 01:22:53 +0000
Subject: [PATCH 3/3] ARM: shmobile: bockw: enable HSPI0 on DTS
Message-Id: <87y558ykyd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 9c8bd37..f488c48 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -86,6 +86,11 @@
 				  "sdhi0_cd", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
+
+	hspi0_pins: hspi0 {
+		renesas,groups = "hspi0_a";
+		renesas,function = "hspi0";
+	};
 };
 
 &sdhi0 {
@@ -96,3 +101,9 @@
 	bus-width = <4>;
 	status = "okay";
 };
+
+&hspi0 {
+	pinctrl-0 = <&hspi0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.7.9.5

