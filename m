From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Mon, 28 May 2018 16:40:18 +0000
Subject: [PATCH] sh: pass machine size to sparse
Message-Id: <20180528164018.16064-1-luc.vanoostenryck@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20171031172220.10186-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171031172220.10186-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

By default, sparse assumes a 64bit machine when compiled on x86-64
and 32bit when compiled on anything else.

This can of course create all sort of problems, like issuing false
warnings like: 'shift too big (32) for type unsigned long', or
worse, to not emit legitimate warnings.

Fix this by passing to sparse the appropriate -m32/-m64 flag

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/sh/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 65300193b..3a195c9d5 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -206,6 +206,8 @@ ifeq ($(CONFIG_DWARF_UNWINDER),y)
   KBUILD_CFLAGS += -fasynchronous-unwind-tables
 endif
 
+CHECKFLAGS += -m$(BITS)
+
 libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/	$(libs-y)
 libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
 
-- 
2.17.0

