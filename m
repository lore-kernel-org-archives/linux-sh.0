From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 15:32:39 +0000
Subject: [RFC/PATCH 4/7] ARM: shmobile: lager: Enable DU device in DT
Message-Id: <1390318362-29954-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Magnus Damm <magnus.damm@gmail.com>

Enable the DU device and configure the related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 1081c5e..27bf361 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -58,6 +58,12 @@
 	};
 };
 
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <20000000>;
 };
@@ -66,6 +72,11 @@
 	pinctrl-0 = <&scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	du_pins: du {
+		renesas,groups = "du_rgb666", "du_sync_1", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data";
 		renesas,function = "scif0";
-- 
1.8.3.2

