From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 08 May 2008 22:03:34 +0000
Subject: sh cayman_defconfig build error
Message-Id: <20080508220334.GF22887@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

With recent gcc versions (I'm using 4.3) the compilation of 
cayman_defconfig fails with the following error:

<--  snip  -->

...
  CC      arch/sh/kernel/signal_64.o
cc1: warnings being treated as errors
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/signal_64.c: In function 'setup_frame':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/signal_64.c:477: error: cast from pointer to integer of different size
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/signal_64.c: In function 'setup_rt_frame':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/signal_64.c:595: error: cast from pointer to integer of different size
make[2]: *** [arch/sh/kernel/signal_64.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

