From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 28 Jan 2011 07:07:13 +0000
Subject: [PATCH] sh: sh7750: move machtypes.h to include/generated
Message-Id: <1296198433-1706-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

By commit 3252b11fc4790d046b93f300c898df2f7cd7c176,
machtypes.h moved to include/generated.
However, this forgot kernel/cpu/sh4/setup-sh7750.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 672944f..84230e9 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/sh_timer.h>
 #include <linux/serial_sci.h>
-#include <asm/machtypes.h>
+#include <generated/machtypes.h>
 
 static struct resource rtc_resources[] = {
 	[0] = {
-- 
1.7.2.3

