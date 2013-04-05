From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 05 Apr 2013 10:07:23 +0000
Subject: Re: [RFC/PATCH 0/7] ARCH: shmobile: defconfig consolidation
Message-Id: <3815682.nYPUHoztul@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
 <2243996.H0VQ4NfsDe@avalon> <20130405004931.GR29203@verge.net.au>
In-Reply-To: <20130405004931.GR29203@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Friday 05 April 2013 09:49:31 Simon Horman wrote:
> On Fri, Apr 05, 2013 at 02:37:38AM +0200, Laurent Pinchart wrote:
> > On Friday 05 April 2013 09:30:27 Simon Horman wrote:
> > > On Thu, Apr 04, 2013 at 01:20:44PM +0200, Laurent Pinchart wrote:
> > > > On Thursday 04 April 2013 12:29:46 Simon Horman wrote:
> > > > > Hi,
> > > > > 
> > > > > this is a first pass at consolidating the defconfigs of shmobile.
> > > > > 
> > > > > It covers the mackerel, amradillo800eva and kzm9d boards which meet
> > > > > the following criteria:
> > > > > 
> > > > > * Have the same base memory address (0x40000000).
> > > > 
> > > > Do you know if there's any work being done on getting rid of the base
> > > > memory address as a kernel config option ? It seriously hinders
> > > > cross-SoC kernel testing.
> > > 
> > > As I understand things the main limitation is uImage which uses
> > > the base memory address. There is some talk of creating uImages
> > > at install time rather than build time. Which I believe would
> > > remove most if not all the problem. However, its entirely unclear
> > > to me what such an install process would look like. A new build target?
> > > In tree script? Out of tree script? It seems very undefined to me.
> > > 
> > > Another, arguably better though not backwards compatible, option
> > > is to boot using zImage (or even just Image) which do not rely
> > > on the base address.
> > 
> > Don't we also need to get rid of CONFIG_MEMORY_START ? It's used in
> > headsmp.S and headsmp-scu.S (through PLAT_PHYS_OFFSET).
> 
> Yes, I think so. Sorry for glossing over that.
> 
> I think it should be possible to remove that by evaluating it at runtime
> somehow. But I have not though deeply about this.

It would be really nice if someone could give it a try :-)

-- 
Regards,

Laurent Pinchart

