From: Jann Horn <jannh@google.com>
Date: Wed, 29 Apr 2020 21:49:54 +0000
Subject: [PATCH v2 5/5] mm/gup: Take mmap_sem in get_dump_page()
Message-Id: <20200429214954.44866-6-jannh@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
In-Reply-To: <20200429214954.44866-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, "Eric W . Biederman" <ebiederm@xmission.com>

Properly take the mmap_sem before calling into the GUP code from
get_dump_page(); and play nice, allowing the GUP code to drop the mmap_sem
if it has to sleep.

As Linus pointed out, we don't actually need the VMA because
__get_user_pages() will flush the dcache for us if necessary.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/gup.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9a7e83772f1fe..03f659ddd830a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1548,19 +1548,23 @@ static long __get_user_pages_locked(struct task_struct *tsk,
  * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
  * allowing a hole to be left in the corefile to save diskspace.
  *
- * Called without mmap_sem, but after all other threads have been killed.
+ * Called without mmap_sem (takes and releases the mmap_sem by itself).
  */
 struct page *get_dump_page(unsigned long addr)
 {
-	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
 	struct page *page;
+	int locked = 1;
+	int ret;
 
-	if (__get_user_pages(current, current->mm, addr, 1,
-			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
-			     NULL) < 1)
+	if (down_read_killable(&mm->mmap_sem))
 		return NULL;
-	flush_cache_page(vma, addr, page_to_pfn(page));
-	return page;
+	ret = __get_user_pages_locked(current, mm, addr, 1, &page, NULL,
+				      &locked,
+				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
+	if (locked)
+		up_read(&mm->mmap_sem);
+	return (ret = 1) ? page : NULL;
 }
 
 #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
-- 
2.26.2.526.g744177e7f7-goog
