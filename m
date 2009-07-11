From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 11 Jul 2009 01:43:06 +0000
Subject: Re: [PATCH 2/3] sh: Function graph tracer support
Message-Id: <20090711014306.GB26706@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <b3aec4e1eb69eea102622f1bb30bd45608c4e787.1247272091.git.matt@console-pimps.org>
In-Reply-To: <b3aec4e1eb69eea102622f1bb30bd45608c4e787.1247272091.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jul 11, 2009 at 01:29:03AM +0100, Matt Fleming wrote:
> Add both dynamic and static function graph tracer support for sh.

On Sat, Jul 11, 2009 at 01:29:04AM +0100, Matt Fleming wrote:
> Annotate __switch_to() so that the function graph tracer does not try to
> trace it. Use __notrace_funcgraph, as opposed to notrace, so that other
> tracers can continue to trace __switch_to().
> 
> The reason that we don't want to trace __switch_to() with the function
> graph tracer is because of how the return address stack in task_struct
> is implemented. When we enter __switch_to we store the real return
> address on prev's ret_stack. When we return from __switch_to() we've
> patched the return address on the kernel stack to be
> return_to_handler. Calling return_to_handler we do,
> 
>        -> ftrace_return_to_handler()
>        	  -> ftrace_pop_return_ftrace()
> 
> Which tries to pop the real return address from current->ret_stack. The
> problem being that we stored the return address on prev->ret_stack, but
> current now points to next, and next->ret_stack doesn't contain the
> correct return address (and is possibly even empty).

On Sat, Jul 11, 2009 at 02:00:23AM +0100, Matt Fleming wrote:
> Enable kernel stack checking code in both the dynamic ftrace and mcount
> code paths. Check the stack to see if it's overflowing and make sure
> that the stack pointer contains an address that's either in init_stack
> or after the bss.

All applied with some minor tidying, thanks!
