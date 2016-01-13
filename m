From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 13 Jan 2016 14:29:27 +0000
Subject: [PATCH 1/3] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <1452695369-29413-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

These bindings allow an I2C bus to switch between multiple masters. This
is not hot-switching because connected I2C slaves will be
re-instantiated. It is meant to select the best I2C core at runtime once
the task is known. Example: Prefer i2c-gpio over another I2C core
because of HW errata affecting your use case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../ABI/testing/sysfs-platform-i2c-demux-pinctrl   |  23 ++++
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  | 136 +++++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt

diff --git a/Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl b/Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
new file mode 100644
index 00000000000000..7ac7d7262bb718
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-i2c-demux-pinctrl
@@ -0,0 +1,23 @@
+What:		/sys/devices/platform/<i2c-demux-name>/cur_master
+Date:		January 2016
+KernelVersion:	4.6
+Contact:	Wolfram Sang <wsa@the-dreams.de>
+Description:
+
+This file selects the active I2C master for a demultiplexed bus.
+
+Write 0 there for the first master, 1 for the second etc. Reading the file will
+give you a list with the active master marked. Example from a Renesas Lager
+board:
+
+root@Lager:~# cat /sys/devices/platform/i2c@8/cur_master
+* 0 - /i2c@9
+  1 - /i2c@e6520000
+  2 - /i2c@e6530000
+
+root@Lager:~# echo 2 > /sys/devices/platform/i2c@8/cur_master
+
+root@Lager:~# cat /sys/devices/platform/i2c@8/cur_master
+  0 - /i2c@9
+  1 - /i2c@e6520000
+* 2 - /i2c@e6530000
diff --git a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
new file mode 100644
index 00000000000000..6c8aace7d78e64
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
@@ -0,0 +1,136 @@
+Pinctrl-based I2C Bus DeMux
+
+This binding describes an I2C bus demultiplexer that uses pin multiplexing to
+route the I2C signals, and represents the pin multiplexing configuration using
+the pinctrl device tree bindings. This may be used to select one I2C IP core at
+runtime which may have a better feature set for a given task than another I2C
+IP core on the SoC. The most simple example is to fall back to GPIO bitbanging
+if your current runtime configuration hits an errata of the internal IP core.
+
+    +-------------------------------+
+    | SoC                           |
+    |                               |   +-----+  +-----+
+    |   +------------+              |   | dev |  | dev |
+    |   |I2C IP Core1|--\           |   +-----+  +-----+
+    |   +------------+   \-------+  |      |        |
+    |                    |Pinctrl|--|------+--------+
+    |   +------------+   +-------+  |
+    |   |I2C IP Core2|--/           |
+    |   +------------+              |
+    |                               |
+    +-------------------------------+
+
+Required properties:
+- compatible: "i2c-demux-pinctrl"
+- i2c-parent: List of phandles of I2C masters available for selection. The first
+	      one will be used as default.
+- i2c-bus-name: The name of this bus. Also needed as pinctrl-name for the I2C
+		parents.
+
+Furthermore, I2C mux properties and child nodes. See mux.txt in this directory.
+
+Example:
+
+Here is a snipplet for a bus to be demuxed. It contains various i2c clients for
+HDMI, so the bus is named "i2c-hdmi":
+
+	i2chdmi: i2c@8 {
+
+		compatible = "i2c-demux-pinctrl";
+		i2c-parent = <&gpioi2c>, <&iic2>, <&i2c2>;
+		i2c-bus-name = "i2c-hdmi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ak4643: sound-codec@12 {
+			compatible = "asahi-kasei,ak4643";
+
+			#sound-dai-cells = <0>;
+			reg = <0x12>;
+		};
+
+		composite-in@20 {
+			compatible = "adi,adv7180";
+			reg = <0x20>;
+			remote = <&vin1>;
+
+			port {
+				adv7180: endpoint {
+					bus-width = <8>;
+					remote-endpoint = <&vin1ep0>;
+				};
+			};
+		};
+
+		hdmi@39 {
+			compatible = "adi,adv7511w";
+			reg = <0x39>;
+			interrupt-parent = <&gpio1>;
+			interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+
+			adi,input-depth = <8>;
+			adi,input-colorspace = "rgb";
+			adi,input-clock = "1x";
+			adi,input-style = <1>;
+			adi,input-justification = "evenly";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					adv7511_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					adv7511_out: endpoint {
+						remote-endpoint = <&hdmi_con>;
+					};
+				};
+			};
+		};
+	};
+
+And for clarification, here are the snipplets for the i2c-parents:
+
+	gpioi2c: i2c@9 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		status = "disabled";
+		gpios = <&gpio5 6 GPIO_ACTIVE_HIGH /* sda */
+			 &gpio5 5 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+...
+
+&i2c2	{
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "i2c-hdmi";
+
+	clock-frequency = <100000>;
+};
+
+...
+
+&iic2	{
+	pinctrl-0 = <&iic2_pins>;
+	pinctrl-names = "i2c-hdmi";
+
+	clock-frequency = <100000>;
+};
+
+Please note:
+
+- pinctrl properties for the parent I2C controllers need a pinctrl state
+  with the same name as i2c-bus-name, not "default"!
+
+- the i2c masters must have their status "disabled". This driver will
+  enable them at runtime when needed.
+
-- 
2.1.4

