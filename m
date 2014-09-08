From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 08 Sep 2014 00:57:06 +0000
Subject: [PATCH v3 1/3] ARM: shmobile: sh73a0: Add CMT1 device to DT
Message-Id: <1410137828-4769-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v3 [Simon Horman]
* Dropped use of clocks that are not present in DT yet
---
 arch/arm/boot/dts/sh73a0.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 0d001eb..6cb29cd 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -48,6 +48,16 @@
 			     <0 56 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	cmt1: timer@e6138000 {
+		compatible = "renesas,cmt-48";
+		reg = <0xe6138000 0x200>;
+		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+
+		renesas,channels-mask = <0x3f>;
+
+		status = "disabled";
+	};
+
 	irqpin0: irqpin@e6900000 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
-- 
2.0.1

