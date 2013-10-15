From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:44:27 +0000
Subject: [PATCH 03/17] ARM: shmobile: r8a73a4: fixup DT node naming for SCIFA
Message-Id: <87eh7ndlm0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SCIFA DT node from "scifa" to "serial".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index a59f8f6..0430782 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -85,10 +85,10 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-0 = <&serial0_pins>;
 	pinctrl-names = "default";
 
-	scifa0_pins: scifa0 {
+	serial0_pins: serial0 {
 		renesas,groups = "scifa0_data";
 		renesas,function = "scifa0";
 	};
-- 
1.7.9.5

