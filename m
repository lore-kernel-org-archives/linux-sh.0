From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 20 Aug 2015 15:45:56 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: bockw dts: enable SMSC interrupt
Message-Id: <1440085556-4340-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437751317-12235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437751317-12235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Clears bit 4 in IRQMR0 in the FPGA to enable the SMSC interrupt.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 8a54076..73ba7de 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -65,6 +65,23 @@
 };
 
 &bsc {
+	fpga@18200000 {
+		/* Simplified description that only serves to enable the
+		 * ethernet controller.
+		 */
+		compatible = "pinctrl-single";
+		reg = <0x18200030 2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,bit-per-mux;
+		pinctrl-single,register-width = <16>;
+		pinctrl-single,function-mask = <1>;
+
+		irq_pins: fpga_irq_pins {
+			pinctrl-single,bits = <0 0 0x10>;
+		};
+	};
+
 	ethernet@18300000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18300000 0x1000>;
@@ -75,6 +92,9 @@
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
+
+		pinctrl-0 = <&irq_pins>;
+		pinctrl-names = "default";
 	};
 };
 
-- 
2.4.6

