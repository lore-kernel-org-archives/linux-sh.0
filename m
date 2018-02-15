From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Feb 2018 15:17:34 +0000
Subject: [PATCH 4.4 097/108] signal/sh: Ensure si_signo is initialized in do_divide_error
Message-Id: <20180215151235.853108888@linuxfoundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180215151222.267507937@linuxfoundation.org>
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 0e88bb002a9b2ee8cc3cc9478ce2dc126f849696 upstream.

Set si_signo.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Fixes: 0983b31849bb ("sh: Wire up division and address error exceptions on SH-2A.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sh/kernel/traps_32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -607,7 +607,8 @@ asmlinkage void do_divide_error(unsigned
 		break;
 	}
 
-	force_sig_info(SIGFPE, &info, current);
+	info.si_signo = SIGFPE;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
 


