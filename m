From: Fabian Frederick <fabf@skynet.be>
Date: Thu, 31 Jul 2014 21:21:40 +0000
Subject: SH 7619 CHCR values
Message-Id: <760230076.57448.1406841700324.open-xchange@webmail.nmp.skynet.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: richard@nod.at, pebolle@tiscali.nl
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

 Could you tell me where I could find SH 7619 CHCR values in order to solve the
following errors ?     

arch/sh/drivers/dma/dma-sh.c: In function 'calc_xmit_shift':
arch/sh/drivers/dma/dma-sh.c:97:21: error: 'CHCR_TS_LOW_MASK' undeclared (first
use in this function)
arch/sh/drivers/dma/dma-sh.c:97:21: note: each undeclared identifier is reported
only once for each function it appears in
arch/sh/drivers/dma/dma-sh.c:97:42: error: 'CHCR_TS_LOW_SHIFT' undeclared (first
use in this function)
arch/sh/drivers/dma/dma-sh.c:98:12: error: 'CHCR_TS_HIGH_MASK' undeclared (first
use in this function)
arch/sh/drivers/dma/dma-sh.c:98:34: error: 'CHCR_TS_HIGH_SHIFT' undeclared
(first use in this function)
arch/sh/drivers/dma/dma-sh.c: In function 'sh_dmac_configure_channel':
arch/sh/drivers/dma/dma-sh.c:145:10: error: 'CHCR_TS_LOW_SHIFT' undeclared
(first use in this function)
arch/sh/drivers/dma/dma-sh.c:145:10: error: 'CHCR_TS_HIGH_SHIFT' undeclared
(first use in this function)

I guess it should be added in a new dma-register.h in arch/sh/include/cpu-sh2 ?

Regards,
Fabian
