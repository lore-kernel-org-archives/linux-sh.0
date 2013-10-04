From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Oct 2013 01:31:16 +0000
Subject: [PATCH 3/7] ARM: shmobile: bockw: add default PFC settings on DTS
Message-Id: <8738oh255q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCIF0 PFC setting is needed as default

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 969e386..3c1d1f0 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -55,3 +55,13 @@
 &irqpin {
 	status = "okay";
 };
+
+&pfc {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: scif0 {
+		renesas,groups = "scif0_data_a", "scif0_ctrl";
+		renesas,function = "scif0";
+	};
+};
-- 
1.7.9.5

