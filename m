From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 08 Aug 2014 14:23:12 +0000
Subject: [PATCH v2 5/5] ARM: shmobile: armadillo800eva-reference: add clock overrides to DTS
Message-Id: <1407507792-8121-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407507792-8121-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1407507792-8121-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au
Cc: linux-sh@vger.kernel.org, mturquette@linaro.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index ee9e7d5..266c439 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -178,6 +178,19 @@
 	};
 };
 
+&extal1_clk {
+	clock-frequency = <25000000>;
+};
+&extal2_clk {
+	clock-frequency = <48000000>;
+};
+&fsibck_clk {
+	clock-frequency = <12288000>;
+};
+&cpg_clocks {
+	renesas,mode = <0x05>; /* MD_CK0 | MD_CK2 */
+};
+
 &i2c0 {
 	status = "okay";
 	touchscreen@55 {
-- 
1.8.4.5

