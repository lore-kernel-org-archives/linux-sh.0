From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Mar 2010 10:24:31 +0000
Subject: Re: G4 cannot compile
Message-Id: <aec7e5c31003170324l6bbfa143yfbfb17607456f5cb@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6hr6ypl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uy6hr6ypl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hey Morimoto-san,

2010/3/17 Kuninori Morimoto <morimoto.kuninori@renesas.com>:
> G4 cannot compile on latest Paul's git
> I used arch/arm/configs/g4evm_defconfig
>
> asm/dmaengine.h  =>  arch/sh/include/asm
>                          ~~
> I guess G4 needs link to it
>
> ------------------
> In file included from arch/arm/mach-shmobile/setup-sh7377.c:28:
> include/linux/serial_sci.h:5:27: error: asm/dmaengine.h: No such file or
> directory
> In file included from arch/arm/mach-shmobile/setup-sh7377.c:28:
> include/linux/serial_sci.h:33: error: field 'dma_slave_tx' has
> incomplete type
> include/linux/serial_sci.h:34: error: field 'dma_slave_rx' has
> incomplete type
> make[1]: *** [arch/arm/mach-shmobile/setup-sh7377.o] エラー 1
> make: *** [arch/arm/mach-shmobile] エラー 2
> ------------------

Did you include the latest patches?

damm@t400s ~/git/sh-2.6 $ git log --oneline -p -1
include/linux/serial_sci.h | head -n 1
04e82ff serial: sh-sci: Fix build failure for non-sh architectures.
damm@t400s ~/git/sh-2.6 $

Cheers,

/ magnus
