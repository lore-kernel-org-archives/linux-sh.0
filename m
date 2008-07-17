From: Stuart MENEFY <stuart.menefy@st.com>
Date: Thu, 17 Jul 2008 12:08:40 +0000
Subject: [PATCH] sh: Don't miss pending signals returning to user mode after
Message-Id: <487F3648.8040005@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: Don't miss pending signals returning to user mode after signal processing

Without this patch, signals sent during architecture specific signal
handling (typically as a result of the user's stack being inaccessible)
are ignored.

This is the SH version of commit c3ff8ec31c1249d268cd11390649768a12bec1b9
which was for the i386.

Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
---

  entry-common.S |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -195,7 +195,7 @@ work_resched:
  	.align	2
  1:	.long	schedule
  2:	.long	do_notify_resume
-3:	.long	restore_all
+3:	.long	resume_userspace
  #ifdef CONFIG_TRACE_IRQFLAGS
  4:	.long	trace_hardirqs_on
  5:	.long	trace_hardirqs_off
