From: Mike Frysinger <vapier.adi@gmail.com>
Date: Tue, 25 May 2010 17:28:19 +0000
Subject: Re: [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix the unsafe usage of
Message-Id: <AANLkTilT3D8c86LYK2DxcNpM2F3D8iCbgY_sfUg8h58p@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100524234250.F158849A56@magilla.sf.frob.com> 
	<1266280229-18469-1-git-send-email-vapier@gentoo.org> <1274431345-22366-1-git-send-email-vapier@gentoo.org> 
	<20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com> 
	<20100522165320.GA19573@redhat.com> <25539.1274711817@redhat.com> 
	<20100524151445.GA6393@redhat.com> <17134.1274778852@redhat.com> 
	<20100525102345.GA23574@redhat.com>
In-Reply-To: <20100525102345.GA23574@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

On Tue, May 25, 2010 at 06:23, Oleg Nesterov wrote:
>        - arch/blackfin/kernel/ptrace.c:is_user_addr_valid()
>          needs mmap_sem around find_vma()
>
>          The lockless access to mm->context.sram_list doesn't look
>          safe to me.
>
>          If we add get_task_mm() - this protects us against
>          destroy_context() only. What is the tracee's sub-thread
>          does sys_sram_alloc() or sys_sram_free() in parallel?

i dont believe there are any code paths in UP systems where this would
be a practical problem because sram_list is only updated by syscalls
from userspace.  we probably should add proper locking to this
structure though.  i'll open a tracker item about it, thanks !
-mike
