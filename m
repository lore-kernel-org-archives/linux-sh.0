From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 22:45:16 +0000
Subject: [PATCH 06/11] ARM: shmobile: r8a7790: Rename mmcif node to mmc
Message-Id: <1405464321-4723-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>, devicetree@vger.kernel.org

Node names should describe the function of the device, not its IP core
name.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0f15f7c..4fae298 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -356,7 +356,7 @@
 		status = "disabled";
 	};
 
-	mmcif0: mmcif@ee200000 {
+	mmcif0: mmc@ee200000 {
 		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.5

