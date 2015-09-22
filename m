From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Tue, 22 Sep 2015 21:46:51 +0000
Subject: [PATCH] sh: add copy_user_page() alias for __copy_user()
Message-Id: <1442958411-4271-1-git-send-email-ross.zwisler@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442958259-3956-1-git-send-email-ross.zwisler@linux.intel.com>
In-Reply-To: <1442958259-3956-1-git-send-email-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthew Wilcox <willy@linux.intel.com>, linux-fsdevel@vger.kernel.org

copy_user_page() is needed by DAX.  Without this we get a compile error
for DAX on SH:

fs/dax.c:280:2: error: implicit declaration of function ‘copy_user_page’
[-Werror=implicit-function-declaration]
  copy_user_page(vto, (void __force *)vfrom, vaddr, to);
    ^

This was done with a random config that happened to include DAX support.

This patch has only been compile tested.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Apologies for the resend, I wanted to add some more recipients.
---
 arch/sh/include/asm/page.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index fe20d14..ceb5201 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -59,6 +59,7 @@ pages_do_alias(unsigned long addr1, unsigned long addr2)
 
 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
 extern void copy_page(void *to, void *from);
+#define copy_user_page(to, from, vaddr, pg)  __copy_user(to, from, PAGE_SIZE)
 
 struct page;
 struct vm_area_struct;
-- 
2.1.0

