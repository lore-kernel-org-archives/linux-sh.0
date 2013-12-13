From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:35 +0000
Subject: [PATCH 09/69] ARM: shmobile: bockw: add default PFC settings on DTS
Message-Id: <8ed1f8a5e1fdd76b0d2b04871a33a2f90e5f8343.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SCIF0 PFC setting is needed as default

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 969e386..3c1d1f0 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -55,3 +55,13 @@
 &irqpin {
 	status = "okay";
 };
+
+&pfc {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: scif0 {
+		renesas,groups = "scif0_data_a", "scif0_ctrl";
+		renesas,function = "scif0";
+	};
+};
-- 
1.8.4

