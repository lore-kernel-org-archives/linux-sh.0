From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 14:13:49 +0000
Subject: [PATCH v4 03/16] ARM: shmobile: lager: Specify external clock frequency in DT
Message-Id: <1386771242-21876-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The external crystal frequency is 20MHz on the Lager board. Specify it
in the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 67a6939..57569cb 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -58,6 +58,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
 &pfc {
 	pinctrl-0 = <&scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
-- 
1.8.3.2

