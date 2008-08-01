From: Adrian Bunk <bunk@kernel.org>
Date: Fri, 01 Aug 2008 21:27:28 +0000
Subject: sh O= builds broken
Message-Id: <20080801212728.GF19682@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org, lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Most likely caused by the headers move:

<--  snip  -->

...
  CC      init/main.o
In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/irq.h:4,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/irq.h:23,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/hardirq.h:5,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/hardirq.h:7,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/asm-generic/local.h:5,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/local.h:4,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/module.h:19,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/init/main.c:13:
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/include/asm/machvec.h:15:27: 
error: asm/machtypes.h: No such file or directory
make[2]: *** [init/main.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

