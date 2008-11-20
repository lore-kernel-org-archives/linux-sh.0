From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 Nov 2008 04:43:34 +0000
Subject: Re: Mutex fast-path implementation sh4a
Message-Id: <20081120044334.GA28447@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49241338.1010405@yahoo.it>
In-Reply-To: <49241338.1010405@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 19, 2008 at 02:23:04PM +0100, michael wrote:
> Hi,
> 
> I'm not an expert of sh4 assembler instruction on gcc, but I figure out 
> how to implement
> the fastpath_lock and trylock, and I obtain this code:
> 
> static inline void
> __mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
> {
>        int __res;
> 
>        __asm__ __volatile__ (
> 
>                "movli.l        @%1, %0 \n\t"
>                "dt             %0      \n\t"
>                "movco.l        %0, @%1 \n\t"
>                : "=&z" (__res)
>                : "r" (&(count)->counter)
>                : "t" );
> 
>        if (unlikely(__res != count->counter))
>                fail_fn(count);
> }
> 
The assembly looks fine, but you probably want to change the __res test
to something like:

	if (unlikely(__res != 0))
		fail_fn(count);

Given that you already have the counter value implemented there. This
will save you an additional memory access due to the fact the atomic
counter is volatile.

When you are implementing this, you should also include the comment from
ARM, as the single-pass atomic sequence without looping semantics aren't
entirely obvious without it.

> The retval function is very quite similar to this one. I don't find 
> documentation about sh assembler,
> can someone point me out to documentation?

What sort of documentation are you looking for? A good start is the SH-4A
software manual, which you can find the pdf for from any SH-4A part
specification download. If you are particularly concerned about inline
assembly, then you need to look at the GCC manual for SH-specific
information. Anything else you can feel free to ask on the list.
