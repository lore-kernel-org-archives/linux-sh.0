From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Oct 2012 02:08:55 +0000
Subject: __raw_xxx() :: compile warning on sh-arm
Message-Id: <87626ccwr2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Simon, Magnus

Current linus/master tree has compile warning on __raw_xxx() if it was "sh-arm" kernel.
It doesn't happen on "sh" kernel.

I guess it from
195bbcac2e5c12f7fb99cdcc492c3000c5537f4a
(ARM: 7500/1: io: avoid writeback addressing modes for __raw_ accessors)

---- ${LINUX}/drivers/sh/intc/chip.c ---------------

${LINUX}/drivers/sh/intc/chip.c: In function 'intc_mask_ack':
${LINUX}/drivers/sh/intc/chip.c:99:4: warning: passing argument 1 of '__raw_readb' makes pointer from integer without a cast [enabled by default]
In file included from ${LINUX}/include/linux/io.h:22:0,
                 from ${LINUX}/drivers/sh/intc/chip.c:13:
${LINUX}/arch/arm/include/asm/io.h:95:18: note: expected 'const volatile void *' but argument is of type 'long unsigned int'
${LINUX}/drivers/sh/intc/chip.c:100:4: warning: passing argument 2 of '__raw_writeb' makes pointer from integer without a cast [enabled by default]
In file included from ${LINUX}/include/linux/io.h:22:0,
                 from ${LINUX}/drivers/sh/intc/chip.c:13:
${LINUX}/arch/arm/include/asm/io.h:81:20: note: expected 'volatile void *' but argument is of type 'long unsigned int'
${LINUX}/drivers/sh/intc/chip.c:103:4: warning: passing argument 1 of '__raw_readw' makes pointer from integer without a cast [enabled by default]
In file included from ${LINUX}/include/linux/io.h:22:0,
                 from ${LINUX}/drivers/sh/intc/chip.c:13:
${LINUX}/arch/arm/include/asm/io.h:71:19: note: expected 'const volatile void *' but argument is of type 'long unsigned int'
${LINUX}/drivers/sh/intc/chip.c:104:4: warning: passing argument 2 of '__raw_writew' makes pointer from integer without a cast [enabled by default]
In file included from ${LINUX}/include/linux/io.h:22:0,
....

----- ${LINUX}/drivers/tty/serial/sh-sci.c -----------

${LINUX}/drivers/tty/serial/sh-sci.c:533:2: warning: passing argument 1 of '__raw_readb' makes pointer from integer without a cast [enabled by default]
In file included from ${LINUX}/include/linux/scatterlist.h:10:0,
                 from ${LINUX}/include/linux/dmaengine.h:27,
                 from ${LINUX}/include/linux/sh_dma.h:13,
                 from ${LINUX}/drivers/tty/serial/sh-sci.c:28:
${LINUX}/arch/arm/include/asm/io.h:95:18: note: expected 'const volatile void *' but argument is of type 'int'


Best regards
---
Kuninori Morimoto
