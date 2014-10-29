From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:28:38 +0000
Subject: [PATCH 3/3] ARM: shmobile: koelsch dts: Drop console= bootargs parameter
Message-Id: <1414592918-25138-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org

Since commit 595c6a4bb77f0096 ("ARM: shmobile: koelsch: Remove legacy C
board code"), koelsch is restricted to booting from DT, so
chosen/stdout-path is always used, and we can drop the "console="
parameter from chosen/bootargs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 191f32bc43ea6dad..523ae4d807b907b2 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -25,7 +25,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scif0;
 	};
 
-- 
1.9.1

