From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Date: Tue, 24 May 2016 13:19:35 +0000
Subject: [PATCH] sh: smp: Add missing FROZEN hotplug notifier transitions
Message-Id: <1464095975-56587-1-git-send-email-anna-maria@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

The corresponding FROZEN hotplug notifier transitions used on
suspend/resume are ignored. Therefore the switch case action argument
is masked with the frozen hotplug notifier transition mask.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/sh/kernel/cpu/sh4a/smp-shx3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
@@ -127,7 +127,7 @@ shx3_cpu_callback(struct notifier_block
 {
 	unsigned int cpu = (unsigned int)hcpu;
 
-	switch (action) {
+	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_UP_PREPARE:
 		shx3_update_boot_vector(cpu);
 		break;
