From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Feb 2014 06:13:26 +0000
Subject: Re: [PATCH v2 00/02] ARM: shmobile: Koelsch SDHI DT support V2
Message-Id: <20140226061322.GA19166@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212095345.4832.6546.sendpatchset@w520>
In-Reply-To: <20140212095345.4832.6546.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 13, 2014 at 02:01:27PM +0900, Simon Horman wrote:
> On Wed, Feb 12, 2014 at 06:53:45PM +0900, Magnus Damm wrote:
> > ARM: shmobile: Koelsch SDHI DT support V2
> > 
> > [PATCH v3 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
> > [PATCH v2 02/02] ARM: shmobile: Add SDHI devices for Koelsch DTS
> > 
> > Add SDHI devices to the Koelsch DT board support. The same run
> > time dependencies as SDHI for Lager applies here too, and there
> > is a PFC fix for SD1_CLK that is needed for r8a7791 as well.
> > 
> > Needs SDHI driver patches.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  Written against "origin/topic/r-car-sdhi" of renesas git.
> > 
> >  Requires the following patches for correct run time operation:
> >  [PATCH 02/03] pinctrl: sh-pfc: r8a7791: SD1_CLK fix
> >  "regulator: gpio: add gpios-status for DT"
> > 
> >  arch/arm/boot/dts/r8a7791-koelsch.dts |  119 +++++++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/r8a7791.dtsi        |   27 +++++++
> >  2 files changed, 146 insertions(+)
> 
> Thanks Magnus,
> 
> to aid further development I have added these patches
> to the topic/r-car-sdhi branch.
> 
> To be clear, these are not queued up for mainline as
> they depend on other patches in the topic/r-car-sdhi branch.

I have now queued up these patches for mainline.
