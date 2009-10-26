From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 26 Oct 2009 23:49:50 +0000
Subject: [PATCH] sh_eth: Add asm/cacheflush.h
Message-Id: <29ab51dc0910261649p2fb22799o5cc70a71dff0f1dd@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: Linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

Add include asm/cacheflush.h,  because declaration of __flush_purge_region
moved to asm/cacheflush.h.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/net/sh_eth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index f49d080..528b912 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -30,6 +30,7 @@
 #include <linux/phy.h>
 #include <linux/cache.h>
 #include <linux/io.h>
+#include <asm/cacheflush.h>

 #include "sh_eth.h"

-- 
1.6.4.3
