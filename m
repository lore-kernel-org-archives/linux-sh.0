From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 08:10:11 +0000
Subject: [PATCH 06/08] ARM: shmobile: Update CMT compat string users in DTS
Message-Id: <20150621081011.10187.94046.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
In-Reply-To: <20150621080903.10187.20998.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org

From: Magnus Damm <damm+renesas@opensource.se>

Use recently updated r8a73a4 and R-Car Gen2 CMT0 and CMT1 compat strings.

With this change in place we can keep device-specific configuration in
the driver and the driver can be able to support CMT1 specific features.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a73a4.dtsi |    2 +-
 arch/arm/boot/dts/r8a7790.dtsi |    4 ++--
 arch/arm/boot/dts/r8a7791.dtsi |    4 ++--
 arch/arm/boot/dts/r8a7793.dtsi |    4 ++--
 arch/arm/boot/dts/r8a7794.dtsi |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

--- 0001/arch/arm/boot/dts/r8a73a4.dtsi
+++ work/arch/arm/boot/dts/r8a73a4.dtsi	2015-06-20 14:46:07.442366518 +0900
@@ -114,7 +114,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a73a4", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a73a4", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A73A4_CLK_CMT1>;
--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-06-20 14:47:48.652366518 +0900
@@ -212,7 +212,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-r8a7790", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7790", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -225,7 +225,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a7790", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7790", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-06-20 14:47:28.652366518 +0900
@@ -193,7 +193,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7791", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -206,7 +206,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7791", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
--- 0001/arch/arm/boot/dts/r8a7793.dtsi
+++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-06-20 14:46:58.642366518 +0900
@@ -62,7 +62,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-r8a7793", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7793", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -75,7 +75,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-r8a7793", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7793", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
--- 0001/arch/arm/boot/dts/r8a7794.dtsi
+++ work/arch/arm/boot/dts/r8a7794.dtsi	2015-06-20 14:47:17.122366518 +0900
@@ -51,7 +51,7 @@
 	};
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7794", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -64,7 +64,7 @@
 	};
 
 	cmt1: timer@e6130000 {
-		compatible = "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt1-r8a7794", "renesas,cmt1-rcar-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
 		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
