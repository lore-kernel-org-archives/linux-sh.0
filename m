From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 25 Jul 2013 22:51:00 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7740: Add TPU node to the device tree
Message-Id: <1374792660-15893-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1354709587-25288-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1354709587-25288-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index e18a195..639822d 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -147,4 +147,11 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	tpu: pwm@e6600000 {
+		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
+		reg = <0xe6600000 0x100>;
+		status = "disabled";
+		#pwm-cells = <3>;
+	};
 };
-- 
1.8.1.5

