From: Anton Vorontsov <anton.vorontsov@linaro.org>
Date: Sat, 24 Mar 2012 10:30:50 +0000
Subject: [PATCH 08/10] um: Fix possible race on task->mm
Message-Id: <20120324103050.GH29067@lizard>
List-Id: <linux-sh.vger.kernel.org>
References: <20120324102609.GA28356@lizard>
In-Reply-To: <20120324102609.GA28356@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Checking for task->mm is dangerous as ->mm might disappear (exit_mm()
assigns NULL under task_lock(), so tasklist lock is not enough).

We can't use get_task_mm()/mmput() pair as mmput() might sleep,
so let's take the task lock while we care about its mm.

Note that we should also use find_lock_task_mm() to check all process'
threads for a valid mm, but for uml we'll do it in a separate patch.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/um/kernel/reboot.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 66d754c..1411f4e 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -25,10 +25,13 @@ static void kill_off_processes(void)
 
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			if (p->mm = NULL)
+			task_lock(p);
+			if (!p->mm) {
+				task_unlock(p);
 				continue;
-
+			}
 			pid = p->mm->context.id.u.pid;
+			task_unlock(p);
 			os_kill_ptraced_process(pid, 1);
 		}
 		read_unlock(&tasklist_lock);
-- 
1.7.9.2

