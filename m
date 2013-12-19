From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 19 Dec 2013 15:28:42 +0000
Subject: [PATCH v6 15.1/17] ARM: shmobile: Add GPIO keys to Koelsch DTS
Message-Id: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Koelsh reference device tree is going away, copy the missing GPIO
keys device node to the Koeslch device tree file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

Hi Simon,

This patch contains the differences between v4 (which you have queued up) and
v5 of "ARM: shmobile: Sync Koelsch DTS with Koelsch reference DTS". Feel free
to apply it on top of your dt branch, or alternatively rebase the branch to
replace v4 with v5.

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index fd556c3..c6f5de3 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -31,6 +31,60 @@
 		#size-cells = <1>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-a {
+			gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+			linux,code = <30>;
+			label = "SW30";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-b {
+			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
+			linux,code = <48>;
+			label = "SW31";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-c {
+			gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
+			linux,code = <46>;
+			label = "SW32";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-d {
+			gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
+			linux,code = <32>;
+			label = "SW33";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-e {
+			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
+			linux,code = <18>;
+			label = "SW34";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-f {
+			gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+			linux,code = <33>;
+			label = "SW35";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-g {
+			gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+			linux,code = <34>;
+			label = "SW36";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led6 {
-- 
1.8.3.2

