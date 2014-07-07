From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 07:54:54 +0000
Subject: [PATCH v2 29/30] ARM: shmobile: sh73a0: Add CMT1 node
Message-Id: <1404719695-1634-30-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This describes all of the CMT1 hardware of the sh73a0.
The node is disabled and may be enabled as necessary by board DTS files.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
N.B: This only adds cmt1, as per the legacy C code

v2
* First post
---
 arch/arm/boot/dts/sh73a0.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 910b790..57e1ed2 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -324,6 +324,17 @@
 			<&irqpin3 4 0>, <&irqpin3 5 0>, <&irqpin3 6 0>, <&irqpin3 7 0>;
 	};
 
+	cmt1: timer@e6138000 {
+		compatible = "renesas,cmt-48";
+		reg = <0xe6138000 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+
+		renesas,channels-mask = <0x3f>;
+
+		status = "disabled";
+	};
+
 	sh_fsi2: sound@ec230000 {
 		#sound-dai-cells = <1>;
 		compatible = "renesas,sh_fsi2";
-- 
2.0.0.rc2

