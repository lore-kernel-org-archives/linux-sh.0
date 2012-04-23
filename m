From: Anton Vorontsov <anton.vorontsov@linaro.org>
Date: Mon, 23 Apr 2012 07:09:43 +0000
Subject: [PATCH 9/9] um: Properly check all process' threads for a live mm
Message-Id: <20120423070943.GI30752@lizard>
List-Id: <linux-sh.vger.kernel.org>
References: <20120423070641.GA27702@lizard>
In-Reply-To: <20120423070641.GA27702@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

kill_off_processes() might miss a valid process, this is because
checking for process->mm is not enough. Process' main thread may
exit or detach its mm via use_mm(), but other threads may still
have a valid mm.

To catch this we use find_lock_task_mm(), which walks up all
threads and returns an appropriate task (with task lock held).

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/um/kernel/reboot.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 1411f4e..3d15243 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -6,6 +6,7 @@
 #include "linux/sched.h"
 #include "linux/spinlock.h"
 #include "linux/slab.h"
+#include "linux/oom.h"
 #include "kern_util.h"
 #include "os.h"
 #include "skas.h"
@@ -25,13 +26,13 @@ static void kill_off_processes(void)
 
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			task_lock(p);
-			if (!p->mm) {
-				task_unlock(p);
+			struct task_struct *t;
+
+			t = find_lock_task_mm(p);
+			if (!t)
 				continue;
-			}
-			pid = p->mm->context.id.u.pid;
-			task_unlock(p);
+			pid = t->mm->context.id.u.pid;
+			task_unlock(t);
 			os_kill_ptraced_process(pid, 1);
 		}
 		read_unlock(&tasklist_lock);
-- 
1.7.9.2
