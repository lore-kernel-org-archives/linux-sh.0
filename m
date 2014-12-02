From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 02 Dec 2014 17:39:48 +0000
Subject: [PATCH] ARM: shmobile: lager dts: Drop console= bootargs parameter
Message-Id: <1417541988-28799-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since commit FIXME ("ARM: shmobile: lager: Remove legacy board support"),
lager is restricted to booting from DT, so chosen/stdout-path is always
used, and we can drop the "console=" parameter from chosen/bootargs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH 2/5] ARM: shmobile: lager: Remove legacy board
support" by Laurent Pinchart, and allows to simplify his "[PATCH 4/5] ARM:
shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]".
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 636d53bb87a27062..7301d029b39d5d9b 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -52,7 +52,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scifa0;
 	};
 
-- 
1.9.1

