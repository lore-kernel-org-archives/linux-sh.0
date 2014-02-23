From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 23 Feb 2014 12:43:57 +0000
Subject: [RFC] ARM: shmobile: koelsch: activate i2c6 bus
Message-Id: <1393159437-14456-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

I used this patch to test my IIC(B) enablement patches. With i2ctools,  I could
scan this bus and read registers from the connected pmic. Actually, I don't think
we should expose this bus unless really needed, but maybe you think different?

 arch/arm/boot/dts/r8a7791-koelsch.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index e6ca0e0..4557f8e 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -122,6 +122,11 @@
 	};
 };
 
+&i2c6 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
 &pfc {
 	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
-- 
1.8.5.1

