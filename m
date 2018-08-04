From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 04 Aug 2018 10:35:50 +0000
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-Id: <20180804103550.GA3183@bombadil.infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87600us5k9.wl-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Rob Landley <rob@landley.net>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, Aug 01, 2018 at 08:13:26PM +0900, Yoshinori Sato wrote:
> I have not tested enough to impose mm on my part, so it may be
> by chance this too.
> Restore the constructor and modify it so that __ GFP_ZERO is not specified.
> Because then I think that it is safer because it is exactly the same as
> before the fix.

I wish you had cc'd me on patch v2.  I think the answer is actually this
(which restoers the pre-2009 behaviour):

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 5c8f9247c3c2..7c63aa359c7d 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -2,7 +2,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 
-#define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
+#define PGALLOC_GFP GFP_KERNEL
 
 static struct kmem_cache *pgd_cachep;
 #if PAGETABLE_LEVELS > 2
@@ -13,6 +13,7 @@ void pgd_ctor(void *x)
 {
        pgd_t *pgd = x;
 
+       memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
        memcpy(pgd + USER_PTRS_PER_PGD,
               swapper_pg_dir + USER_PTRS_PER_PGD,
               (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));

but I haven't even compiled it.
