From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 08 May 2008 21:42:13 +0000
Subject: Re: sh migor_defconfig build breakage
Message-Id: <20080508214213.GE22887@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
References: <20080508203949.GC22887@cs181133002.pp.htv.fi> <48236E59.8070400@sgi.com> <4823711D.70401@sgi.com>
In-Reply-To: <4823711D.70401@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 08, 2008 at 02:31:09PM -0700, Mike Travis wrote:
> Mike Travis wrote:
> > Adrian Bunk wrote:
> >> Commit aa6b54461cc5c0019b9d792adf3176b444c10763
> >> (asm-generic: add node_to_cpumask_ptr macro)
> >> causes the following build error with migor_defconfig:
> >>
> >> <--  snip  -->
> >>
> >> ...
> >>   CC      arch/sh/kernel/asm-offsets.s
> >> In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mm.h:8,
> >>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/asm-offsets.c:13:
> >> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/gfp.h: In function 'alloc_pages_node':
> >> /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/gfp.h:190: 
> >> error: implicit declaration of function 'cpu_to_node'
> >> make[2]: *** [arch/sh/kernel/asm-offsets.s] Error 1
> >>
> >> <--  snip  -->
> >>
> >> cu
> >> Adrian
> >>
> > 
> > Hi Adrian,
> > 
> > Thanks for the feedback, I'll cross-compile test this config.
> > 
> > Mike
> 
> 
> Ouch.  I just discovered I don't have a cross-compiler for 'sh'.  Can you point me
> towards one?

Mine are self-built.

The LinuxSH project offers binary ones at
  http://www.linux-sh.org

> Thanks,
> Mike

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

