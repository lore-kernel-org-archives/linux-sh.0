From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 20 Nov 2013 18:26:40 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a7790: tidyup clock table order
Message-Id: <528CFEE0.1030105@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 20-11-2013 4:24, Simon Horman wrote:

>>> SuperH lookups clock is using CLKDEV_CON/DEV/ICK_ID() macro
>>> for a long term.
>>> But in these days, the ICK clock is defined in random place.
>>> This patch arranges it.

>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>> ---
>>>   arch/arm/mach-shmobile/clock-r8a7790.c |   13 ++++++++-----
>>>   1 file changed, 8 insertions(+), 5 deletions(-)

>>> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
>>> index 36e1a2d..d962436 100644
>>> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
>>> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
>>> @@ -266,11 +266,6 @@ static struct clk_lookup lookups[] = {
>>>   	CLKDEV_CON_ID("ssprs",		&div6_clks[DIV6_SSPRS]),
>>>
>>>   	/* MSTP */
>>> -	CLKDEV_ICK_ID("lvds.0", "rcar-du-r8a7790", &mstp_clks[MSTP726]),
>>> -	CLKDEV_ICK_ID("lvds.1", "rcar-du-r8a7790", &mstp_clks[MSTP725]),
>>> -	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7790", &mstp_clks[MSTP724]),
>>> -	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7790", &mstp_clks[MSTP723]),
>>> -	CLKDEV_ICK_ID("du.2", "rcar-du-r8a7790", &mstp_clks[MSTP722]),
>>>   	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
>>>   	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
>>>   	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
>>> @@ -302,7 +297,15 @@ static struct clk_lookup lookups[] = {
>>>   	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
>>>   	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
>>>   	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
>>> +
>>> +	/* ICK */

>>     How this corresponds to the above MSTP comment?

> My understanding is that the motivation of this patch is to
> group together ICK clock initialisation as it is
> done using the CLKDEV_ICK_ID() macro rather than the
> CLKDEV_ICK_ID() macro used for other MSTP clocks.

    What? :-)

> In this context I think the comment makes sense.

    I disagree because the clocks declared via CLKDEV_ICK_ID() are by nature 
the same MSTP clocks as the others. This patch looks dangerously close to the 
needless churn IMHO.

>>>   	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
>>> +	CLKDEV_ICK_ID("lvds.0", "rcar-du-r8a7790", &mstp_clks[MSTP726]),
>>> +	CLKDEV_ICK_ID("lvds.1", "rcar-du-r8a7790", &mstp_clks[MSTP725]),
>>> +	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7790", &mstp_clks[MSTP724]),
>>> +	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7790", &mstp_clks[MSTP723]),
>>> +	CLKDEV_ICK_ID("du.2", "rcar-du-r8a7790", &mstp_clks[MSTP722]),
>>> +
>>>   };

WBR, Sergei

