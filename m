From: "Jeongdo Son" <sohn9086@gmail.com>
Date: Mon, 03 Mar 2008 08:53:50 +0000
Subject: Re: sh r7780mp_defconfig compile error
Message-Id: <59fd4ce80803030053k396a81f6ib3e2d41ad68886fb@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080302213506.GD25484@cs181133002.pp.htv.fi>
In-Reply-To: <20080302213506.GD25484@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

I had the same compile error.
I traced the source and noticed that P#SEGADDR are only defined when
CONFIG_PMB is NOT selected.
If your system is not using physical 32-bit addressing function by
SH-4A PMB, setting off the CONFIG_PMB can be a solution.
I think some dummy macros should be added to avoid this compile error.

Regards,
Jeongdo Son

On Mon, Mar 3, 2008 at 6:35 AM, Adrian Bunk <bunk@kernel.org> wrote:
> Commit d02b08f6e8b184ffef349e395210a5e82ff4f4bc causes the following
>  compile error with r7780mp_defconfig:
>
>  <--  snip  -->
>
>  ...
>   CC      init/main.o
>  In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/clocksource.h:18,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/clockchips.h:13,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/tick.h:9,
>                  from /home/bunk/linux/kernel-2.6/git/linux-2.6/init/main.c:44:
>  include2/asm/io.h: In function '__ioremap_mode':
>  include2/asm/io.h:331: error: implicit declaration of function 'P1SEGADDR'
>  include2/asm/io.h:333: error: implicit declaration of function 'P2SEGADDR'
>  make[2]: *** [init/main.o] Error 1
>
>  <--  snip  -->
>
>  cu
>  Adrian
>
>  --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
