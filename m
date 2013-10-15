From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:46:29 +0000
Subject: [PATCH 16/17] ARM: shmobile: r8a7790: fixup DT node naming for SDHI
Message-Id: <87vc0zc6y5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to ePAPR spec,
this patch exchanges SDHI DT node from "sdhi" to "sd".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ee845fa..72542ee 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -239,7 +239,7 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
-	sdhi0: sdhi@ee100000 {
+	sd0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -248,7 +248,7 @@
 		status = "disabled";
 	};
 
-	sdhi1: sdhi@ee120000 {
+	sd1: sd@ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -257,7 +257,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@ee140000 {
+	sd2: sd@ee140000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
@@ -266,7 +266,7 @@
 		status = "disabled";
 	};
 
-	sdhi3: sdhi@ee160000 {
+	sd3: sd@ee160000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.9.5

