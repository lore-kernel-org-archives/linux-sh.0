From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Feb 2015 04:27:07 +0000
Subject: [PATCH 3/3 v2][RFC] ARM: shmobile: r8a7790: enables Audio DMAC peri peri entry on DTSI
Message-Id: <87iofley3p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change

 arch/arm/boot/dts/r8a7790.dtsi |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9f05f19..a501867 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1464,7 +1464,15 @@
 				<&audma0 0x91>,	<&audma1 0xb4>,
 				<&audma0 0x93>,	<&audma1 0xb6>,
 				<&audma0 0x95>,	<&audma1 0xb8>,
-				<&audma0 0x97>,	<&audma1 0xba>;
+				<&audma0 0x97>,	<&audma1 0xba>,
+
+				<&audmapp 0>,	<&audmapp 1>,	<&audmapp 2>,	<&audmapp 3>,	<&audmapp 4>,
+				<&audmapp 5>,	<&audmapp 6>,	<&audmapp 7>,	<&audmapp 8>,	<&audmapp 9>,
+
+				<&audmapp 10>,	<&audmapp 11>,	<&audmapp 12>,	<&audmapp 13>,	<&audmapp 14>,
+				<&audmapp 15>,	<&audmapp 16>,	<&audmapp 17>,	<&audmapp 18>,	<&audmapp 19>,
+
+				<&audmapp 20>,	<&audmapp 21>;
 
 		dma-names =	"mem_ssi0",	"ssi0_mem",	"mem_ssiu0",	"ssiu0_mem",
 				"mem_ssi1",	"ssi1_mem",	"mem_ssiu1",	"ssiu1_mem",
@@ -1486,7 +1494,15 @@
 				"mem_src6",	"src6_mem",
 				"mem_src7",	"src7_mem",
 				"mem_src8",	"src8_mem",
-				"mem_src9",	"src9_mem";
+				"mem_src9",	"src9_mem",
+
+				"src0",		"src1",		"src2",		"src3",		"src4",
+				"src5",		"src6",		"src7",		"src8",		"src9",
+
+				"ssiu0",	"ssiu1",	"ssiu2",	"ssiu3",	"ssiu4",
+				"ssiu5",	"ssiu6",	"ssiu7",	"ssiu8",	"ssiu9",
+
+				"dvc0",		"dvc1";
 
 		status = "disabled";
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
