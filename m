From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 14:55:17 +0000
Subject: [PATCH 6/9] ARM: shmobile: lager: add DT pinctrl definitions for a serial interface
Message-Id: <1368802520-16378-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DT pinctrl group and function definitions for the serial device, used
as a serial console on lager.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 09a84fc..986f274 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -29,3 +29,13 @@
 		#size-cells = <1>;
 	};
 };
+
+&pfc {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: scif0 {
+		renesas,groups = "scif0_data";
+		renesas,function = "scif0";
+	};
+};
-- 
1.7.2.5

