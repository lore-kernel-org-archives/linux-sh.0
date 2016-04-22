From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 22 Apr 2016 18:07:03 +0000
Subject: [PATCH 3/4] sh: make board-secureedge5410 explicitly non-modular
Message-Id: <1461348424-3896-4-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

config SH_SECUREEDGE5410
        bool "SecureEdge5410"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modularity so that when reading the
driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sh/boards/board-secureedge5410.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/boards/board-secureedge5410.c b/arch/sh/boards/board-secureedge5410.c
index 98b36205aa7b..97ec67ffec2b 100644
--- a/arch/sh/boards/board-secureedge5410.c
+++ b/arch/sh/boards/board-secureedge5410.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/delay.h>
-#include <linux/module.h>
 #include <linux/sched.h>
 #include <asm/machvec.h>
 #include <mach/secureedge5410.h>
@@ -49,7 +48,7 @@ static int __init eraseconfig_init(void)
 				irq);
 	return 0;
 }
-module_init(eraseconfig_init);
+device_initcall(eraseconfig_init);
 
 /*
  * Initialize IRQ setting
-- 
2.8.0

