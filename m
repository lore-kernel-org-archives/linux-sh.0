From: Simon Horman <horms@verge.net.au>
Date: Tue, 26 Feb 2013 12:12:07 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: Use Renesas INTC External IRQ pin driver
Message-Id: <20130226121203.GA17704@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130226030049.9682.31129.sendpatchset@w520>
In-Reply-To: <20130226030049.9682.31129.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 26, 2013 at 12:00:49PM +0900, Magnus Damm wrote:
> ARM: shmobile: Use Renesas INTC External IRQ pin driver
> 
> [PATCH 01/03] ARM: shmobile: irq_pin() for static IRQ pin assignment
> [PATCH 02/03] ARM: shmobile: INTC External IRQ pin driver on sh73a0
> [PATCH 03/03] ARM: shmobile: INTC External IRQ pin driver on r8a7779
> 
> These patches make use of the INTC External IRQ pin driver
> on the sh73a0 and r8a7779 SoC. They have been tested with
> the first version of the INTC External IRQ pin driver, but
> will most likely be forward compatible.
> 
> Judging by the diffstat below this patch set goes against the
> recent trend and adds lines instead of deleting them. The reason
> for this is that with this patch series the r8a7779 SoC gets
> a feature update to make use of external IRQ pins IRQ0->IRQ3.

Thanks, I have added these to topic/intc-external-irq.
