From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Tue, 31 Oct 2017 17:22:18 +0000
Subject: [PATCH] sh: pass endianness info to sparse
Message-Id: <20171031172218.10137-1-luc.vanoostenryck@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sparse assumes the same endianness as the building machine.
This is problematic for code which expect __BYTE_ORDER__ being
correctly predefined by the compiler which sparse can then
pre-process differently from what gcc would, depending on the
building machine endianness.

Fix this by letting sparse know about the architecture endianness.

To: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/sh/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 280bbff12..93639dd5e 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -119,10 +119,12 @@ ifdef CONFIG_CPU_LITTLE_ENDIAN
 ld-bfd			:= elf32-$(UTS_MACHINE)-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64 --oformat $(ld-bfd)
 LDFLAGS			+= -EL
+CHECKFLAGS		+= -mlittle-endian
 else
 ld-bfd			:= elf32-$(UTS_MACHINE)big-linux
 LDFLAGS_vmlinux		+= --defsym jiffies=jiffies_64+4 --oformat $(ld-bfd)
 LDFLAGS			+= -EB
+CHECKFLAGS		+= -mbig-endian
 endif
 
 export ld-bfd BITS
-- 
2.14.0

