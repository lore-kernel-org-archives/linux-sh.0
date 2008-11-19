From: michael <trimarchimichael@yahoo.it>
Date: Wed, 19 Nov 2008 13:23:04 +0000
Subject: Mutex fast-path implementation sh4a
Message-Id: <49241338.1010405@yahoo.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I'm not an expert of sh4 assembler instruction on gcc, but I figure out 
how to implement
the fastpath_lock and trylock, and I obtain this code:

static inline void
__mutex_fastpath_lock(atomic_t *count, void (*fail_fn)(atomic_t *))
{
        int __res;

        __asm__ __volatile__ (

                "movli.l        @%1, %0 \n\t"
                "dt             %0      \n\t"
                "movco.l        %0, @%1 \n\t"
                : "=&z" (__res)
                : "r" (&(count)->counter)
                : "t" );

        if (unlikely(__res != count->counter))
                fail_fn(count);
}

The retval function is very quite similar to this one. I don't find 
documentation about sh assembler,
can someone point me out to documentation?
The start point was the arm implementation and the 
arch/sh/include/asm/atomic-llsc.h file.

Can be a correct implementation?

Regards Michael


