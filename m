From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 25 Jan 2012 21:07:05 +0000
Subject: [PATCH v2] sh: se7724: fix compile breakage
Message-Id: <Pine.LNX.4.64.1201252205550.18778@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix compilation breakage

arch/sh/boards/mach-se/7724/setup.c:182: error: 'V4L2_PIX_FMT_RGB565' undeclared here (not in a function)
make[3]: *** [arch/sh/boards/mach-se/7724/setup.o] Error 1

caused by commit "fbdev: sh_mobile_lcdc: Support FOURCC-based format API"
Also add other missing headers, even if compilation currently succeeds
because of their indirect inclusion via other headers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ap325rxa/setup.c |    1 +
 arch/sh/boards/mach-ecovec24/setup.c |    2 ++
 arch/sh/boards/mach-kfr2r09/setup.c  |    1 +
 arch/sh/boards/mach-migor/setup.c    |    2 ++
 arch/sh/boards/mach-se/7724/setup.c  |    1 +
 5 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 6418e95..ebd0f81 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -22,6 +22,7 @@
 #include <linux/i2c.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
+#include <linux/videodev2.h>
 #include <media/ov772x.h>
 #include <media/soc_camera.h>
 #include <media/soc_camera_platform.h>
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index c8d1bbd..63d91b8 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -29,9 +29,11 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/sh_eth.h>
+#include <linux/videodev2.h>
 #include <video/sh_mobile_lcdc.h>
 #include <sound/sh_fsi.h>
 #include <media/sh_mobile_ceu.h>
+#include <media/soc_camera.h>
 #include <media/tw9910.h>
 #include <media/mt9t112.h>
 #include <asm/heartbeat.h>
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 2a18b06..5b382e1 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -22,6 +22,7 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/i2c.h>
 #include <linux/usb/r8a66597.h>
+#include <linux/videodev2.h>
 #include <media/rj54n1cb0c.h>
 #include <media/soc_camera.h>
 #include <media/sh_mobile_ceu.h>
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 68c3d6f..d37ba27 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -21,9 +21,11 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/videodev2.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/ov772x.h>
+#include <media/soc_camera.h>
 #include <media/tw9910.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
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

