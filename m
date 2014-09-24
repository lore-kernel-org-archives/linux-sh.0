From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Sep 2014 20:04:30 +0000
Subject: [PATCH 10/12] video: Add ADV751[13] DT bindings documentation
Message-Id: <1411589072-28609-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org

The ADV7511, ADV7511W and ADV7513 are HDMI audio and video transmitters
compatible with HDMI 1.4 and DVI 1.0. They're described in DT using the
OF graph bindings and a list of custom properties pertaining to the
input video bus configuration.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/video/adi,adv7511.txt      | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/adi,adv7511.txt

diff --git a/Documentation/devicetree/bindings/video/adi,adv7511.txt b/Documentation/devicetree/bindings/video/adi,adv7511.txt
new file mode 100644
index 0000000..aa41d9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/adi,adv7511.txt
@@ -0,0 +1,87 @@
+Analog Device ADV7511(W)/13 HDMI Encoders
+-----------------------------------------
+
+The ADV7511, ADV7511W and ADV7513 are HDMI audio and video transmitters
+compatible with HDMI 1.4 and DVI 1.0. They support color space conversion,
+S/PDIF, CEC and HDCP.
+
+Required properties:
+
+- compatible: Should be one of "adi,adv7511", "adi,adv7511w" or "adi,adv7513"
+- reg: I2C slave address
+
+The ADV7511 supports a large number of input data formats that differ by their
+color depth, color format, clock mode, bit justification and random
+arrangement of components on the data bus. The combination of the following
+properties describe the input and map directly to the video input tables of the
+ADV7511 datasheet that document all the supported combinations.
+
+- adi,input-depth: Number of bits per color component at the input (8, 10 or
+  12).
+- adi,input-colorspace: The input color space, one of "rgb", "yuv422" or
+  "yuv444".
+- adi,input-clock: The input clock type, one of "1x" (one clock cycle per
+  pixel), "2x" (two clock cycles per pixel), "ddr" (one clock cycle per pixel,
+  data driven on both edges).
+
+The following input format properties are required except in "rgb 1x" and
+"yuv444 1x" modes, in which case they must not be specified.
+
+- adi,input-style: The input components arrangement variant (1, 2 or 3).
+- adi,input-justification: The input bit justification ("left", "evenly",
+  "right").
+
+Optional properties:
+
+- interrupts: Specifier for the ADV7511 interrupt
+- pd-gpios: Specifier for the GPIO connected to the power down signal
+
+- adi,clock-delay: Video data clock delay relative to the pixel clock, in ps
+  (-1200 ps .. 1600 ps). Defaults to no delay.
+- adi,embedded-sync: The input uses synchronization signals embedded in the
+  data stream (similar to BT.656). Defaults to separate H/V synchronization
+  signals.
+
+Required nodes:
+
+The ADV7511 has two video ports. Their connections are modeled using the OF
+graph bindings specified in Documentation/devicetree/bindings/graph.txt.
+
+- Video port 0 for the RGB or YUV input
+- Video port 1 for the HDMI output
+
+
+Example
+-------
+
+	adv7511w: hdmi@39 {
+		compatible = "adi,adv7511w";
+		reg = <39>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+
+		adi,input-depth = <8>;
+		adi,input-colorspace = "rgb";
+		adi,input-clock = "1x";
+		adi,input-style = <1>;
+		adi,input-justification = "evenly";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7511w_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7511_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
-- 
1.8.5.5

