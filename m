From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 09 Feb 2015 16:02:43 +0000
Subject: [PATCH v2 15/15] ARM: shmobile: bockw dts: set extal clock frequency
Message-Id: <1423497763-3450-16-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sets the extal clock to the frequency of the oscillator installed by
default (33 MHz).

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 2b4b84b..5e4be51 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -84,6 +84,10 @@
 	pinctrl-names = "default";
 };
 
+&extal_clk {
+	clock-frequency = <33333333>;
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.2.2

