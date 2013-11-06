From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 06 Nov 2013 11:59:27 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: lager-reference: Switch to multiplaform
Message-Id: <1823151.NODb2BiNRP@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383059082-26315-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383059082-26315-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 06 November 2013 17:23:39 Simon Horman wrote:
> On Tue, Oct 29, 2013 at 04:04:37PM +0100, Laurent Pinchart wrote:
> > Move the Lager reference board to multiplaform ARM architecture. As
> > multiplatform requires usage of the common clock framework, switch from
> > legacy clocks to CCF by replacing the legacy clock framework
> > initialization code in the machine init handler with a common clock
> > framework initialization call in the time init handler.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/mach-shmobile/Kconfig                 |  7 +++++++
> >  arch/arm/mach-shmobile/Makefile                |  1 +
> >  arch/arm/mach-shmobile/board-lager-reference.c | 13 +++++++++----
> >  3 files changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/Kconfig
> > b/arch/arm/mach-shmobile/Kconfig index 4bb548f..b39f6b6 100644
> > --- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -20,6 +20,9 @@ comment "SH-Mobile System Type"
> >  config ARCH_EMEV2
> >  	bool "Emma Mobile EV2"
> > 
> > +config ARCH_R8A7790
> > +	bool "R-Car H2 (R8A77900)"
> > +
> 
> I realise that up until now there has only been one entry,
> but in keeping with the non-SHMOBILE_MULTI entries I think it
> would be good to have the SHMOBILE_MULTI entries sorted in alphabetical
> order. With this in mind could you move ARCH_R8A7790 to
> above ARCH_EMEV2?

In my alphabet ARCH_EMEV2 comes before ARCH_R8A7790 :-)

> >  comment "SH-Mobile Board Type"
> >  
> >  config MACH_KZM9D
> > @@ -27,6 +30,10 @@ config MACH_KZM9D
> >  	depends on ARCH_EMEV2
> >  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> > 
> > +config MACH_LAGER
> > +	bool "Lager board"
> > +	depends on ARCH_R8A7790
> > +
> >  comment "SH-Mobile System Configuration"
> >  endif

-- 
Regards,

Laurent Pinchart

