From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 21:19:18 +0000
Subject: [PATCH 2/3] arm: shmobile: genmai: adapt dts to use native i2c driver
Message-Id: <1392671959-22834-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa@sang-engineering.com>

Activate the shiny new riic driver for i2c2. Tested by accessing the
eeprom on the genmai board.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index 0849017..e664611 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -29,3 +29,14 @@
 		#size-cells = <1>;
 	};
 };
+
+&i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		compatible = "renesas,24c128";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
-- 
1.8.5.1

