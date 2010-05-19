From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Wed, 19 May 2010 23:12:19 +0000
Subject: [PATCH 3/3] sh: remove duplicated #include
Message-Id: <1274310739-1076-1-git-send-email-weiyi.huang@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remove duplicated #include('s) in
  arch/sh/kernel/cpu/sh4a/clock-sh7786.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index 105a6d4..597c9fb 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/clk.h>
 #include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/freq.h>
-- 
1.6.1.3

