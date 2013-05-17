From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 14:55:16 +0000
Subject: [PATCH 5/9] ARM: shmobile: APE6EVM: add DT pinctrl definitions for a serial interface
Message-Id: <1368802520-16378-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DT pinctrl group and function definitions for the serial device, used
as a serial console on APE6EVM.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 4fb0102..b5b24eb 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -52,3 +52,13 @@
 		};
 	};
 };
+
+&pfc {
+	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-names = "default";
+
+	scifa0_pins: scifa0 {
+		renesas,groups = "scifa0_data";
+		renesas,function = "scifa0";
+	};
+};
-- 
1.7.2.5

