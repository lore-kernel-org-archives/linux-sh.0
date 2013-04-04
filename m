From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Apr 2013 14:54:51 +0000
Subject: Re: [PATCH v2 1/2] ARM: mach-shmobile: r8a7779: Add DU support
Message-Id: <4114102.zxcS0L0yqK@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Thursday 28 March 2013 21:45:49 Sergei Shtylyov wrote:
> On 03/28/2013 05:42 PM, Laurent Pinchart wrote:
> >>> Add a function to register the DU device with board-specific platform
> >>> data.
> >>> 
> >>> Signed-off-by: Laurent Pinchart
> >>> <laurent.pinchart+renesas@ideasonboard.com>
> >>> ---
> >>> 
> >>>    arch/arm/mach-shmobile/include/mach/common.h |  1 +
> >>>    arch/arm/mach-shmobile/setup-r8a7779.c       | 30
> >>>    ++++++++++++++++++++++
> >>>    2 files changed, 31 insertions(+)
> >>> 
> >>> diff --git a/arch/arm/mach-shmobile/include/mach/common.h
> >>> b/arch/arm/mach-shmobile/include/mach/common.h index 03f73de..4531872
> >>> 100644
> >>> --- a/arch/arm/mach-shmobile/include/mach/common.h
> >>> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> >>> @@ -68,6 +68,7 @@ extern void r8a7779_earlytimer_init(void);
> >>> 
> >>>    extern void r8a7779_add_early_devices(void);
> >>>    extern void r8a7779_add_standard_devices(void);
> >>>    extern void r8a7779_add_standard_devices_dt(void);
> >>> 
> >>> +extern void r8a7779_add_du_device(void *pdata);
> >>> 
> >>      Maybe r8a7779_add_du0_device()?
> > 
> > There's a single DU device on the r8a7779, with two display outputs named
> > DU0 and DU1. I agree that's a bit confusing.
> > 
> >>> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
> >>> b/arch/arm/mach-shmobile/setup-r8a7779.c index a460ba3..2f817d8 100644
> >>> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> >>> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> >>> @@ -393,6 +393,29 @@ static struct platform_device sata_device = {
> >> 
> >> [...]
> >> 
> >>> +static struct platform_device du_device = {
> >>> +	.name		= "rcar-du",
> >>> +	.num_resources	= ARRAY_SIZE(du_resources),
> >>> +	.resource	= du_resources,
> >>> +	.id		= 0,
> >>> 
> >>      You probably should have written in the subject "add DU0 support".
> 
> If there's only single display device, why you're not using 'id' of -1?

Good point. I'll fix that.

-- 
Regards,

Laurent Pinchart

