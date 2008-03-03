From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 03 Mar 2008 15:38:43 +0000
Subject: sh sh7710voipgw_defconfig compile error
Message-Id: <20080303153843.GD26072@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

It seems commit 9a7ef6d59f9d4780ff5bc9c4d05266b52dcb9211 broke the 
support for this board:

<--  snip  -->

...
  CC      arch/sh/boards/renesas/sh7710voipgw/setup.o
arch/sh/boards/renesas/sh7710voipgw/setup.c:15: error: array type has incomplete element type
arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_IRQ' undeclared here (not in a function)
arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_IPR_ADDR' undeclared here (not in a function)
arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_IPR_POS' undeclared here (not in a function)
arch/sh/boards/renesas/sh7710voipgw/setup.c:16: error: 'TIMER2_PRIORITY' undeclared here (not in a function)
arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_IRQ' undeclared here (not in a function)
arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_IPR_ADDR' undeclared here (not in a function)
arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_IPR_POS' undeclared here (not in a function)
arch/sh/boards/renesas/sh7710voipgw/setup.c:17: error: 'WDT_PRIORITY' undeclared here (not in a function)
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

