From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 12 Jul 2012 11:04:53 +0000
Subject: [PATCH] fork: fix error handling in dup_task()
Message-Id: <1342091093-1909-1-git-send-email-akinobu.mita@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>

The function dup_task() may fail at the following function calls in
the following order.

0) alloc_task_struct_node()
1) alloc_thread_info_node()
2) arch_dup_task_struct()

Error by 0) is not a matter, it can just return.  But error by 1)
requires releasing task_struct allocated by 0) before it returns.
Likewise, error by 2) requires releasing task_struct and thread_info
allocated by 0) and 1).

The existing error handling calls free_task_struct() and
free_thread_info() which do not only release task_struct and
thread_info, but also call architecture specific
arch_release_task_struct() and arch_release_thread_info().

The problem is that task_struct and thread_info are not fully
initialized yet at this point, but arch_release_task_struct() and
arch_release_thread_info() are called with them.

For example, x86 defines its own arch_release_task_struct() that
releases a task_xstate.  If alloc_thread_info_node() fails in
dup_task(), arch_release_task_struct() is called with task_struct
which is just allocated and filled with garbage in this error handling.

This actually happened with tools/testing/fault-injection/failcmd.sh

	# env FAILCMD_TYPE=FAil_page_alloc \
		./tools/testing/fault-injection/failcmd.sh --times=100 \
		--min-order=3D0 --ignore-gfp-wait=3D0 \
		-- make -C tools/testing/selftests/ run_tests

In order to fix this issue, make free_{task_struct,thread_info}() not
to call arch_release_{task_struct,thread_info}() and call
arch_release_{task_struct,thread_info}() implicitly where needed.

Default arch_release_task_struct() and arch_release_thread_info() are
defined as empty by default.  So this change only affects the
architectures which implement their own arch_release_task_struct() or
arch_release_thread_info() as listed below.

arch_release_task_struct(): x86, sh
arch_release_thread_info(): mn10300, tile

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: linux-am33-list@redhat.com
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 kernel/fork.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ab5211b..fb4a3e2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -114,6 +114,8 @@ int nr_processes(void)
 	return total;
 }
=20
+void __weak arch_release_task_struct(struct task_struct *tsk) { }
+
 #ifndef CONFIG_ARCH_TASK_STRUCT_ALLOCATOR
 static struct kmem_cache *task_struct_cachep;
=20
@@ -122,18 +124,16 @@ static inline struct task_struct *alloc_task_struct_n=
ode(int node)
 	return kmem_cache_alloc_node(task_struct_cachep, GFP_KERNEL, node);
 }
=20
-void __weak arch_release_task_struct(struct task_struct *tsk) { }
-
 static inline void free_task_struct(struct task_struct *tsk)
 {
-	arch_release_task_struct(tsk);
 	kmem_cache_free(task_struct_cachep, tsk);
 }
 #endif
=20
-#ifndef CONFIG_ARCH_THREAD_INFO_ALLOCATOR
 void __weak arch_release_thread_info(struct thread_info *ti) { }
=20
+#ifndef CONFIG_ARCH_THREAD_INFO_ALLOCATOR
+
 /*
  * Allocate pages if THREAD_SIZE is >=3D PAGE_SIZE, otherwise use a
  * kmemcache based allocator.
@@ -150,7 +150,6 @@ static struct thread_info *alloc_thread_info_node(struc=
t task_struct *tsk,
=20
 static inline void free_thread_info(struct thread_info *ti)
 {
-	arch_release_thread_info(ti);
 	free_pages((unsigned long)ti, THREAD_SIZE_ORDER);
 }
 # else
@@ -164,7 +163,6 @@ static struct thread_info *alloc_thread_info_node(struc=
t task_struct *tsk,
=20
 static void free_thread_info(struct thread_info *ti)
 {
-	arch_release_thread_info(ti);
 	kmem_cache_free(thread_info_cache, ti);
 }
=20
@@ -205,10 +203,12 @@ static void account_kernel_stack(struct thread_info *=
ti, int account)
 void free_task(struct task_struct *tsk)
 {
 	account_kernel_stack(tsk->stack, -1);
+	arch_release_thread_info(tsk->stack);
 	free_thread_info(tsk->stack);
 	rt_mutex_debug_task_free(tsk);
 	ftrace_graph_exit_task(tsk);
 	put_seccomp_filter(tsk);
+	arch_release_task_struct(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -298,14 +298,12 @@ static struct task_struct *dup_task_struct(struct tas=
k_struct *orig)
 		return NULL;
=20
 	ti =3D alloc_thread_info_node(tsk, node);
-	if (!ti) {
-		free_task_struct(tsk);
-		return NULL;
-	}
+	if (!ti)
+		goto free_tsk;
=20
 	err =3D arch_dup_task_struct(tsk, orig);
 	if (err)
-		goto out;
+		goto free_ti;
=20
 	tsk->stack =3D ti;
=20
@@ -333,8 +331,9 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig)
=20
 	return tsk;
=20
-out:
+free_ti:
 	free_thread_info(ti);
+free_tsk:
 	free_task_struct(tsk);
 	return NULL;
 }
--=20
1.7.10.4

