From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 22 Apr 2016 18:07:01 +0000
Subject: [PATCH 1/4] sh: make time.c explicitly non-modular
Message-Id: <1461348424-3896-2-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

The Makefile currently controlling compilation of this code is:

obj-y   := debugtraps.o dma-nommu.o dumpstack.o                 \
[...]
           syscalls_$(BITS).o time.o topology.o traps.o         \
           traps_$(BITS).o unwinder.o

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular code, so that when reading
the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sh/kernel/time.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index d6d0a986c6e9..bfe1de98d003 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -11,7 +11,6 @@
  * for more details.
  */
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/profile.h>
 #include <linux/timex.h>
@@ -83,7 +82,7 @@ static int __init rtc_generic_init(void)
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
-module_init(rtc_generic_init);
+device_initcall(rtc_generic_init);
 
 void (*board_time_init)(void);
 
-- 
2.8.0

