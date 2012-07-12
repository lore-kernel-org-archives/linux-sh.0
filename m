From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 12 Jul 2012 22:06:23 +0000
Subject: Re: [PATCH] fork: fix error handling in dup_task()
Message-Id: <20120712150623.06b2f71e.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1342091093-1909-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1342091093-1909-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Salman Qazi <sqazi@google.com>

On Thu, 12 Jul 2012 20:04:53 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The function dup_task() may fail at the following function calls in
> the following order.
>=20
> 0) alloc_task_struct_node()
> 1) alloc_thread_info_node()
> 2) arch_dup_task_struct()
>=20
> Error by 0) is not a matter, it can just return.  But error by 1)
> requires releasing task_struct allocated by 0) before it returns.
> Likewise, error by 2) requires releasing task_struct and thread_info
> allocated by 0) and 1).
>=20
> The existing error handling calls free_task_struct() and
> free_thread_info() which do not only release task_struct and
> thread_info, but also call architecture specific
> arch_release_task_struct() and arch_release_thread_info().
>=20
> The problem is that task_struct and thread_info are not fully
> initialized yet at this point, but arch_release_task_struct() and
> arch_release_thread_info() are called with them.
>=20
> For example, x86 defines its own arch_release_task_struct() that
> releases a task_xstate.  If alloc_thread_info_node() fails in
> dup_task(), arch_release_task_struct() is called with task_struct
> which is just allocated and filled with garbage in this error handling.
>=20
> This actually happened with tools/testing/fault-injection/failcmd.sh
>=20
> 	# env FAILCMD_TYPE=FAil_page_alloc \
> 		./tools/testing/fault-injection/failcmd.sh --times=100 \
> 		--min-order=3D0 --ignore-gfp-wait=3D0 \
> 		-- make -C tools/testing/selftests/ run_tests
>=20
> In order to fix this issue, make free_{task_struct,thread_info}() not
> to call arch_release_{task_struct,thread_info}() and call
> arch_release_{task_struct,thread_info}() implicitly where needed.
>=20
> Default arch_release_task_struct() and arch_release_thread_info() are
> defined as empty by default.  So this change only affects the
> architectures which implement their own arch_release_task_struct() or
> arch_release_thread_info() as listed below.

This conflicts with Salman's fix (below) which is in linux-next via
Ingo's tree.

It appears that we should drop Salman's patch altogether and use yours?


commit 164c33c6adee609b8b9062cce4c10f764d0dce13
Author:     Salman Qazi <sqazi@google.com>
AuthorDate: Mon Jun 25 18:18:15 2012 -0700
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Thu Jul 5 20:57:32 2012 +0200

    sched: Fix fork() error path to not crash
   =20
    In dup_task_struct(), if arch_dup_task_struct() fails, the clean up
    code fails to clean up correctly.  That's because the clean up
    code depends on unininitalized ti->task pointer.  We fix this
    by making sure that the task and thread_info know about each other
    before we attempt to take the error path.
   =20
    Signed-off-by: Salman Qazi <sqazi@google.com>
    Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Link: http://lkml.kernel.org/r/20120626011815.11323.5533.stgit@dungbeet=
le.mtv.corp.google.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/kernel/fork.c b/kernel/fork.c
index ab5211b..f00e319 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -304,12 +304,17 @@ static struct task_struct *dup_task_struct(struct tas=
k_struct *orig)
 	}
=20
 	err =3D arch_dup_task_struct(tsk, orig);
-	if (err)
-		goto out;
=20
+	/*
+	 * We defer looking at err, because we will need this setup
+	 * for the clean up path to work correctly.
+	 */
 	tsk->stack =3D ti;
-
 	setup_thread_stack(tsk, orig);
+
+	if (err)
+		goto out;
+
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	stackend =3D end_of_stack(tsk);

