From: phil.edworthy@renesas.com
Date: Mon, 18 Mar 2013 17:20:31 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Add PCIe clock support
Message-Id: <OF9072B182.08835F73-ON80257B32.005EF779-80257B32.005F3D45@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363624732-24660-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1363624732-24660-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> Date: 18/03/2013 17:14
> Subject: Re: [PATCH] ARM: shmobile: r8a7779: Add PCIe clock support
> 
> Hello.
> 
> On 18-03-2013 20:38, Phil Edworthy wrote:
> 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > Depends on "r8a7779: Add Display Unit clock support"
> 
> >   arch/arm/mach-shmobile/clock-r8a7779.c |    3 +++
> >   1 files changed, 3 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/
> mach-shmobile/clock-r8a7779.c
> > index 9ea6087..a017418 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> [...]
> > @@ -182,6 +184,7 @@ static struct clk_lookup lookups[] = {
> >      CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 
*/
> >      CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 
*/
> >      CLKDEV_DEV_ID("rcar-du.0", &mstp_clks[MSTP103]), /* DU */
> > +   CLKDEV_DEV_ID("rcar-pcie.0", &mstp_clks[MSTP116]), /* PCIe */
> 
>    Hm, why this name? Is there going to be a driver somewhere in 
> drivers/pci/, 
> and is there goiung to be more than one instance of PCIe?

Yes, I am writing a PCIe driver at the moment, the same hardware is used 
on a number of R-Car devices. For r8a7779 there is only one instance, but 
older SH devices have had multiple instances.

Thanks
Phil
