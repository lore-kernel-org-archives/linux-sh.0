From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 15 Sep 2008 06:06:47 +0000
Subject: Re: [PATCH v2] sh7760mmc: Driver for SH7760 MMCIF interface.
Message-Id: <20080915060647.GA6730@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080911093718.GA8671@roarinelk.homelinux.net>
In-Reply-To: <20080911093718.GA8671@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 14, 2008 at 09:52:27PM +0200, Pierre Ossman wrote:
> On Sun, 14 Sep 2008 18:26:48 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
> > > > +			/* longer timeout for long response */
> > > > +			MMC_OUTB(host, CTOCR, 1);
> > > 
> > > Huh?
> > 
> > Command timeout counter register: The manual states one should write
> > '1' to this register for 136 bit responses and 0 for short/no
> > response.
> > 
> 
> Hmm... There is nothing in either the MMC or SD spec where responses
> might have a longer timeout. I don't suppose there is any deeper
> explanation in the controller spec?

It's a controller-internal counter which throws a command timeout error
if the complete command+response cycle is not completed in 128 or 256
mmc clock cycles.

 
> > > > +	MMC_OUTB(host, CMDR0, (1 << 6) | (cmd->opcode & 0x3f));
> > > 
> > > The (1 << 6) could use a define.
> > 
> > It's the "HOST" bit. I'll add a constant.
> > 
> 
> Ah, I see. That probably doesn't need a constant, but you should add a
> comment explaining that the controller needs the entire first byte,
> including start and data direction bits.

Correct, the hardware is _very_ dumb.  Adding a comment.

 
> The driver should return the number of bytes acked by the card. If you
> cannot determine this then 0 is the correct value, yes.
> 
> > > > +	/* multiblock WRITES are badly broken.  Setting max_blk_count
> > > > +	 * to 1 works around that but unfortunately it also reduces
> > > > +	 * read performance by about 60% on my test system.
> > > > +	 */
> > > 
> > > What's the issue?
> > 
> > While the card is the busy state, the controller continues to transfer
> > data to it, resulting in a CRC error.
> > 
> 
> Ouch. Can't you work around this by feeding the controller one block at
> a time and monitor the busy state manually?

Thinking about this, yes, maybe.  Give me a few more days.

Thanks!
	Manuel Lauss
