From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 06 Mar 2009 02:51:14 +0000
Subject: [PATCH/for-2.6.29] sh: Add media/soc_camera.h to board setup of
Message-Id: <49B08FA2.30007@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Other compilation errors were revised by commit of
"sh: ap325rxa: Revert ov772x support"
(08c2f5b4d76f83213e379b12df504269d21c9e7c) but other compilation
errors are given.
We revert this commit and need to add new header(media/soc_camera.h).
This change revises new compilation error.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/board-ap325rxa.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index 72da416..15b6d45 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
+#include <media/soc_camera.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
 #include <video/sh_mobile_lcdc.h>
-- 
