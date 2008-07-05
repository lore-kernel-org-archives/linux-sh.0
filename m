From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2008 03:33:30 +0000
Subject: [PATCH] sh: fix pg-sh4.c build breakage in linux-next
Message-Id: <20080705033330.17256.98523.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remove inline from ptep_get_and_clean() to match with header file prototype.
Makes linux-next build.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies to linux-next, seems ok on ap325rxa.

 arch/sh/mm/pg-sh4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/mm/pg-sh4.c
+++ work/arch/sh/mm/pg-sh4.c	2008-07-05 09:53:51.000000000 +0900
@@ -111,7 +111,7 @@ EXPORT_SYMBOL(copy_user_highpage);
 /*
  * For SH-4, we have our own implementation for ptep_get_and_clear
  */
-inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 
