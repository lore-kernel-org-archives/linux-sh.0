From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 07 Oct 2013 04:26:40 +0000
Subject: [PATCH 1/2] ARM: shmobile: lager: add default PFC settings on DTS
Message-Id: <87eh7xbtaa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCIF0/SCIF1 PFC setting is needed as default

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index c462ef1..0a3f0c6 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -43,3 +43,18 @@
 		};
 	};
 };
+
+&pfc {
+	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: scif0 {
+		renesas,groups = "scif0_data";
+		renesas,function = "scif0";
+	};
+
+	scif1_pins: scif1 {
+		renesas,groups = "scif1_data";
+		renesas,function = "scif1";
+	};
+};
-- 
1.7.9.5

