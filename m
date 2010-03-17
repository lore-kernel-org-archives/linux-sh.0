From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 17 Mar 2010 10:15:34 +0000
Subject: G4 cannot compile
Message-Id: <uy6hr6ypl.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear All

G4 cannot compile on latest Paul's git
I used arch/arm/configs/g4evm_defconfig

asm/dmaengine.h  =>  arch/sh/include/asm
                          ~~
I guess G4 needs link to it

------------------
In file included from arch/arm/mach-shmobile/setup-sh7377.c:28:
include/linux/serial_sci.h:5:27: error: asm/dmaengine.h: No such file or
directory
In file included from arch/arm/mach-shmobile/setup-sh7377.c:28:
include/linux/serial_sci.h:33: error: field 'dma_slave_tx' has
incomplete type
include/linux/serial_sci.h:34: error: field 'dma_slave_rx' has
incomplete type
make[1]: *** [arch/arm/mach-shmobile/setup-sh7377.o] エラー 1
make: *** [arch/arm/mach-shmobile] エラー 2
------------------

Best regards
--
Kuninori Morimoto
 
