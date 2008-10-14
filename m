From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 14 Oct 2008 18:39:36 +0000
Subject: sh/boards/mach-migor/setup.c build error
Message-Id: <20081014183936.GB4710@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Herbrechtsmeier <hbmeier@hni.uni-paderborn.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mauro Carvalho Chehab <mchehab@redhat.com>, lethal@linux-sh.org
Cc: Magnus Damm <damm@igel.co.jp>, video4linux-list@redhat.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Commit 81034663159f39d005316b5c139038459cd16721
(V4L/DVB (8687): soc-camera: Move .power and .reset from
 soc_camera host to sensor driver) causes the following build error:

<--  snip  -->

...
  CC      arch/sh/boards/mach-migor/setup.o
arch/sh/boards/mach-migor/setup.c:408: error: unknown field 'enable_camera' specified in initializer
arch/sh/boards/mach-migor/setup.c:408: warning: excess elements in struct initializer
arch/sh/boards/mach-migor/setup.c:408: warning: (near initialization for 'sh_mobile_ceu_info')
arch/sh/boards/mach-migor/setup.c:409: error: unknown field 'disable_camera' specified in initializer
arch/sh/boards/mach-migor/setup.c:409: warning: excess elements in struct initializer
arch/sh/boards/mach-migor/setup.c:409: warning: (near initialization for 'sh_mobile_ceu_info')
make[2]: *** [arch/sh/boards/mach-migor/setup.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

