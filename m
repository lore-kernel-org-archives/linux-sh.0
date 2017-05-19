From: riel@redhat.com
Date: Fri, 19 May 2017 21:26:33 +0000
Subject: [PATCH 2/5] fork,random: use get_random_canary to set tsk->stack_canary
Message-Id: <20170519212636.30440-3-riel@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170519212636.30440-1-riel@redhat.com>
In-Reply-To: <20170519212636.30440-1-riel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Rik van Riel <riel@redhat.com>

Use the ascii-armor canary to prevent unterminated C string overflows
from being able to successfully overwrite the canary, even if they
somehow obtain the canary value.

Inspired by execshield ascii-armor and PaX/grsecurity.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index aa1076c5e4a9..b3591e9250a8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -560,7 +560,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	set_task_stack_end_magic(tsk);
 
 #ifdef CONFIG_CC_STACKPROTECTOR
-	tsk->stack_canary = get_random_long();
+	tsk->stack_canary = get_random_canary();
 #endif
 
 	/*
-- 
2.9.3

