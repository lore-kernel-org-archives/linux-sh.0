From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 02 Apr 2013 05:11:14 +0000
Subject: [PATCH 02/11] ARM: shmobile: kzm9g-reference: add ethernet support
Message-Id: <1364879483-11144-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add a DT node for the SMSC 9221 ethernet chip, found on kzm9g, to its
reference implementation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

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
1.7.10.4

