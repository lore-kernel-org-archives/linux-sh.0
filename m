From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 02 Mar 2008 21:35:06 +0000
Subject: sh r7780mp_defconfig compile error
Message-Id: <20080302213506.GD25484@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stuart Menefy <stuart.menefy@st.com>, Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Commit d02b08f6e8b184ffef349e395210a5e82ff4f4bc causes the following 
compile error with r7780mp_defconfig:

<--  snip  -->

...
  CC      init/main.o
In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/clocksource.h:18,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/clockchips.h:13,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/tick.h:9,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/init/main.c:44:
include2/asm/io.h: In function '__ioremap_mode':
include2/asm/io.h:331: error: implicit declaration of function 'P1SEGADDR'
include2/asm/io.h:333: error: implicit declaration of function 'P2SEGADDR'
make[2]: *** [init/main.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

