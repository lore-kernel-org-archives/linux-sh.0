From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 10 Aug 2019 05:24:42 +0000
Subject: [PATCH v2] sh: kernel: disassemble: Mark expected switch fall-throughs
Message-Id: <20190810052442.GA21354@embeddedor>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>

Remove logically dead code and mark switch cases where we are expecting
to fall through.

Fix the following warnings (Building: defconfig sh):

arch/sh/kernel/disassemble.c:478:8: warning: this statement may fall
through [-Wimplicit-fallthrough=]
arch/sh/kernel/disassemble.c:487:8: warning: this statement may fall
through [-Wimplicit-fallthrough=]
arch/sh/kernel/disassemble.c:496:8: warning: this statement may fall
through [-Wimplicit-fallthrough=]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Remove logically dead code. Pointed out by Joe Perches.

NOTE: If no one cares, I'll apply this to my tree and queue it up
      for 5.3-rc4.

 arch/sh/kernel/disassemble.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
index defebf1a9c8a..845543780cc5 100644
--- a/arch/sh/kernel/disassemble.c
+++ b/arch/sh/kernel/disassemble.c
@@ -475,8 +475,6 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 				printk("dbr");
 				break;
 			case FD_REG_N:
-				if (0)
-					goto d_reg_n;
 			case F_REG_N:
 				printk("fr%d", rn);
 				break;
@@ -488,7 +486,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 					printk("xd%d", rn & ~1);
 					break;
 				}
-			d_reg_n:
+				/* else, fall through */
 			case D_REG_N:
 				printk("dr%d", rn);
 				break;
@@ -497,6 +495,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
 					printk("xd%d", rm & ~1);
 					break;
 				}
+				/* else, fall through */
 			case D_REG_M:
 				printk("dr%d", rm);
 				break;
-- 
2.22.0
