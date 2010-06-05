From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Sat, 05 Jun 2010 14:42:39 +0000
Subject: [PATCH 1/4] sh: remove duplicated #include
Message-Id: <1275748959-4012-1-git-send-email-weiyi.huang@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remove duplicated #include('s) in
  arch/sh/boards/mach-ecovec24/setup.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index be1d114..1d7b495 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -25,7 +25,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/sh_msiof.h>
 #include <linux/spi/mmc_spi.h>
-#include <linux/mmc/host.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <video/sh_mobile_lcdc.h>
-- 
1.6.1.3

