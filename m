From: David Howells <dhowells@redhat.com>
Date: Fri, 01 Aug 2008 14:01:19 +0000
Subject: Re: [PATCH 2/3] binfmt_elf_fdpic: Convert initial stack alignment to arch_align_stack().
Message-Id: <27552.1217599279@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728150501.GC16555@linux-sh.org> <20080728150359.GA16555@linux-sh.org> <20080728150430.GB16555@linux-sh.org>
In-Reply-To: <20080728150501.GC16555@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> wrote:

> +	 * In some cases (e.g. Hyper-Threading), we want to avoid L1
> +	 * evictions by the processes running on the same package. One
> +	 * thing we can do is to shuffle the initial stack for them, so
> +	 * we give the architecture an opportunity to do so here.
> +	 */
>  #ifdef CONFIG_MMU
> -	sp = bprm->p;
> +	sp = arch_align_stack(bprm->p);
>  #else
> -	sp = mm->start_stack;
> +	sp = arch_align_stack(mm->start_stack);

Ummm...  You're calling arch_align_stack() under NOMMU...  Is that really a
good idea?

You can't necessarily move the stack pointer without exiting the allocated
region or shrinking the amount of stack space the executable asked for.  If
you want to do this sort of thing, you need to tell the memory allocator what
you're up to - or at the very least allocate some slack.

David
