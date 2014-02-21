From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Feb 2014 06:12:54 +0000
Subject: [PATCH 13/13] ARM: shmobile: genmai: adapt dts to use native i2c driver
Message-Id: <367aaaea1d6c6496695ffd06b49590b8cfcb8aa5.1392961872.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392961872.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1392961872.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Activate the shiny new riic driver for i2c2. Tested by accessing the
eeprom on the genmai board.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
1.8.5.2

