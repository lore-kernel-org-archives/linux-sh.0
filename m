From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Mar 2013 10:38:05 +0000
Subject: Re: [PATCH/RFC 1/2] ARM: shmobile: armadillo800eva: add a fixed voltage regulator for SDHI1
Message-Id: <20130321103805.GF2348@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1303181925280.4980@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303181925280.4980@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 21, 2013 at 07:36:07PM +0900, Simon Horman wrote:
> On Thu, Mar 21, 2013 at 07:32:26PM +0900, Simon Horman wrote:
> > On Mon, Mar 18, 2013 at 07:26:40PM +0100, Guennadi Liakhovetski wrote:
> > > The SDHI1 power supply on armadillo800eva can be switched on and off. In
> > > the current version this is not used and the regulator is hard-wired to
> > > "on." This patch switches SDHI1 to a proper fixed-voltage regulator,
> > > using a GPIO to enable and disable it. Both SDHI0 and SDHI1 ports shall
> > > now be specifying the MMC_CAP_POWER_OFF_CARD MMC capability. Both
> > > interfaces tested with an SDIO card.
> > 
> > This seems reasonable to me.
> > Is there any reason this and the next patch are marked RFC?
> 
> Sorry for that noise, I see your explanation in the cover email.
> I am intending to apply these patches.

Both patches applied to the boards branch.
