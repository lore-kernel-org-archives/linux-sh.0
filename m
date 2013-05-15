From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 15 May 2013 00:18:08 +0000
Subject: [PATCH v3 08/20] ARM: shmobile: r8a7790: Add pin control device to device tree
Message-Id: <1368577100-3530-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a pfc node to the r8a7790 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7a17110..ee21061 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -60,4 +60,9 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
+
+	pfc: pfc@e6060000 {
+		compatible = "renesas,pfc-r8a7790";
+		reg = <0xe6060000 0x250>;
+	};
 };
-- 
1.8.1.5

