From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 04 Jul 2013 18:17:22 +0000
Subject: [PATCH v7 09/19] ARM: shmobile: sh7372: Add pin control device to device tree
Message-Id: <1372961852-28490-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a pfc node to the sh7372 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh7372.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index 7bf020e..249f65be2 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -23,4 +23,12 @@
 			reg = <0x0>;
 		};
 	};
+
+	pfc: pfc@e6050000 {
+		compatible = "renesas,pfc-sh7372";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605801c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.8.1.5

