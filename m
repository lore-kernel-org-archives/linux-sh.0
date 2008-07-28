From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 28 Jul 2008 20:20:12 +0000
Subject: drivers/sh/maple/maple.c compile error
Message-Id: <20080728202012.GD7713@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 306cfd630a4d121cf4e08b894d8b4c4cf106e57e
(maple: tidy maple_driver code by removing redundant connect/disconnect)
causes the following compile error:

<--  snip  -->

...
  CC      drivers/sh/maple/maple.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c: In function 'attach_matching_maple_driver':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c:259: error: 'struct maple_driver' has no member named 'connect'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c: In function 'maple_detach_driver':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c:272: error: 'struct maple_driver' has no member named 'disconnect'
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/sh/maple/maple.c:273: error: 'struct maple_driver' has no member named 'disconnect'
make[4]: *** [drivers/sh/maple/maple.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

