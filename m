From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Oct 2013 10:33:05 +0000
Subject: [PATCH 01/05] ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
Message-Id: <20131001103305.813.70296.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001103255.813.65710.sendpatchset@w520>
In-Reply-To: <20131001103255.813.65710.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Copy the device nodes from KZM9D reference into the KZM9D
device tree file. This will allow us to use a single DTS
file regarless of kernel configuration. In case of legacy
C board code the device nodes may or may not be used, but
in the multiplatform case all the DT device nodes are used.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/emev2-kzm9d.dts |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/emev2-kzm9d.dts
+++ work/arch/arm/boot/dts/emev2-kzm9d.dts	2013-09-26 19:42:16.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for the KZM9D board
  *
- * Copyright (C) 2012 Renesas Solutions Corp.
+ * Copyright (C) 2013 Renesas Solutions Corp.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -23,4 +23,35 @@
 	chosen {
 		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
+
+	reg_1p8v: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_3p3v: regulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	lan9220@20000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x20000000 0x10000>;
+		phy-mode = "mii";
+		interrupt-parent = <&gpio0>;
+		interrupts = <1 1>;	/* active high */
+		reg-io-width = <4>;
+		smsc,irq-active-high;
+		smsc,irq-push-pull;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
 };
