From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 Mar 2013 02:20:15 +0000
Subject: [PATCH 2/2] sh: sh7269: Fix compilation by adding missing includes
Message-Id: <1364264415-6020-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

struct resource is defined in linux/ioport.h. Include it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
index 1825b0b..4c17fb6 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
@@ -9,7 +9,9 @@
  * for more details.
  */
 
+#include <linux/bug.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <cpu/pfc.h>
 
-- 
1.8.1.5

