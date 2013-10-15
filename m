From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:45:28 +0000
Subject: [PATCH 09/17] ARM: shmobile: sh73a0: fixup DT node naming for SCIFA
Message-Id: <8761szdlkc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SCIFA DT node from "scifa" to "serial".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 2e28afd..4548bbb 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -197,7 +197,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scifa4_pins>;
+	pinctrl-0 = <&serial4_pins>;
 	pinctrl-names = "default";
 
 	i2c3_pins: i2c3 {
@@ -217,7 +217,7 @@
 		};
 	};
 
-	scifa4_pins: scifa4 {
+	serial4_pins: serial4 {
 		renesas,groups = "scifa4_data", "scifa4_ctrl";
 		renesas,function = "scifa4";
 	};
-- 
1.7.9.5

