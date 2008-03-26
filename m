From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Wed, 26 Mar 2008 01:16:32 +0000
Subject: [PATCH] SuperH floppy: kill 'register' keyword from floppy.h
Message-Id: <alpine.LNX.1.00.0803260213550.1901@dragon.funnycrock.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Ian Molton <spyro@f2s.com>, Alain L Knaff <Alain.Knaff@lll.lu>, David C Niemi <niemi@tux.org>, Trivial Patch Monkey <trivial@kernel.org>, Andrew Morton <akpm@linux-foundation.org>


When compilers became generally better at optimizing code than humans, the
register keyword became mostly useless. For the floppy driver it certainly
is since it's so slow compared to the rest of the system that optimizing
access to a single variable or two isn't going to make any real
difference
So let's just leave it to the compiler - it'll do a better job anyway.

This patch does away with a few register keywords in the SuperH floppy
driver.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 floppy.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-sh/floppy.h b/include/asm-sh/floppy.h
index 59fbfdc..afa7f8f 100644
--- a/include/asm-sh/floppy.h
+++ b/include/asm-sh/floppy.h
@@ -54,7 +54,7 @@ static int doing_pdma;
 
 static void floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
 {
-	register unsigned char st;
+	unsigned char st;
 
 #undef TRACE_FLPY_INT
 
@@ -74,8 +74,8 @@ static void floppy_hardint(int irq, void *dev_id, struct pt_regs * regs)
 #endif
 
 	{
-		register int lcount;
-		register char *lptr;
+		int lcount;
+		char *lptr;
 
 		st = 1;
 		for(lcount=virtual_dma_count, lptr=virtual_dma_addr; 



