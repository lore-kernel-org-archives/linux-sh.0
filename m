From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Tue, 25 May 2010 14:07:25 +0000
Subject: [PATCH 1/5] sh: remove duplicated #include
Message-Id: <1274796445-3868-1-git-send-email-weiyi.huang@gmail.com>
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
index 4971425..3845258 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -26,7 +26,6 @@
 #include <linux/mmc/host.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
-#include <linux/mfd/sh_mobile_sdhi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <sound/sh_fsi.h>
 #include <media/sh_mobile_ceu.h>
-- 
1.6.1.3

