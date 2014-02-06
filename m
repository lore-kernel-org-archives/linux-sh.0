From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 06 Feb 2014 20:56:19 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add Ether DT support
Message-Id: <201402070056.41569.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402070054.39989.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402070054.39989.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the generic R8A7790 part of the Ether device node. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7790.dtsi |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -1,7 +1,8 @@
 /*
  * Device Tree Source for the r8a7790 SoC
  *
- * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013-2014 Renesas Solutions Corp.
+ * Copyright (C) 2014 Cogent Embedded Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -400,6 +401,18 @@
 		status = "disabled";
 	};
 
+	ether: ethernet@ee700000 {
+		compatible = "renesas,ether-r8a7790";
+		reg = <0 0xee700000 0 0x400>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
+		phy-mode = "rmii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sata0: sata@ee300000 {
 		compatible = "renesas,sata-r8a7790";
 		reg = <0 0xee300000 0 0x2000>;
