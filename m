From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 01 May 2016 05:08:25 +0000
Subject: [PATCH RESEND 01/12] sh: Fix typo
Message-Id: <1462079316-27771-2-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

BL is 1 in this time.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/head_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 974bc15..14da954 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -59,7 +59,7 @@ ENTRY(empty_zero_page)
  */
 ENTRY(_stext)
 	!			Initialize Status Register
-	mov.l	1f, r0		! MD=1, RB=0, BL=0, IMASK=0xF
+	mov.l	1f, r0		! MD=1, RB=0, BL=1, IMASK=0xF
 	ldc	r0, sr
 	!			Initialize global interrupt mask
 #ifdef CONFIG_CPU_HAS_SR_RB
-- 
2.7.0

