From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 07:54:36 +0000
Subject: [PATCH v2 11/30] ARM: shmobile: r8a73a4: Add CMT1 node
Message-Id: <1404719695-1634-12-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This describes all of the CMT1 hardware of the r8a73a4.
The node is disabled and may be enabled as necessary by board DTS files.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
N.B: This only adds cmt1, as per the legacy C code

v2
* First post
---
 arch/arm/boot/dts/r8a73a4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index d8ec505..9bf3386 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -50,6 +50,16 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	cmt1: timer@e6130000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xe6130000 0 0x1004>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+
+		renesas,channels-mask = <0xff>;
+
+		status = "disabled";
+	};
+
 	irqc0: interrupt-controller@e61c0000 {
 		compatible = "renesas,irqc";
 		#interrupt-cells = <2>;
-- 
2.0.0.rc2

