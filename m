From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 07:24:23 +0000
Subject: Re: [PATCH] sh: fix the compile error in setup-sh7757.c
Message-Id: <20110829072422.GD31809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E536FC2.7090306@renesas.com>
In-Reply-To: <4E536FC2.7090306@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 23, 2011 at 06:15:46PM +0900, Yoshihiro Shimoda wrote:
> Fix the following build errors:
> 
>   CC      arch/sh/kernel/cpu/sh4a/setup-sh7757.o
> arch/sh/kernel/cpu/sh4a/setup-sh7757.c:681: error: implicit declaration of function ?DMA_BIT_MASK?
> arch/sh/kernel/cpu/sh4a/setup-sh7757.c:681: error: initializer element is not constant
> arch/sh/kernel/cpu/sh4a/setup-sh7757.c:681: error: (near initialization for ?usb_ehci_device.dev.coherent_dma_mask?)
> arch/sh/kernel/cpu/sh4a/setup-sh7757.c:705: error: initializer element is not constant
> arch/sh/kernel/cpu/sh4a/setup-sh7757.c:705: error: (near initialization for ?usb_ohci_device.dev.coherent_dma_mask?)
> make[3]: *** [arch/sh/kernel/cpu/sh4a/setup-sh7757.o] Error 1
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied, thanks.
