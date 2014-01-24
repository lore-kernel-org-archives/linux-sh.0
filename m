From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 24 Jan 2014 17:44:44 +0000
Subject: [PATCH] sh: mach-highlander/psw.c is tristate and should use module.h
Message-Id: <1390585484-5736-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

This file is controlled by a tristate Kconfig option, and hence
needs to include module.h so that it can get module_init() once
we relocate it from init.h into module.h in the future.

Note that module_exit() appears to be missing from the driver, so
it is questionable whether it would actually work for a removal
and reload cycle if it was configured for a modular build.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[patch will be added to init cleanup series:
   http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/  ]

 arch/sh/boards/mach-highlander/psw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-highlander/psw.c b/arch/sh/boards/mach-highlander/psw.c
index 522786318d36..40e2b585d488 100644
--- a/arch/sh/boards/mach-highlander/psw.c
+++ b/arch/sh/boards/mach-highlander/psw.c
@@ -10,7 +10,7 @@
  * for more details.
  */
 #include <linux/io.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <mach/highlander.h>
-- 
1.8.5.2

