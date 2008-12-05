From: Nick Andrew <nick@nick-andrew.net>
Date: Fri, 05 Dec 2008 03:07:57 +0000
Subject: [PATCH] Fix incorrect use of loose in c-checksum.c
Message-Id: <20081205030757.31846.86233.stgit@marcab.local.tull.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harvey Harrison <harvey.harrison@gmail.com>, Nick Andrew <nick@nick-andrew.net>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Fix incorrect use of loose in c-checksum.c

It should be 'lose', not 'loose'.

Signed-off-by: Nick Andrew <nick@nick-andrew.net>
---

 arch/sh/lib64/c-checksum.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/arch/sh/lib64/c-checksum.c b/arch/sh/lib64/c-checksum.c
index 5c284e0..73c0877 100644
--- a/arch/sh/lib64/c-checksum.c
+++ b/arch/sh/lib64/c-checksum.c
@@ -35,7 +35,7 @@ static inline unsigned short foldto16(unsigned long x)
 
 static inline unsigned short myfoldto16(unsigned long long x)
 {
-	/* Fold down to 32-bits so we don't loose in the typedef-less
+	/* Fold down to 32-bits so we don't lose in the typedef-less
 	   network stack.  */
 	/* 64 to 33 */
 	x = (x & 0xffffffff) + (x >> 32);
@@ -199,7 +199,7 @@ __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 	result = (__force u64) saddr + (__force u64) daddr +
 		 (__force u64) sum + ((len + proto) << 8);
 
-	/* Fold down to 32-bits so we don't loose in the typedef-less
+	/* Fold down to 32-bits so we don't lose in the typedef-less
 	   network stack.  */
 	/* 64 to 33 */
 	result = (result & 0xffffffff) + (result >> 32);


