From: Julia Lawall <julia@diku.dk>
Date: Fri, 26 Dec 2008 07:27:24 +0000
Subject: [PATCH 2/7] arch/sh/mm: Move a dereference below a NULL test
Message-Id: <Pine.LNX.4.64.0812260826540.25450@ask.diku.dk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

If the NULL test is necessary, then the dereference should be moved below
the NULL test.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/).

// <smpl>
@disable is_null@
identifier f;
expression E;
identifier fld;
statement S;
@@

+ if (E = NULL) S
  f(...,E->fld,...);
- if (E = NULL) S

@@
identifier f;
expression E;
identifier fld;
statement S;
@@

+ if (!E) S
  f(...,E->fld,...);
- if (!E) S
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/sh/mm/ioremap_64.c             |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/mm/ioremap_64.c b/arch/sh/mm/ioremap_64.c
index 6e0be24..fddcab4 100644
--- a/arch/sh/mm/ioremap_64.c
+++ b/arch/sh/mm/ioremap_64.c
@@ -71,9 +71,9 @@ void *__ioremap(unsigned long phys_addr, unsigned long size,
 	 * Ok, go for it..
 	 */
 	area = get_vm_area(size, VM_IOREMAP);
-	pr_debug("Get vm_area returns %p addr %p\n",area,area->addr);
 	if (!area)
 		return NULL;
+	pr_debug("Get vm_area returns %p addr %p\n", area, area->addr);
 	area->phys_addr = phys_addr;
 	addr = area->addr;
 	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
