From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 28 Jul 2008 16:10:04 +0000
Subject: Re: sh kexec build error
Message-Id: <20080728161004.GH30612@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728130613.GB30612@cs181140183.pp.htv.fi> <20080728131444.GA15942@linux-sh.org>
In-Reply-To: <20080728131444.GA15942@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Huang Ying <ying.huang@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 28, 2008 at 10:14:44PM +0900, Paul Mundt wrote:
> On Mon, Jul 28, 2008 at 04:06:13PM +0300, Adrian Bunk wrote:
> > Commit 3ab83521378268044a448113c6aa9a9e245f4d2f (kexec jump)
> > causes the following build error on sh:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      kernel/kexec.o
> > {standard input}: Assembler messages:
> > {standard input}:1518: Error: offset to unaligned destination
> > make[2]: *** [kernel/kexec.o] Error 1
> > 
> > <--  snip  -->
> > 
> > If I understand the assembler correctly it fails at
> > include/asm-sh/kexec.h:59
> > 
> Indeed. This should fix it:


I can confirm that your patch fixes the compilation.


> diff --git a/include/asm-sh/processor_32.h b/include/asm-sh/processor_32.h
> index c6583f2..0dadd75 100644
> --- a/include/asm-sh/processor_32.h
> +++ b/include/asm-sh/processor_32.h
> @@ -19,7 +19,7 @@
>   * Default implementation of macro that returns current
>   * instruction pointer ("program counter").
>   */
> -#define current_text_addr() ({ void *pc; __asm__("mova	1f, %0\n1:":"=z" (pc)); pc; })
> +#define current_text_addr() ({ void *pc; __asm__("mova	1f, %0\n.align 2\n1:":"=z" (pc)); pc; })
>  
>  /* Core Processor Version Register */
>  #define CCN_PVR		0xff000030

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

