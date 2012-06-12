From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 Jun 2012 21:28:22 +0000
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <3019432.q0GM0tRQD3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com> <Pine.LNX.4.64.1206121517590.6800@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206121517590.6800@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Guennadi,

On Tuesday 12 June 2012 15:31:49 Guennadi Liakhovetski wrote:
> On Tue, 12 Jun 2012, Laurent Pinchart wrote:
> > The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> > width. When the MMC controller gets powered off, runtime PM switches the
> > MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwards
> > fails and prints an error message to the kernel log.
> > 
> > As configuring the bus width is pointless when the interface gets
> > powered down, skip the operation when power is off.
> 
> The patch looks good - thanks! But maybe we can make the commit message a
> bit more precise. I think, ios->power_mode refers to powering the card
> down and up, not the controller. We use this information to also try to
> put the controller in a power-saving mode. Depending on the kernel and
> board configuration this can be a NOP, it can switch the MSTP clock off,
> as you correctly notice, or it can power the whole PM domain, to which the
> controller belongs, down. So, maybe something like this would be better:
> 
> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> width. When the mmc core requests the driver to power off the card, we
> inform runtime PM, that the controller can be suspended. This can lead to
> the MSTP clock being turned off. Writing to to CTL_SD_MEM_CARD_OPT
> register afterwards fails and prints an error message to the kernel log.
> 
> As conf... (continue as above)
> 
> Feel free to further improve the above :)

Thank you for the feedback. I'll send a v2 that incorporates a second related 
fix.

-- 
Regards,

Laurent Pinchart

