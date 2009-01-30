From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 30 Jan 2009 10:28:54 +0000
Subject: [PATCH] fix build failure w. gcc-4.3.3
Message-Id: <20090130102854.GA13640@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

gcc-4.3.3 likes to have printf() and related functions to have
at least 2 arguments when the format string is not a constant:

cc1: warnings being treated as error
arch/sh/kernel/setup.c: In function 'early_parse_mem':
arch/sh/kernel/setup.c:111: error: format not a string literal and no format arguments

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/sh/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 5342475..72a08f6 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -108,7 +108,7 @@ static int __init early_parse_mem(char *p)
 			"is not allowed.\n"
 			"  Recompile the kernel with the correct value for "
 			"CONFIG_MEMORY_SIZE.\n";
-		printk(msg);
+		printk("%s", msg);
 		return 0;
 	}
 
-- 
1.6.1.1

