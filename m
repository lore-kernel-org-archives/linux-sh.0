From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 04 Oct 2011 01:17:21 +0000
Subject: [PATCH/linux-next] sh: userimask.c needs linux/stat.h
Message-Id: <1317691041-20226-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

This fix the problem that S_IRUSR and S_IWUSR are not solved in userimask.c.

-----
CC      drivers/usb/host/r8a66597-hcd.o
drivers/sh/intc/userimask.c:57: error: ‘S_IRUSR’ undeclared here (not in a function)
drivers/sh/intc/userimask.c:57: error: ‘S_IWUSR’ undeclared here (not in a function)
CC      drivers/watchdog/shwdt.o
-----

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/sh/intc/userimask.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index e32304b..56bf933 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -13,6 +13,7 @@
 #include <linux/sysdev.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/stat.h>
 #include <asm/sizes.h>
 #include "internals.h"
 
-- 
1.7.6.3

