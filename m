From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 21 Mar 2013 16:05:44 +0000
Subject: [PATCH 3/3] ARM: shmobile: kzm9g-reference: add ethernet support
Message-Id: <Pine.LNX.4.64.1303211704370.32438@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a DT node for the SMSC 9221 ethernet chip, found on kzm9g, to its
reference implementation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index f33b5cc..5972abb 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -44,6 +44,19 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	lan9220@10000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x10000000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin0>;
+		interrupts = <3 0>;	/* active low */
+		reg-io-width = <4>;
+		smsc,irq-push-pull;
+		smsc,save-mac-address;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
 };
 
 &mmcif {
-- 
1.7.2.5

