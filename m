From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Nov 2008 14:02:27 +0000
Subject: Re: [PATCH] sh: Switch HD64461 from hw_interrupt_type to irq_chip
Message-Id: <20081128140227.GB18785@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
In-Reply-To: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 28, 2008 at 08:58:30AM +0000, Matt Fleming wrote:
> Use struct irq_chip for the interrupt handler for the HD64461. Also
> convert some in{b,w} and out{b,w} calls to the equivalent __raw_* calls.
> Include <linux/io.h> and not <asm/io.h> to stop checkpatch.pl
> complaining.
> 
> This change should now allow machines with HD64461 to define
> GENERIC_HARDIRQS_NO__DO_IRQ.
> 
> Acked-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

Applied, thanks.
