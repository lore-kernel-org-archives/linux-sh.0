From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Thu, 28 Dec 2017 14:01:13 +0000
Subject: [PATCH v2 1/9] dt-bindings: media: Add Renesas CEU bindings
Message-Id: <1514469681-15602-2-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1514469681-15602-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1514469681-15602-1-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, geert-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add bindings documentation for Renesas Capture Engine Unit (CEU).

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../devicetree/bindings/media/renesas,ceu.txt      | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,ceu.txt

diff --git a/Documentation/devicetree/bindings/media/renesas,ceu.txt b/Documentation/devicetree/bindings/media/renesas,ceu.txt
new file mode 100644
index 0000000..f45628e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/renesas,ceu.txt
@@ -0,0 +1,85 @@
+Renesas Capture Engine Unit (CEU)
+----------------------------------------------
+
+The Capture Engine Unit is the image capture interface found on Renesas
+RZ chip series and on SH Mobile ones.
+
+The interface supports a single parallel input with data bus width up to
+8/16 bits.
+
+Required properties:
+- compatible
+	Must be one of:
+	- "renesas,ceu"
+	- "renesas,r7s72100-ceu"
+- reg
+	Physical address base and size.
+- interrupts
+	The interrupt specifier.
+- pinctrl-names, pinctrl-0
+	phandle of pin controller sub-node configuring pins for CEU operations.
+- remote-endpoint
+	phandle to an 'endpoint' subnode of a remote device node.
+
+CEU supports a single parallel input and should contain a single 'port' subnode
+with a single 'endpoint'. Optional endpoint properties applicable to parallel
+input bus described in "video-interfaces.txt" supported by this driver are:
+
+- hsync-active
+	active state of the HSYNC signal, 0/1 for LOW/HIGH respectively.
+- vsync-active
+	active state of the VSYNC signal, 0/1 for LOW/HIGH respectively.
+
+Example:
+
+The example describes the connection between the Capture Engine Unit and an
+OV7670 image sensor sitting on bus i2c1.
+
+ceu: ceu@e8210000 {
+	reg = <0xe8210000 0x209c>;
+	compatible = "renesas,ceu";
+	interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&vio_pins>;
+
+	status = "okay";
+
+	port {
+		ceu_in: endpoint {
+			remote-endpoint = <&ov7670_out>;
+
+			hsync-active = <1>;
+			vsync-active = <0>;
+		};
+	};
+};
+
+i2c1: i2c@fcfee400 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	status = "okay";
+
+	clock-frequency = <100000>;
+
+	ov7670: camera@21 {
+		compatible = "ovti,ov7670";
+		reg = <0x21>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vio_pins>;
+
+		reset-gpios = <&port3 11 GPIO_ACTIVE_LOW>;
+		powerdown-gpios = <&port3 12 GPIO_ACTIVE_HIGH>;
+
+		port {
+			ov7670_out: endpoint {
+				remote-endpoint = <&ceu_in>;
+
+				hsync-active = <1>;
+				vsync-active = <0>;
+			};
+		};
+	};
+};
-- 
2.7.4

