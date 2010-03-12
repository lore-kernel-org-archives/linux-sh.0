From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Fri, 12 Mar 2010 13:05:06 +0000
Subject: [PATCH 1/3] serial: sh-sci: remove duplicated #include
Message-Id: <1268399106-4384-1-git-send-email-weiyi.huang@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remove duplicated #include('s) in
  drivers/serial/sh-sci.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/serial/sh-sci.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 980f394..f7b9aff 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -50,7 +50,6 @@
 #include <linux/list.h>
 #include <linux/dmaengine.h>
 #include <linux/scatterlist.h>
-#include <linux/timer.h>
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
-- 
1.6.1.3

