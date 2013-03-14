From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 14 Mar 2013 22:11:05 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <51424AF9.3080601@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363271746-9806-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1363271746-9806-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51420A3C.1030305@cogentembedded.com> <3727288.GPvHJIxomY@avalon>
In-Reply-To: <3727288.GPvHJIxomY@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

On 15.03.2013 0:11, Laurent Pinchart wrote:

>>> Only the DU0 VGA output is currently supported. Support for the DU0 LVDS
>>> and DU1 LVDS outputs will require information about the panels that will
>>> be connected to those outputs.

>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>
>>> ---

>>>    arch/arm/configs/marzen_defconfig     |  2 ++
>>>    arch/arm/mach-shmobile/board-marzen.c | 65 +++++++++++++++++++++++++++++
>>>    2 files changed, 67 insertions(+)

>>> diff --git a/arch/arm/mach-shmobile/board-marzen.c
>>> b/arch/arm/mach-shmobile/board-marzen.c index cdcb799..0020506 100644
>>> --- a/arch/arm/mach-shmobile/board-marzen.c
>>> +++ b/arch/arm/mach-shmobile/board-marzen.c

>> [...]

>>> @@ -147,6 +148,38 @@ static struct platform_device hspi_device = {
>>>    	.num_resources	= ARRAY_SIZE(hspi_resources),
>>>    };
>>>
>>> +/* DU */
>>> +static struct resource rcar_du_resources[] = {
>>> +	[0] = {
>>> +		.name	= "Display Unit",
>>> +		.start	= 0xfff80000,
>>> +		.end	= 0xfffb1007,
>>> +		.flags	= IORESOURCE_MEM,
>>> +	},
>>> +	[1] = {
>>> +		.start	= gic_spi(31),
>>> +		.flags	= IORESOURCE_IRQ,
>>> +	},
>>> +};
>>> +
>>> +static struct rcar_du_platform_data rcar_du_pdata = {
>>> +	.encoders = {
>>> +		[0] = {
>>> +			.encoder = RCAR_DU_ENCODER_VGA,
>>> +		},
>>> +	},
>>> +};
>>> +
>>> +static struct platform_device rcar_du_device = {
>>> +	.name		= "rcar-du",
>>> +	.num_resources	= ARRAY_SIZE(rcar_du_resources),
>>> +	.resource	= rcar_du_resources,
>>> +	.dev	= {
>>> +		.platform_data = &rcar_du_pdata,
>>> +		.coherent_dma_mask = ~0,
>>> +	},
>>> +};
>>> +

>> Are we seeing again SoC device declared in the board file? That simply
>> doesn't scale...

> The goal is obviously to move all that to DT, but there's no DT bindings for
> the DU DRM driver yet.

    I don't see how it justifies dubious non-DT design. Let me tell/remind you 
about the LTSI-3.4 tree where all this stuff can be backported and which 
doesn't have DT support, AFAIR.

WBR, Sergei

