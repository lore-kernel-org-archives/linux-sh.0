From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Apr 2013 12:34:51 +0000
Subject: Re: [PATCH v3 0/5] ARM: shmobile: mackerel: streamline SD and MMC devices
Message-Id: <20130402123450.GA506@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364591152-4780-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1364591152-4780-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 02, 2013 at 09:01:12PM +0900, Simon Horman wrote:
> Hi Guennadi,
> 
> On Tue, Apr 02, 2013 at 11:13:03AM +0200, Guennadi Liakhovetski wrote:
> > Hi Simon
> > 
> > On Tue, 2 Apr 2013, Simon Horman wrote:
> > 
> > > On Fri, Mar 29, 2013 at 10:05:47PM +0100, Guennadi Liakhovetski wrote:
> > > > This patch series is a split of a previous monolithic patch with no changes
> > > > of the content.
> > > > 
> > > > Guennadi Liakhovetski (5):
> > > >   ARM: shmobile: mackerel: SDHI resources do not have to be numbered
> > > >   ARM: shmobile: mackerel: remove OCR masks, where regulators are used
> > > >   ARM: shmobile: mackerel: switch SDHI and MMCIF interfaces to
> > > >     slot-gpio
> > > >   ARM: shmobile: mackerel: add interrupt names for SDHI0
> > > >   ARM: shmobile: mackerel: clean up MMCIF vs. SDHI1 selection
> > > > 
> > > >  arch/arm/mach-shmobile/board-mackerel.c |  111 +++++++++++--------------------
> > > 
> > > Thanks Guennadi,
> > > 
> > > queued up for v3.10 in the boards branch.
> > 
> > Thanks for taking the patches. Are you aware off the top of your head of 
> > any patches that are still pending updated versions from me (apart from 
> > those, that Magnus wanted to discuss with me first)?
> 
> Not off the top of my head, other the ones that are pending
> discussion with Magnus.
> 
> If you see anything missing as of renesas-next-20130402 then please
> let me know.

I did remember one thing, which is I'm wondering
if you could wire up the r8a7779/marzen-reference to use irqpin via DT.
Something similar to what you did for sh73a0/kzm9g-reference. I believe
this would allow access to the SMSC ethernet on marzen-reference
as it did on kzm9g-reference.

I can give you remote access to a marzen board if that would help.
