From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:03:12 +0000
Subject: [PATCH v2 73/77] ARM: shmobile: r8a7740: Add pin control device in device tree
Message-Id: <1353974596-30033-74-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a pfc node in the r8a7740 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..9586d66 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -18,4 +18,10 @@
 			compatible = "arm,cortex-a9";
 		};
 	};
+
+	gpio: pfc@e6050000 {
+		compatible = "renesas,pfc-r8a7740";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605800c 0x20>;
+	};
 };
-- 
1.7.8.6

