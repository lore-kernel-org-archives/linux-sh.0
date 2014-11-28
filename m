From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Date: Fri, 28 Nov 2014 01:26:29 +0000
Subject: [PATCH v2 3/7] pinctrl: zynq: Document DT binding
Message-Id: <1417137993-8337-4-git-send-email-soren.brinkmann@xilinx.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Add documentation for the devicetree binding for the Zynq pincontroller.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
Changes since v1:
 - fix typo
 - add USB related documentation
 - remove 'pinctrl-' prefix for pinctrl sub-nodes
 - update documentation to enforce strict separation of pinmux
   and pinconf nodes
   - update example accordingly
---
 .../bindings/pinctrl/xlnx,zynq-pinctrl.txt         | 104 +++++++++++++++++=
++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pin=
ctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.tx=
t b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.txt
new file mode 100644
index 000000000000..b7b55a964f65
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.txt
@@ -0,0 +1,104 @@
+	Binding for Xilinx Zynq Pinctrl
+
+Required properties:
+- compatible: "xlnx,zynq-pinctrl"
+- syscon: phandle to SLCR
+- reg: Offset and length of pinctrl space in SLCR
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of t=
he
+phrase "pin configuration node".
+
+Zynq's pin configuration nodes act as a container for an arbitrary number =
of
+subnodes. Each of these subnodes represents some desired configuration for=
 a
+pin, a group, or a list of pins or groups. This configuration can include =
the
+mux function to select on those pin(s)/group(s), and various pin configura=
tion
+parameters, such as pull-up, slew rate, etc.
+
+Each configuration node can consist of multiple nodes describing the pinmu=
x and
+pinconf options. Those nodes can be pinmux nodes or pinconf nodes.
+
+The name of each subnode is not important; all subnodes should be enumerat=
ed
+and processed purely based on their content.
+
+Required properties for pinmux nodes are:
+ - groups: A list of pinmux groups.
+ - function: The name of a pinmux function to activate for the specified s=
et
+   of groups.
+
+Required properties for configuration nodes:
+One of:
+ - pins: a list of pin names
+ - groups: A list of pinmux groups.
+
+The following generic properties as defined in pinctrl-bindings.txt are va=
lid
+to specify in a pinmux subnode:
+ groups, function
+
+The following generic properties as defined in pinctrl-bindings.txt are va=
lid
+to specify in a pinconf subnode:
+ groups, pins, bias-disable, bias-high-impedance, bias-pull-up, slew-rate,
+ low-power-disable, low-power-enable
+
+ Valid arguments for 'slew-rate' are '0' and '1' to select between slow an=
d fast
+ respectively.
+
+ Valid values for groups are:
+   ethernet0_0_grp, ethernet1_0_grp, mdio0_0_grp, mdio1_0_grp,
+   qspi0_0_grp, qspi1_0_grp, qspi_fbclk, qspi_cs1_grp, spi0_0_grp,
+   spi0_1_grp - spi0_2_grp, spi1_0_grp - spi1_3_grp, sdio0_0_grp - sdio0_2=
_grp,
+   sdio1_0_grp - sdio1_3_grp, sdio0_emio_wp, sdio0_emio_cd, sdio1_emio_wp,
+   sdio1_emio_cd, smc0_nor, smc0_nor_cs1_grp, smc0_nor_addr25_grp, smc0_na=
nd,
+   can0_0_grp - can0_10_grp, can1_0_grp - can1_11_grp, uart0_0_grp - uart0=
_10_grp,
+   uart1_0_grp - uart1_11_grp, i2c0_0_grp - i2c0_10_grp, i2c1_0_grp - i2c1=
_10_grp,
+   ttc0_0_grp - ttc0_2_grp, ttc1_0_grp - ttc1_2_grp, swdt0_0_grp - swdt0_4=
_grp,
+   gpio0_0_grp - gpio0_53_grp, usb0_0_grp, usb1_0_grp
+
+ Valid values for pins are:
+   MIO0 - MIO53
+
+ Valid values for function are:
+   ethernet0, ethernet1, mdio0, mdio1, qspi0, qspi1, qspi_fbclk, qspi_cs1,
+   spi0, spi1, sdio0, sdio0_pc, sdio0_cd, sdio0_wp,
+   sdio1, sdio1_pc, sdio1_cd, sdio1_wp,
+   smc0_nor, smc0_nor_cs1, smc0_nor_addr25, smc0_nand, can0, can1, uart0, =
uart1,
+   i2c0, i2c1, ttc0, ttc1, swdt0, gpio0, usb0, usb1
+
+The following driver-specific properties as defined here are valid to spec=
ify in
+a pin configuration subnode:
+ - io-standard: Configure the pin to use the selected IO standard accordin=
g to
+   this mapping:
+    1: LVCMOS18
+    2: LVCMOS25
+    3: LVCMOS33
+    4: HSTL
+
+Example:
+	pinctrl0: pinctrl@700 {
+		compatible =3D "xlnx,pinctrl-zynq";
+		reg =3D <0x700 0x200>;
+		syscon =3D <&slcr>;
+
+		pinctrl_uart1_default: uart1-default {
+			mux {
+				groups =3D "uart1_10_grp";
+				function =3D "uart1";
+			};
+
+			conf {
+				groups =3D "uart1_10_grp";
+				slew-rate =3D <0>;
+				io-standard =3D <1>;
+			};
+
+			conf-rx {
+				pins =3D "MIO49";
+				bias-high-impedance;
+			};
+
+			conf-tx {
+				pins =3D "MIO48";
+				bias-disable;
+			};
+		};
+	};
--=20
2.1.3.1.ge241007

