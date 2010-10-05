From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 05 Oct 2010 15:54:00 +0000
Subject: [PATCH] sh: fix uninitialized spinlock
Message-Id: <1286294040-6171-1-git-send-email-akinobu.mita@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The spinlock in traps_64.c is used without initialization.
This fixes it by declaring DEFINE_SPINLOCK() and makes the spinlock static
variable.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/traps_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/traps_64.c b/arch/sh/kernel/traps_64.c
index e67e140..fda6355 100644
--- a/arch/sh/kernel/traps_64.c
+++ b/arch/sh/kernel/traps_64.c
@@ -50,7 +50,7 @@ asmlinkage void do_##name(unsigned long error_code, struct pt_regs *regs) \
 	do_unhandled_exception(trapnr, signr, str, __stringify(name), error_code, regs, current); \
 }
 
-spinlock_t die_lock;
+static DEFINE_SPINLOCK(die_lock);
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
-- 
1.6.0.6

