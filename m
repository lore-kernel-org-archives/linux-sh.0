From: Simon Horman <horms@verge.net.au>
Date: Fri, 21 Nov 2014 03:39:12 +0000
Subject: Re: [PATCH v6 0/6] sh73a0 common clock framework implementation
Message-Id: <20141121033912.GA28928@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1416500463-20965-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1416500463-20965-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 21, 2014 at 11:33:39AM +0900, Simon Horman wrote:
> On Fri, Nov 21, 2014 at 09:36:54AM +0900, Simon Horman wrote:
> > On Thu, Nov 20, 2014 at 05:20:57PM +0100, Ulrich Hecht wrote:
> > > Hi!
> > > 
> > > This uses clock-indices instead of renesas,clock-indices and adds Geert's
> > > Tested-by.  Who wants to pick this up, Geert, Mike, Simon?
> > 
> > I believe this may have been discussed previously as indicated
> > by Mike's Ack of patch 1 indicating the series can go through my tree.
> > 
> > I am quite happy to proceed with that approach for v3.20.
> > But I'll leave the patchset out there until next week to
> > give Mike and others a chance to say otherwise.
> 
> I see v2 has been posted which solicits another Ack from Mike.
> I will continue to hold fire.

Please ignore that, the v2 I saw was for a different patchset.

> 
> > 
> > > 
> > > CU
> > > Uli
> > > 
> > > 
> > > Changes since v5:
> > > - use clock-indices instead of renesas,clock-indices
> > > - added Tested-by
> > > 
> > > Changes since v4:
> > > - reordered MSTP clock assignments to directly follow interrupts property
> > > 
> > > Changes since v3:
> > > - fixed bindings to match the implementation
> > > - handle extal division in CPG driver, dump extal?_div2_clk
> > > - added acks
> > > - dropped eth clock hack
> > > 
> > > Changes since v2:
> > > - split CCF DT description
> > > - tabbed constants in CPG bits header file
> > > - reordered patches to avoid need for shmobile_clk_workaround()
> > > - removed said workaround
> > > - squashed unmerged remains of CMT1 DT description into MSTP clocks patch
> > > - renamed clock zb1 to zb
> > > - removed DIV6 stuff, will be a separate series
> > > 
> > > Changes since v1:
> > > - div6 patch replaced with v4
> > > - split off div6 extended clocks
> > > - added cmt1 DT description
> > > - added MSTP clock assignments
> > > - reordered according to dependencies
> > > - removed dummy frequencies in extal2, extcki
> > > - removed enable_on_init on zb1 and flctlck
> > > - added missing tpu4 in mstp3_clks
> > > - use c->parent in cpg driver
> > > - fix some style issues
> > > 
> > > Ulrich Hecht (6):
> > >   clk: shmobile: sh73a0 common clock framework implementation
> > >   ARM: shmobile: sh73a0: Add CPG register bits header
> > >   ARM: shmobile: sh73a0: Common clock framework DT description
> > >   ARM: shmobile: kzm9g-reference: Common clock framework DT description
> > >   ARM: shmobile: sh73a0: add MSTP clock assignments to DT
> > >   ARM: shmobile: sh73a0: disable legacy clock initialization
> > > 
> > >  .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  35 ++
> > >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   4 +
> > >  arch/arm/boot/dts/sh73a0.dtsi                      | 358 +++++++++++++++++++++
> > >  arch/arm/mach-shmobile/setup-sh73a0.c              |   5 +-
> > >  drivers/clk/shmobile/Makefile                      |   1 +
> > >  drivers/clk/shmobile/clk-sh73a0.c                  | 204 ++++++++++++
> > >  include/dt-bindings/clock/sh73a0-clock.h           |  79 +++++
> > >  7 files changed, 685 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
> > >  create mode 100644 drivers/clk/shmobile/clk-sh73a0.c
> > >  create mode 100644 include/dt-bindings/clock/sh73a0-clock.h
> > > 
> > > -- 
> > > 1.8.4.5
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
