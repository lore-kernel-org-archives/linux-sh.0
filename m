From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Nov 2013 00:39:30 +0000
Subject: Re: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
Message-Id: <20131101003930.GJ6818@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131030112625.GZ16735@n2100.arm.linux.org.uk>
 <1652955.Gs3XDiEUHO@avalon> <20131030162854.GB2493@sirena.org.uk>
 <20131031060305.GU1603@verge.net.au>
 <20131031174945.GI2493@sirena.org.uk>
In-Reply-To: <20131031174945.GI2493@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 31, 2013 at 10:49:45AM -0700, Mark Brown wrote:
> On Thu, Oct 31, 2013 at 03:03:05PM +0900, Simon Horman wrote:
> > On Wed, Oct 30, 2013 at 09:28:54AM -0700, Mark Brown wrote:
> > > On Wed, Oct 30, 2013 at 12:40:12PM +0100, Laurent Pinchart wrote:
> 
> > > > > For similar reasons as x86, can we please think about using:
> > > 
> > > > > 	depends on ARM
> > > > > 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST
> 
> > > I'd read the above as saying the code needs ARM to build at all and that
> > > the hardware will only ever appear on SHMOBILE.
> 
> > I am curious to know the value of "depends ARM".
> > Is it to aid the reading that you spelt out?
> 
> That's a function of the compile time dependencies, if ARM is required
> to build then it needs to be an unconditional dependency.

Thanks, sorry for missing the obvious.
