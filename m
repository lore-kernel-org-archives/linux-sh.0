From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 24 Mar 2011 05:47:40 +0000
Subject: [PATCH] sh: Fix build alloc_thread_info_node function
Message-Id: <1300945660-8323-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, eric.dumazet@gmail.com, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

By commit b6a84016bd2598e35ead635147fa53619982648d,
alloc_thread_info was replaced by alloc_thread_info_node.
However, the change of the function name and the addition of the argument
were incomplete.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
CC: Eric Dumazet <eric.dumazet@gmail.com>
---
 arch/sh/kernel/process.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index f39ad57..325f98b 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -32,7 +32,7 @@ void free_thread_xstate(struct task_struct *tsk)
 #if THREAD_SHIFT < PAGE_SHIFT
 static struct kmem_cache *thread_info_cache;
 
-struct thread_info *alloc_thread_info(struct task_struct *tsk, int node)
+struct thread_info *alloc_thread_info_node(struct task_struct *tsk, int node)
 {
 	struct thread_info *ti;
 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -57,7 +57,7 @@ void thread_info_cache_init(void)
 					      THREAD_SIZE, SLAB_PANIC, NULL);
 }
 #else
-struct thread_info *alloc_thread_info(struct task_struct *tsk)
+struct thread_info *alloc_thread_info_node(struct task_struct *tsk, int node)
 {
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	gfp_t mask = GFP_KERNEL | __GFP_ZERO;
-- 
1.7.2.3

