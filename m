From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Feb 2015 14:47:50 +0000
Subject: [RFC 1/5] ARM: shmobile: r8a7790: add mstp4 and rwdt clock
Message-Id: <1422802074-1921-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 10 ++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 56847bf09c3b..999d437496de 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1126,6 +1126,16 @@
 				"iic0", "pciec", "iic1", "ssusb", "cmt1",
 				"usbdmac0", "usbdmac1";
 		};
+		mstp4_clks: mstp4_clks@e6150140 {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&rclk_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7790_CLK_RWDT
+			>;
+			clock-output-names = "rwdt";
+		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 91940271cf83..34e4c12e3f6e 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -77,6 +77,9 @@
 #define R8A7790_CLK_USBDMAC0		30
 #define R8A7790_CLK_USBDMAC1		31
 
+/* MSTP4 */
+#define R8A7790_CLK_RWDT		2
+
 /* MSTP5 */
 #define R8A7790_CLK_AUDIO_DMAC1		1
 #define R8A7790_CLK_AUDIO_DMAC0		2
-- 
2.1.4

