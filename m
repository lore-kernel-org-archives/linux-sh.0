From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 10 Mar 2014 11:27:00 +0000
Subject: [PATCH V2 5/5] ARM: shmobile: koelsch: activate i2c6 bus
Message-Id: <1394450820-8158-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes since V1: added ack

 arch/arm/boot/dts/r8a7791-koelsch.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 5e90f18db1fb..2151f73e5eef 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -195,6 +195,11 @@
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
1.9.0

