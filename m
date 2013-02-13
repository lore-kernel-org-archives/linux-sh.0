From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 13 Feb 2013 03:29:14 +0000
Subject: [PATCH 2/9] ARM: shmobile: r8a7740: Add pin control device in device tree
Message-Id: <1360726161-16072-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a pfc node in the r8a7740 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..9d7800a 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -18,4 +18,12 @@
 			compatible = "arm,cortex-a9";
 		};
 	};
+
+	gpio: pfc@e6050000 {
+		compatible = "renesas,pfc-r8a7740";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605800c 0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.7.10.4

