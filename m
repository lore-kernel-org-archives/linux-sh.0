From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Sat, 13 Jun 2009 12:21:11 +0000
Subject: [PATCH 1/3] sh: pci: remove duplicated #include's
Message-Id: <1244895671-2840-1-git-send-email-weiyi.huang@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/sh/boards/mach-se/7780/irq.c   |    1 -
 arch/sh/drivers/pci/ops-dreamcast.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-se/7780/irq.c b/arch/sh/boards/mach-se/7780/irq.c
index b8d43b6..121744c 100644
--- a/arch/sh/boards/mach-se/7780/irq.c
+++ b/arch/sh/boards/mach-se/7780/irq.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/io.h>
 #include <mach-se/mach/se7780.h>
 
diff --git a/arch/sh/drivers/pci/ops-dreamcast.c b/arch/sh/drivers/pci/ops-dreamcast.c
index e83d0d3..16e0a1b 100644
--- a/arch/sh/drivers/pci/ops-dreamcast.c
+++ b/arch/sh/drivers/pci/ops-dreamcast.c
@@ -18,7 +18,6 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <mach/pci.h>
 
 /*
-- 
1.6.1.2

