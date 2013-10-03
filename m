From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Oct 2013 17:35:41 +0000
Subject: [PATCH] ARM: shmobile: r8a7778: Fix pin control device address in DT
Message-Id: <1380821741-7515-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PFC device is erroneously declared at address 0xfffc000 instead of
0xfffc0000. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a6308a3..45c32dc 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -114,6 +114,6 @@
 
 	pfc: pfc@fffc0000 {
 		compatible = "renesas,pfc-r8a7778";
-		reg = <0xfffc000 0x118>;
+		reg = <0xfffc0000 0x118>;
 	};
 };
-- 
Regards,

Laurent Pinchart

