From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Dec 2008 00:21:18 +0000
Subject: Re: [PATCH 1/5] sh: Convert Microdev boards from hw_interrupt_type to irq_chip
Message-Id: <20081216002118.GA7407@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <006313f0e180a1cd3dec11f09f4d406b556500f8.1229255348.git.mjf@gentoo.org>
In-Reply-To: <006313f0e180a1cd3dec11f09f4d406b556500f8.1229255348.git.mjf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 14, 2008 at 12:02:24PM +0000, Matt Fleming wrote:
> This is part of the SH move to irq_chip.
> 
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

On Sun, Dec 14, 2008 at 12:02:25PM +0000, Matt Fleming wrote:
> ... as part of the hw_interrupt_type to irq_chip crusade.
> 
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

On Sun, Dec 14, 2008 at 12:02:26PM +0000, Matt Fleming wrote:
> Switch the dreamcast IRQ code over to the irq_chip way of doing things,
> so that we can set GENERIC_HARDIRQS_NO__DO_IRQ for all SuperH boards.
> 
> Also, whilst I'm here change some things to make checkpatch.pl happy:
> 	- Indent with tabs, not with spaces
> 	- Include <linux/io.h>, not <asm/io.h>
> 	- Fix the multi-line comment style
> 	- Fix some typos in the comments
> 
> Tested-by: Adrian McMenamin <adrian@newgolddream.dyndns.info>
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

On Sun, Dec 14, 2008 at 12:02:27PM +0000, Matt Fleming wrote:
> I've been unable to even compile-test this change because I don't have
> an sh5 toolchain. All uses of hw_interrupt_type for SuperH boards have
> now been converted to use irq_chip.
> 
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

On Sun, Dec 14, 2008 at 12:02:28PM +0000, Matt Fleming wrote:
> After the recent changes to switch SuperH board support over to irq_chip
> it is now possible to set GENERIC_HARDIRQS_NO__DO_IRQ for all SuperH
> boards.
> 
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

These are all applied, thanks.
