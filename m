From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 19 Feb 2014 21:06:55 +0000
Subject: [PATCH] ARM: shmobile: r8a7791: fix clock index for i2c5
Message-Id: <1392844015-18024-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1ab4f3d..3b2cdc8 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -731,7 +731,7 @@
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
-				R8A7791_CLK_I2C4 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
+				R8A7791_CLK_I2C5 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
 				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
 			>;
 			clock-output-names -- 
1.8.5.1

