From: Oleg Nesterov <oleg@redhat.com>
Date: Wed, 26 May 2010 12:40:06 +0000
Subject: Re: [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix the unsafe usage
Message-Id: <20100526124006.GA28358@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1266280229-18469-1-git-send-email-vapier@gentoo.org> <1274431345-22366-1-git-send-email-vapier@gentoo.org> <20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com> <25539.1274711817@redhat.com> <20100524151445.GA6393@redhat.com> <17134.1274778852@redhat.com> <20100525102345.GA23574@redhat.com> <AANLkTilT3D8c86LYK2DxcNpM2F3D8iCbgY_sfUg8h58p@mail.gmail.com>
In-Reply-To: <AANLkTilT3D8c86LYK2DxcNpM2F3D8iCbgY_sfUg8h58p@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

On 05/25, Mike Frysinger wrote:
>
> On Tue, May 25, 2010 at 06:23, Oleg Nesterov wrote:
> > =A0 =A0 =A0 =A0- arch/blackfin/kernel/ptrace.c:is_user_addr_valid()
> > =A0 =A0 =A0 =A0 =A0needs mmap_sem around find_vma()
> >
> > =A0 =A0 =A0 =A0 =A0The lockless access to mm->context.sram_list doesn't=
 look
> > =A0 =A0 =A0 =A0 =A0safe to me.
> >
> > =A0 =A0 =A0 =A0 =A0If we add get_task_mm() - this protects us against
> > =A0 =A0 =A0 =A0 =A0destroy_context() only. What is the tracee's sub-thr=
ead
> > =A0 =A0 =A0 =A0 =A0does sys_sram_alloc() or sys_sram_free() in parallel?
>
> i dont believe there are any code paths in UP systems where this would
> be a practical problem because sram_list is only updated by syscalls
> from userspace.

Yes sure, UP && !PREEMPT is safe.

> we probably should add proper locking to this
> structure though.

Agreed. I'll try to make the trivial patch tomorrow. I think we
can just use mm->mmap_sem, is_user_addr_valid() needs this lock
for find_vma() anyway.

Oleg.

