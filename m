From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:05 +0000
Subject: [PATCH 1/3] ARM: shmobile: ape6evm-reference: add ethernet controller to DT
Message-Id: <1417509427-31690-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <dbffb5a1525dc88f1c871c48574634f14845b43d.1380530263.git.horms+renesas@verge.net.au>
In-Reply-To: <dbffb5a1525dc88f1c871c48574634f14845b43d.1380530263.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Describes the SMSC LAN9220 chip.  It is not currently enabled because a suitable
mechanism for activating its clock (zb) is yet to be developed.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 84e05f7..a218c26 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -68,6 +68,19 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0x80000000>;
+
+		ethernet@8000000 {
+			compatible = "smsc,lan9220", "smsc,lan9115";
+			reg = <0x08000000 0x1000>;
+			interrupt-parent = <&irqc1>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+			phy-mode = "mii";
+			reg-io-width = <4>;
+			smsc,irq-active-high;
+			smsc,irq-push-pull;
+			vddvario-supply = <&ape6evm_fixed_3v3>;
+			vdd33a-supply = <&ape6evm_fixed_3v3>;
+		};
 	};
 };
 
-- 
1.8.4.5

