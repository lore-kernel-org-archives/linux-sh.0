From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 16 Feb 2015 16:58:59 +0000
Subject: [PATCH v3 15/15] ARM: shmobile: bockw dts: set extal clock frequency
Message-Id: <1424105939-4910-16-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sets the extal clock to the frequency of the oscillator installed by
default (33 MHz).

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 97a1132..cbb206b 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -79,6 +79,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <33333333>;
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.2.2

