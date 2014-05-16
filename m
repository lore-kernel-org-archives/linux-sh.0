From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 May 2014 15:26:55 +0000
Subject: [PATCH/RFC 7/7] ARM: shmobile: koelsch dts: Enable sysdma0 and sysdma1
Message-Id: <1400254015-29539-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 3461cfd506dc..b42ba5cca593 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -430,3 +430,11 @@
 		spi-max-frequency = <52000000>;
 	};
 };
+
+&sysdma0 {
+	status = "okay";
+};
+
+&sysdma1 {
+	status = "okay";
+};
-- 
1.7.9.5

