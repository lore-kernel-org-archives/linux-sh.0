From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Mar 2014 04:44:29 +0000
Subject: [PATCH 1/7] ARM: shmobile: r8a7790: add Ether DT support
Message-Id: <d8913c6799ed776d096a7f41d83afce815f93819.1394080829.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1394080829.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7790 part of the Ether device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 6eb9613..e22520d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
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
@@ -379,6 +380,17 @@
 		status = "disabled";
 	};
 
+	ether: ethernet@ee700000 {
+		compatible = "renesas,ether-r8a7790";
+		reg = <0 0xee700000 0 0x400>;
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
-- 
1.8.5.2

