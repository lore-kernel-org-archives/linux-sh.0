From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 10 Aug 2019 05:01:53 +0000
Subject: [PATCH] sh: kernel: disassemble: Mark expected switch fall-throughs
Message-Id: <20190810050153.GA13927@embeddedor>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Guenter Roeck <linux@roeck-us.net>

Mark switch cases where we are expecting to fall through.

Fix the following warnings (Building: defconfig sh):

arch/sh/kernel/disassemble.c:478:8: warning: this statement may fall
through [-Wimplicit-fallthrough=]
arch/sh/kernel/disassemble.c:487:8: warning: this statement may fall
through [-Wimplicit-fallthrough=]
arch/sh/kernel/disassemble.c:496:8: warning: this statement may fall
through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

If no one cares, I'll apply this to my tree and queue it up for 5.3-rc4.

 arch/sh/kernel/disassemble.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
index defebf1a9c8a..91c87e9891da 100644
--- a/arch/sh/kernel/disassemble.c
+++ b/arch/sh/kernel/disassemble.c
@@ -477,6 +477,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 			case FD_REG_N:
 				if (0)
 					goto d_reg_n;
+				/* else, fall through */
 			case F_REG_N:
 				printk("fr%d", rn);
 				break;
@@ -488,6 +489,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 					printk("xd%d", rn & ~1);
 					break;
 				}
+				/* else, fall through */
 			d_reg_n:
 			case D_REG_N:
 				printk("dr%d", rn);
@@ -497,6 +499,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 					printk("xd%d", rm & ~1);
 					break;
 				}
+				/* else, fall through */
 			case D_REG_M:
 				printk("dr%d", rm);
 				break;
-- 
2.22.0
