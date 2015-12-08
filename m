From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 08 Dec 2015 17:54:15 +0000
Subject: [PATCH 10/13] ARM: shmobile: lager dts: Add serial port config to chosen/stdout-path
Message-Id: <1449597258-32623-11-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 97029633acb6ccc4..9b6f483233adf408 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -53,7 +53,7 @@
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = &scif0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@40000000 {
-- 
1.9.1

