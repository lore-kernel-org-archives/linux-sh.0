From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 Jan 2015 20:32:28 +0000
Subject: [PATCH] next: sh: Fix compile error
Message-Id: <1420662748-28129-1-git-send-email-linux@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Commit a91ed664749c ("kernel: tighten rules for ACCESS ONCE") results in a
compile failure for sh builds with CONFIG_X2TLB enabled.

arch/sh/mm/gup.c: In function 'gup_get_pte':
arch/sh/mm/gup.c:20:2: error: invalid initializer
make[1]: *** [arch/sh/mm/gup.o] Error 1

Replace ACCESS_ONCE with READ_ONCE to fix the problem.

Fixes: a91ed664749c ("kernel: tighten rules for ACCESS ONCE")
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested only.

 arch/sh/mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/gup.c b/arch/sh/mm/gup.c
index 37458f3..e113bb4 100644
--- a/arch/sh/mm/gup.c
+++ b/arch/sh/mm/gup.c
@@ -17,7 +17,7 @@
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
 #ifndef CONFIG_X2TLB
-	return ACCESS_ONCE(*ptep);
+	return READ_ONCE(*ptep);
 #else
 	/*
 	 * With get_user_pages_fast, we walk down the pagetables without
-- 
2.1.0

