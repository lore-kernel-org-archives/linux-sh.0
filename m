From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 12 Mar 2012 05:23:37 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <20120312052337.GC9503@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 12, 2012 at 02:18:45PM +0900, Simon Horman wrote:
> I have tried the patch below (slightly modified as I have detailed inline)
> on top of 3.3-rc7, however, I am observing that the boot hangs in the
> usual spot when using the default config.
> 
> arm_vmregion_alloc: allocation too big (requested 0x7e9000)
> sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
> sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error -12
> SuperH SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> sh-sci sh-sci.0: start latency exceeded, new value 6084 ns
> console [ttySC0] enabled, bootconsole disabled
> console [ttySC0] enabled, bootconsole disabled
> 
You will probably want to use the rmobile-fixes-for-linus branch, as it
contains:

commit 1740d3448012475f6b63172631c60cbcd1994a81
Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Thu Mar 1 15:45:16 2012 +0100

    ARM: mach-shmobile: mackerel: Reserve DMA memory for the frame buffer

    The default 2MB size of DMA coherent memory isn't enough for allocate
    frame buffer memory.

    Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

