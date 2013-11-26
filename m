From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 26 Nov 2013 07:47:12 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: marzen: enable HSPI0 in DTS
Message-Id: <1385452032-11544-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385452032-11544-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1385452032-11544-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Based on work for the bockw board by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 918085c..76f5eef 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -97,6 +97,11 @@
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
 		renesas,function = "sdhi0";
 	};
+
+	hspi0_pins: hspi0 {
+		renesas,groups = "hspi0";
+		renesas,function = "hspi0";
+	};
 };
 
 &sdhi0 {
@@ -107,3 +112,9 @@
 	bus-width = <4>;
 	status = "okay";
 };
+
+&hspi0 {
+	pinctrl-0 = <&hspi0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.8.4

