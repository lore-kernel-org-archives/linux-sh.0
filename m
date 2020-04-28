From: Jann Horn <jannh@google.com>
Date: Tue, 28 Apr 2020 03:27:45 +0000
Subject: [PATCH 5/5] mm/gup: Take mmap_sem in get_dump_page()
Message-Id: <20200428032745.133556-6-jannh@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
In-Reply-To: <20200428032745.133556-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, "Eric W . Biederman" <ebiederm@xmission.com>

Properly take the mmap_sem before calling into the GUP code from
get_dump_page(); and play nice, allowing __get_user_pages_locked() to drop
the mmap_sem if it has to sleep.

This requires adjusting the check in __get_user_pages_locked() to be
slightly less strict: While `vmas != NULL` is normally incompatible with
the lock-dropping retry logic, it's fine if we only want a single page,
because then retries can only happen when we haven't grabbed any pages yet.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/gup.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9a7e83772f1fe..4bb4149c0e259 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1261,7 +1261,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 
 	if (locked) {
 		/* if VM_FAULT_RETRY can be returned, vmas become invalid */
-		BUG_ON(vmas);
+		if (WARN_ON(vmas && nr_pages != 1))
+			return -EFAULT;
 		/* check caller initialized locked */
 		BUG_ON(*locked != 1);
 	}
@@ -1548,18 +1549,28 @@ static long __get_user_pages_locked(struct task_struct *tsk,
  * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
  * allowing a hole to be left in the corefile to save diskspace.
  *
- * Called without mmap_sem, but after all other threads have been killed.
+ * Called without mmap_sem (takes and releases the mmap_sem by itself).
  */
 struct page *get_dump_page(unsigned long addr)
 {
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct page *page;
+	int locked = 1;
+	int ret;
 
-	if (__get_user_pages(current, current->mm, addr, 1,
-			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
-			     NULL) < 1)
+	if (down_read_killable(&mm->mmap_sem))
+		return NULL;
+	ret = __get_user_pages_locked(current, mm, addr, 1, &page, &vma,
+				      &locked,
+				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
+	if (ret != 1) {
+		if (locked)
+			up_read(&mm->mmap_sem);
 		return NULL;
+	}
 	flush_cache_page(vma, addr, page_to_pfn(page));
+	up_read(&mm->mmap_sem);
 	return page;
 }
 
-- 
2.26.2.303.gf8c07b1a785-goog
