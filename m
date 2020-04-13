From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 13 Apr 2020 16:15:42 +0000
Subject: [PATCH] sh: mm: Fix build error
Message-Id: <20200413161542.78700-1-linux@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Logan Gunthorpe <logang@deltatee.com>, Stephen Rothwell <sfr@canb.auug.org.au>

  415 |  if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
      |     ^
arch/sh/mm/init.c:424:1: error: expected expression before '}' token
  424 | }

Obviously never even compile tested.

Fixes: a332976e0184 ("mm/memory_hotplug: add pgprot_t to mhp_params")
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index b9de2d4fa57e..8d2a68aea1fc 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
-	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
+	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
 	/* We only have ZONE_NORMAL, so this is easy.. */
-- 
2.17.1
