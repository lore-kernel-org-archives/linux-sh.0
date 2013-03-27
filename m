From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Mar 2013 09:41:35 +0000
Subject: Re: drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declaration of function 'ioport_unm
Message-Id: <20130327094135.GB23796@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20130327083110.GB11489@localhost>
In-Reply-To: <20130327083110.GB11489@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 04:31:10PM +0800, Fengguang Wu wrote:
> 
> Hi Stephane,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
> commit: 2b61972b74219d21ef1e91178349bdb840357688 can: sja1000: add support for PEAK-System PCMCIA card
> date:   1 year, 1 month ago
> config: make ARCH=sh allyesconfig
> 
> All error/warnings:
> 
>    In file included from drivers/net/can/sja1000/peak_pcmcia.c:28:0:
>    drivers/net/can/sja1000/sja1000.h:59:0: warning: "REG_SR" redefined [enabled by default]
>    arch/sh/include/asm/ptrace_32.h:25:0: note: this is the location of the previous definition
>    drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_free':
> >> drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]
>    drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_probe':
> >> drivers/net/can/sja1000/peak_pcmcia.c:672:2: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]
>    drivers/net/can/sja1000/peak_pcmcia.c:672:20: warning: assignment makes pointer from integer without a cast [enabled by default]
>    cc1: some warnings being treated as errors
> 
This would no doubt be due to the defconfig selecting NO_IOPORT. This
driver probably needs a HAS_IOPORT depends.
