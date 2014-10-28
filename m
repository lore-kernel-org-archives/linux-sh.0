From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 28 Oct 2014 17:02:13 +0000
Subject: [PATCH v3 4/7] ARM: shmobile: kzm9g-reference: Common clock framework DT description
Message-Id: <1414515736-24905-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

KZM9G-specific clock overrides.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 0dac0e6..bad6492 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -178,6 +178,10 @@
 	status = "ok";
 };
 
+&extal2_clk {
+	clock-frequency = <48000000>;
+};
+
 &i2c0 {
 	status = "okay";
 	as3711@40 {
-- 
1.8.4.5

