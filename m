From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 08 Dec 2015 17:54:17 +0000
Subject: [PATCH 12/13] ARM: shmobile: porter dts: Add serial port config to chosen/stdout-path
Message-Id: <1449597258-32623-13-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index f2dd5356eac8786c..71ba7b6b3a337cd9 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -22,7 +22,7 @@
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = &scif0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@40000000 {
-- 
1.9.1

