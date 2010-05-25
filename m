From: David Howells <dhowells@redhat.com>
Date: Tue, 25 May 2010 12:24:00 +0000
Subject: Re: [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix the unsafe usage of child->mm
Message-Id: <20147.1274790240@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100525102345.GA23574@redhat.com> <20100524234250.F158849A56@magilla.sf.frob.com> <20100522165401.GB19573@redhat.com> <1266280229-18469-1-git-send-email-vapier@gentoo.org> <1274431345-22366-1-git-send-email-vapier@gentoo.org> <20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com> <25539.1274711817@redhat.com> <20100524151445.GA6393@redhat.com> <17134.1274778852@redhat.com> 
In-Reply-To: <20100525102345.GA23574@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> wrote:

> > Like PEEKTEXT and POKETEXT?
> 
> They use access_process_vm().

Which needs to get the mm:

	int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
	{
		struct vm_area_struct *vma;
		struct mm_struct *mm;

		if (addr + len < addr)
			return 0;

		mm = get_task_mm(tsk);
		if (!mm)
			return 0;

David
