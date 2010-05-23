From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sun, 23 May 2010 20:02:06 +0000
Subject: [PATCH 179/199] arch/sh/lib/strlen.S: Checkpatch cleanup
Message-Id: <1274644930-26600-22-git-send-email-andrea.gelmini@gelma.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

arch/sh/lib/strlen.S:38: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sh/lib/strlen.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/lib/strlen.S b/arch/sh/lib/strlen.S
index f8ab296..1bcc13f 100644
--- a/arch/sh/lib/strlen.S
+++ b/arch/sh/lib/strlen.S
@@ -35,7 +35,7 @@ ENTRY(strlen)
 	mov.b	@r4+,r1
 	tst	r1,r1
 	bt	8f
-	add	#1,r2	
+	add	#1,r2
 
 1:
 	mov	#0,r3
-- 
1.7.1.251.gf80a2

