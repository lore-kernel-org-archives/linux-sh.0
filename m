From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 31 Oct 2017 17:22:20 +0000
Subject: [PATCH] sh: pass machine size to sparse
Message-Id: <20171031172220.10186-1-luc.vanoostenryck@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

By default, sparse assumes a 64bit machine when compiled on x86-64
and 32bit when compiled on anything else.

This can of course create all sort of problems, like issuing false
warnings like: 'constant ... is so big it is unsigned long long'
or 'shift too big (32) for type unsigned long' when the architecture
is 64bit while sparse was compiled on a 32bit machine, or worse,
to not emit legitimate warnings in the reverse situation.

Fix this by passing to sparse the appropriate -m32/-m64 flag

To: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/sh/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 93639dd5e..f68918660 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -106,6 +106,7 @@ UTS_MACHINE		:= sh
 BITS			:= 32
 LDFLAGS_vmlinux		+= -e _stext
 KBUILD_DEFCONFIG	:= shx3_defconfig
+CHECKFLAGS		+= -m32
 else
 UTS_MACHINE		:= sh64
 BITS			:= 64
@@ -113,6 +114,7 @@ LDFLAGS_vmlinux		+= --defsym phys_stext=_stext-$(CONFIG_PAGE_OFFSET) \
 			   --defsym phys_stext_shmedia=phys_stext+1 \
 			   -e phys_stext_shmedia
 KBUILD_DEFCONFIG	:= cayman_defconfig
+CHECKFLAGS		+= -m64
 endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-- 
2.14.0

