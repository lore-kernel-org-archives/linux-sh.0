From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Aug 2015 06:29:14 +0000
Subject: [PATCH 7/7][RFC] arm64: dts: salvatorx: enable ehci and ohci nodes
Message-Id: <1440052154-3768-8-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
index e697f3e..ec69546 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
@@ -69,3 +69,27 @@
 	pinctrl-0 = <&usb2_pins>;
 	pinctrl-names = "default";
 };
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
-- 
1.9.1

