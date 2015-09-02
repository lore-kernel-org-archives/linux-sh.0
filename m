From: Rob Landley <rob@landley.net>
Date: Wed, 02 Sep 2015 14:14:36 +0000
Subject: [PATCH] remove open-coded memset.
Message-Id: <55E7044C.1050304@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Rob Landley <rob@landley.net>

Why is the binflt loader open-coding memset?

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/sh/include/asm/flat.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 5d84df5..1feb3da 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -21,10 +21,6 @@
 #define	flat_set_persistent(relval, p)		({ (void)p; 0; })
 
 #define FLAT_PLAT_INIT(_r) \
-  do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
-       _r->regs[4]=0; _r->regs[5]=0; _r->regs[6]=0; _r->regs[7]=0; \
-       _r->regs[8]=0; _r->regs[9]=0; _r->regs[10]=0; _r->regs[11]=0; \
-       _r->regs[12]=0; _r->regs[13]=0; _r->regs[14]=0; \
-       _r->sr = SR_FD; } while (0)
+  do { memset(_r->regs, 0, 15*sizeof(*_r->regs)); _r->sr = SR_FD; } while (0)
 
 #endif /* __ASM_SH_FLAT_H */
