From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 11 Jun 2013 22:22:33 +0000
Subject: [PATCH v5 04/22] ARM: shmobile: r8a73a4: Add pin control device to device tree
Message-Id: <1370989371-30846-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a pfc node to the r8a73a4 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4ff2019..5aa1180 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -85,4 +85,11 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 4>;
 	};
+
+	pfc: pfc@e6050000 {
+		compatible = "renesas,pfc-r8a73a4";
+		reg = <0xe6050000 0x9000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.8.1.5

