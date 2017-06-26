From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 26 Jun 2017 22:17:49 +0000
Subject: [PATCH] sh/ftrace: Remove only user of ftrace_arch_read_dyn_info()
Message-Id: <20170626181749.2ce954d1@gandalf.local.home>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


I noticed that there's only one user of ftrace_arch_read_dyn_info().
That was used a while ago during the NMI updating in x86, and superh
copied it to implement its version of handling NMIs during
stop_machine().

But that is a debug feature, and this code hasn't been touched since
2009. Also, x86 no longer does the ftrace updates with stop_machine()
and instead uses breakpoints. If superh needs to modify its code, it
should implement the breakpoint conversion, and remove stop_machine().
Which also gets rid of the NMI issue.

Anyway, I want to nuke ftrace_arch_read_dyn_info() and this gets rid of
the one user, which is for an arch that shouldn't need it anymore.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---

[ With acks from the SUPERH maintainers, I can pull this through
  my own tree. ]

diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
index 5378397..d18724d 100644
--- a/arch/sh/kernel/ftrace.c
+++ b/arch/sh/kernel/ftrace.c
@@ -96,19 +96,6 @@ static int mod_code_status;		/* holds return value of text write */
 static void *mod_code_ip;		/* holds the IP to write to */
 static void *mod_code_newcode;		/* holds the text to write to the IP */
 
-static unsigned nmi_wait_count;
-static atomic_t nmi_update_count = ATOMIC_INIT(0);
-
-int ftrace_arch_read_dyn_info(char *buf, int size)
-{
-	int r;
-
-	r = snprintf(buf, size, "%u %u",
-		     nmi_wait_count,
-		     atomic_read(&nmi_update_count));
-	return r;
-}
-
 static void clear_mod_flag(void)
 {
 	int old = atomic_read(&nmi_running);
@@ -144,7 +131,6 @@ void arch_ftrace_nmi_enter(void)
 	if (atomic_inc_return(&nmi_running) & MOD_CODE_WRITE_FLAG) {
 		smp_rmb();
 		ftrace_mod_code();
-		atomic_inc(&nmi_update_count);
 	}
 	/* Must have previous changes seen before executions */
 	smp_mb();
@@ -165,8 +151,6 @@ static void wait_for_nmi_and_set_mod_flag(void)
 	do {
 		cpu_relax();
 	} while (atomic_cmpxchg(&nmi_running, 0, MOD_CODE_WRITE_FLAG));
-
-	nmi_wait_count++;
 }
 
 static void wait_for_nmi(void)
@@ -177,8 +161,6 @@ static void wait_for_nmi(void)
 	do {
 		cpu_relax();
 	} while (atomic_read(&nmi_running));
-
-	nmi_wait_count++;
 }
 
 static int
