From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 30 May 2018 10:52:41 +0000
Subject: [PATCH 3.2 036/153] signal/sh: Ensure si_signo is initialized in do_divide_error
Message-Id: <lsq.1527677561.204017648@decadent.org.uk>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 0e88bb002a9b2ee8cc3cc9478ce2dc126f849696 upstream.

Set si_signo.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Fixes: 0983b31849bb ("sh: Wire up division and address error exceptions on SH-2A.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sh/kernel/traps_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -706,7 +706,8 @@ asmlinkage void do_divide_error(unsigned
 		break;
 	}
 
-	force_sig_info(SIGFPE, &info, current);
+	info.si_signo = SIGFPE;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
 

