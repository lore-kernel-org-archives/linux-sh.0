From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 27 May 2010 19:56:33 +0000
Subject: [PATCH 2/2] blackfin: use ->mmap_sem to protect
Message-Id: <20100527195633.GC25935@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com> <25539.1274711817@redhat.com> <20100524151445.GA6393@redhat.com> <17134.1274778852@redhat.com> <20100525102345.GA23574@redhat.com> <AANLkTilT3D8c86LYK2DxcNpM2F3D8iCbgY_sfUg8h58p@mail.gmail.com> <20100526124006.GA28358@redhat.com> <20100527195544.GA25935@redhat.com>
In-Reply-To: <20100527195544.GA25935@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier.adi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Roland McGrath <roland@redhat.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

Any usage of mm->context.sram_list is not safe, is_user_addr_valid()
and sram_free_with_lsl/sram_free_with_lsl can race with each other.

Change sram_free_with_lsl/sram_free_with_lsl to take mm->mmap_sem
for writing, is_user_addr_valid() was already modified to take it
for reading and it doesn't modify this list.

destroy_context() reaps this list lockless, this is OK.

This patch assumes that sram_free() doesn't need to be serialized
(afaics it does the locking correctly), and it is safe to call
sram_free(addr) after its sram_list_struct was removed from list.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---

 arch/blackfin/mm/sram-alloc.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- 34-rc1/arch/blackfin/mm/sram-alloc.c~IUAV_2_SRAM_LIST_LOCKING	2010-05-27 17:51:48.000000000 +0200
+++ 34-rc1/arch/blackfin/mm/sram-alloc.c	2010-05-27 21:31:01.000000000 +0200
@@ -702,19 +702,23 @@ EXPORT_SYMBOL(l2_sram_free);
 
 int sram_free_with_lsl(const void *addr)
 {
-	struct sram_list_struct *lsl, **tmp;
+	struct sram_list_struct *lsl = NULL, **tmp;
 	struct mm_struct *mm = current->mm;
 
+	down_write(&mm->mmap_sem);
 	for (tmp = &mm->context.sram_list; *tmp; tmp = &(*tmp)->next)
-		if ((*tmp)->addr = addr)
-			goto found;
-	return -1;
-found:
-	lsl = *tmp;
+		if ((*tmp)->addr = addr) {
+			lsl = *tmp;
+			*tmp = lsl->next;
+			break;
+		}
+	up_write(&mm->mmap_sem);
+
+	if (!lsl)
+		return -1;
+
 	sram_free(addr);
-	*tmp = lsl->next;
 	kfree(lsl);
-
 	return 0;
 }
 EXPORT_SYMBOL(sram_free_with_lsl);
@@ -749,10 +753,14 @@ void *sram_alloc_with_lsl(size_t size, u
 		kfree(lsl);
 		return NULL;
 	}
+
+	down_write(&mm->mmap_sem);
 	lsl->addr = addr;
 	lsl->length = size;
 	lsl->next = mm->context.sram_list;
 	mm->context.sram_list = lsl;
+	up_write(&mm->mmap_sem);
+
 	return addr;
 }
 EXPORT_SYMBOL(sram_alloc_with_lsl);

