From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Jun 2011 06:32:41 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 gic_arch_extn.irq_set_wake() fix
Message-Id: <20110614063241.GC17891@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609062003.383.67447.sendpatchset@t400s>
In-Reply-To: <20110609062003.383.67447.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 09, 2011 at 03:20:03PM +0900, Magnus Damm wrote:
> Initialize ->irq_set_wake() in gic_arch_extn to unbreak wake
> up from the KEYSC device on AG5EVM in case of Suspend-to-RAM.
> 
> Without this patch "echo mem > /sys/power/state" and a key
> press results in the following message on resume:
> 
> WARNING: at kernel/irq/manage.c:507 irq_set_irq_wake+0x7c/0xd8()                
> Unbalanced IRQ 103 wake disable                                                 

On Thu, Jun 09, 2011 at 03:35:08PM +0900, Magnus Damm wrote:
> Fix the recently added SH_DMAC_MAX_CHANNELS handling code in
> 300e5f9 dmaengine: shdma: Fix SH_DMAC_MAX_CHANNELS handling
> 
> Without this fix the shdma driver outputs silly messages in
> case SH_DMAC_MAX_CHANNELS happens to match the platform data:
> 
> sh-dma-engine sh-dma-engine.0: Attempting to register 20 DMA channels when a max
> imum of 20 are supported.            

On Thu, Jun 09, 2011 at 06:02:25PM +0900, Magnus Damm wrote:
> Add a flag for SDHI1 to enable SDIO IRQ, and remove DMA Engine
> slave id:s to disable DMA as a workaround.
> 
> Tested on sh73a0/AG5EVM with a BCM4318-based SDIO card.

On Mon, Jun 13, 2011 at 01:42:15PM +0900, Magnus Damm wrote:
> Extend the SH / SH-Mobile ARM clock framework to only
> resume clocks that has been enabled.
> 
> Without this fix divide-by-zero is triggering on sh7372
> FSIDIV during system wide resume of Suspend-to-RAM.

All applied, thanks.
