From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 09 Sep 2015 17:48:19 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: lager: add pinmux for iic0
Message-Id: <1441820899-10457-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa@sang-engineering.com>

It seems we used to rely on the default pinmux setting of this HW, but
currently we need to explicitly set the pinmux to access this bus. It is
better style, too.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6f5d7f50d5ca09..c553abd711eeb3 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -342,6 +342,11 @@
 		renesas,function = "msiof1";
 	};
 
+	iic0_pins: iic0 {
+		renesas,groups = "iic0";
+		renesas,function = "iic0";
+	};
+
 	iic1_pins: iic1 {
 		renesas,groups = "iic1";
 		renesas,function = "iic1";
@@ -517,6 +522,8 @@
 
 &iic0	{
 	status = "okay";
+	pinctrl-0 = <&iic0_pins>;
+	pinctrl-names = "default";
 };
 
 &iic1	{
-- 
2.1.4

