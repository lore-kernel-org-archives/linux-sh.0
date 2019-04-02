From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 02 Apr 2019 22:39:21 +0000
Subject: [PATCH] sh: fix multiple function definition build errors
Message-Id: <9ee4e0c5-f100-86a2-bd4d-1d3287ceab31@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Many of the sh CPU-types have their own plat_irq_setup() and
arch_init_clk_ops() functions, so these same (empty) functions in
arch/sh/boards/of-generic.c are not needed and cause build errors.
If there is some case where these empty functions are needed,
they can be retained by marking them as "__weak" while at the
same time making builds that do not need them succeed.

Fixes these build errors:

arch/sh/boards/of-generic.o: In function `plat_irq_setup':
(.init.text+0x134): multiple definition of `plat_irq_setup'
arch/sh/kernel/cpu/sh2/setup-sh7619.o:(.init.text+0x30): first defined here
arch/sh/boards/of-generic.o: In function `arch_init_clk_ops':
(.init.text+0x118): multiple definition of `arch_init_clk_ops'
arch/sh/kernel/cpu/sh2/clock-sh7619.o:(.init.text+0x0): first defined here

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/boards/of-generic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-51-rc2.orig/arch/sh/boards/of-generic.c
+++ lnx-51-rc2/arch/sh/boards/of-generic.c
@@ -164,10 +164,10 @@ static struct sh_machine_vector __initmv
 
 struct sh_clk_ops;
 
-void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
+void __init __weak arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 }
 
-void __init plat_irq_setup(void)
+void __init __weak plat_irq_setup(void)
 {
 }
