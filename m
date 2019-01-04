From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 04 Jan 2019 03:18:57 +0000
Subject: [GIT PULL][PATCH] sh: ftrace: Fix missing parenthesis in WARN_ON()
Message-Id: <20190103221857.3458296b@vmware.local.home>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, kbuild test robot <lkp@intel.com>


Linus,

It appears that the zero-day bot did find a bug in my sh build.
And that I didn't have the bad code in my config file when I
cross compiled it, although there are a few other errors in sh
that makes it not build for me, I missed that I added one more.

I replaced WARN_ON(current->curr_ret_stack) with
 WARN_ON(ftrace_graph_get_ret_stack(current, 1) where it should be:
 WARN_ON(ftrace_graph_get_ret_stack(current, 1))


Please pull the latest trace-v4.21-1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.21-1

Tag SHA1: 0695bd08e48f3e80e08afb6ea256639a4e81624c
Head SHA1: dc56367cb5dbf9d593e4b12373489df9a7edb72c


Steven Rostedt (VMware) (1):
      sh: ftrace: Fix missing parenthesis in WARN_ON()

----
 arch/sh/kernel/dwarf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit dc56367cb5dbf9d593e4b12373489df9a7edb72c
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Jan 3 22:02:39 2019 -0500

    sh: ftrace: Fix missing parenthesis in WARN_ON()
    
    Adding a function inside a WARN_ON() didn't close the WARN_ON parathesis.
    
    Link: http://lkml.kernel.org/r/201901020958.28Mzbs0O%fengguang.wu@intel.com
    Cc: linux-sh@vger.kernel.org
    Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
    Cc: Rich Felker <dalias@libc.org>
    Reported-by: kbuild test robot <lkp@intel.com>
    Fixes: cec8d0e7f06e ("sh: ftrace: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index df0fd6efe758..00622598a245 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -619,7 +619,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 		 * than one patched return address on our stack,
 		 * complain loudly.
 		 */
-		WARN_ON(ftrace_graph_get_ret_stack(current, 1);
+		WARN_ON(ftrace_graph_get_ret_stack(current, 1));
 	}
 #endif
 
