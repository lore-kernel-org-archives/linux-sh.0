From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Mar 2014 04:44:32 +0000
Subject: [PATCH 4/7] ARM: shmobile: koelsch: add Ether DT support
Message-Id: <08e8f0f35522bad37556a80c6df0578374f5091c.1394080829.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1394080829.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Koelsch board dependent part of the Ether device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index bf6ba0c..603af8c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -2,7 +2,8 @@
  * Device Tree Source for the Koelsch board
  *
  * Copyright (C) 2013 Renesas Electronics Corporation
- * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013-2014 Renesas Solutions Corp.
+ * Copyright (C) 2014 Cogent Embedded, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -146,12 +147,37 @@
 		renesas,function = "scif1";
 	};
 
+	ether_pins: ether {
+		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
+		renesas,function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		renesas,groups = "intc_irq0";
+		renesas,function = "intc";
+	};
+
 	qspi_pins: spi {
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
 };
 
+&ether {
+	pinctrl-0 = <&ether_pins &phy1_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "ok";
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &sata0 {
 	status = "okay";
 };
-- 
1.8.5.2

