From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 24 Apr 2014 22:44:12 +0000
Subject: [PATCH 2/2] ARM: shmobile: henninger: add Ether DT support
Message-Id: <201404250244.13232.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the Henninger board dependent part of the Ether device node.
Enable DHCP and NFS root for the kernel booting.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791-henninger.dts |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -21,7 +21,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,38400 ignore_loglevel";
+		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
 
 	memory@40000000 {
@@ -40,6 +40,16 @@
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
 	};
+
+	ether_pins: ether {
+		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
+		renesas,function = "eth";
+	};
+
+	phy1_pins: phy1 {
+		renesas,groups = "intc_irq0";
+		renesas,function = "intc";
+	};
 };
 
 &scif0 {
@@ -48,3 +58,19 @@
 
 	status = "okay";
 };
+
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
+		micrel,led-mode = <1>;
+	};
+};
