From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Sep 2015 07:43:26 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <20150902074325.GB29815@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Sep 02, 2015 at 09:26:32AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,

[snip]

> Thanks for the analysis and the explanation!
> 
> > So it seems to me that one possibility would be to:
> > * Have names for all of the channels, say rx0 - 18, tx0 - 4, data, dataB, emac.
> >   - Better names could be found for data and dataB.
> 
> That's one possibility, but it looks to me like the rx* and tx* naming would
> be purely a configuration, which doesn't describe the hardware, and perhaps
> could even change for future parts? At least having 18 RX channels and 4
> TX channels looks arbitrary to me.
> 
> > * Allow for properties to describe the mode and possibly which od dataA or B
> >   should be used.
> 
> Also configuration, not description of the hardware.
> 
> > But for now:
> > * Only describe the interrupts that are used and default to mode 1 with the
> >   data interrupt and;
> > * Defer defining properties to switch to combinations
> >
> > I am all ears for other ideas.
> 
> I think there should be either a single multiplexed interrupt (for Gen2),
> or a list of named interrupts ("ch%u"), of which ch22/ch23 and ch24 are
> mandatory (for Gen3). Other SoCs may reuse the RAVB IP core without
> wiring up all channels.
> 
> For Gen3, the driver can then choose itself between mode1 and mode2
> (if implemented in the driver, and all needed channels are available).
> 
> Does this sound sane?

Sure, that sounds sane to me.
