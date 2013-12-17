From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Dec 2013 05:03:24 +0000
Subject: [PATCH 04/04 v2] ARM: shmobile: Genmai I2C-over-GPIO support
Message-Id: <20131217050324.727.61701.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131217050232.727.9552.sendpatchset@w520>
In-Reply-To: <20131217050232.727.9552.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for the Genmai I2C bus hooked up to P1_5 and P1_4 using
the i2c-gpio driver. On the bus sits a 24c128 EEPRROM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Use compatible string "renesas,12c128" and set pagesize, thanks Wolfram!
 - Use "flash@50", thanks Sergei!

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- 0011/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ work/arch/arm/boot/dts/r7s72100-genmai-reference.dts	2013-12-16 20:08:48.000000000 +0900
@@ -39,6 +39,24 @@
 			gpios = <&port4 11 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	i2c@0 {
+		compatible = "i2c-gpio";
+		gpios = <&port1 5 GPIO_ACTIVE_HIGH /* sda */
+			 &port1 4 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,sda-open-drain;
+		i2c-gpio,scl-open-drain;
+		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@50 {
+			compatible = "renesas,24c128";
+			reg = <0x50>;
+			pagesize = <64>;
+		};
+	};
 };
 
 &pfc {
