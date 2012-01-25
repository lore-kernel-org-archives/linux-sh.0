From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 25 Jan 2012 08:10:29 +0000
Subject: [PATCH] sh: se7724: fix compile breakage
Message-Id: <Pine.LNX.4.64.1201250909220.18778@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix compilation breakage

arch/sh/boards/mach-se/7724/setup.c:182: error: 'V4L2_PIX_FMT_RGB565' undeclared here (not in a function)
make[3]: *** [arch/sh/boards/mach-se/7724/setup.o] Error 1

caused by commit "fbdev: sh_mobile_lcdc: Support FOURCC-based format API"

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-se/7724/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 036fe1a..2b07fc0 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -24,6 +24,7 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/sh_eth.h>
+#include <linux/videodev2.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <sound/sh_fsi.h>
-- 
1.7.2.5

