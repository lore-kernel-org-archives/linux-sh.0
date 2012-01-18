From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Jan 2012 00:21:30 +0000
Subject: Re: [PATCH 0/2] mmc: sh_mmcif: simplify platform DMA configuration
Message-Id: <20120118002130.GD8182@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 17, 2012 at 05:39:55PM +0100, Guennadi Liakhovetski wrote:
> Hi Paul
> 
> On Mon, 5 Sep 2011, Paul Mundt wrote:
> 
> > On Tue, Aug 30, 2011 at 06:26:34PM +0200, Guennadi Liakhovetski wrote:
> > > A simple cosmetic clean-up, no functional changes. Patch 2/2 depends on 
> > > patch 1/2 and can wait until 3.3. Paul, would you be able to put it under 
> > > the carpet somewhere until then or shall I resend it after 3.2-rc1 is out? 
> > > After both these patches have been applied, we can remove struct 
> > > sh_mmcif_plat_data::dma around 3.4 or 4.0 or whatever;-)
> > > 
> > It's not a problem, I'll just flag it as awaiting upstream in the
> > tracker. Anything flagged as such I generally give a once over after each
> > merge window to see if their dependencies have been worked out.
> 
> You certainly haven't forgotten about this patch;-), in which case it's 
> just me, unable to find it in your git branches. Could you give me a hint 
> where it can be?
> 
Er, no, of course not ;-)

It's out there now..
