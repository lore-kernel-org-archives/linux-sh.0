From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Aug 2015 06:29:13 +0000
Subject: [PATCH 6/7][RFC] arm64: dts: salvatorx: enable usb2_phy nodes
Message-Id: <1440052154-3768-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
index 7f6039d..e697f3e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
@@ -51,3 +51,21 @@
 &scif2 {
 	status = "okay";
 };
+
+&usb2_phy0 {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
+&usb2_phy1 {
+	status = "okay";
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+};
+
+&usb2_phy2 {
+	status = "okay";
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+};
-- 
1.9.1

