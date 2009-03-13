From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 13 Mar 2009 05:03:37 +0000
Subject: [PATCH] sh: Fix compole error by operands(mov.l) in sh3/entry.S
Message-Id: <49B9E929.6060509@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

-- log --
arch/sh/kernel/cpu/sh4/../sh3/entry.S:365: Error: invalid operands for opcode
make[4]: *** [arch/sh/kernel/cpu/sh4/../sh3/entry.o] Error 1
make[3]: *** [arch/sh/kernel/cpu/sh4] Error 2
-- log --

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/kernel/cpu/sh3/entry.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index fba6ac2..55da0ff 100644
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -362,7 +362,7 @@ general_exception:
 	 nop

 	! Save registers / Switch to bank 0
-	mov.l	k4, k2		! keep vector in k2
+	mov		k4, k2		! keep vector in k2
 	mov.l	1f, k4		! SR bits to clear in k4
 	bsr	save_regs	! needs original pr value in k3
 	 nop
-- 
1.6.2

