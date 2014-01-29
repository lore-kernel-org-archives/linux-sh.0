From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 29 Jan 2014 12:26:55 +0000
Subject: Re: [PATCH] phy-rcar-usb-gen2: add device tree support
Message-Id: <52E8F38F.9030609@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk> <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk> <52E6A436.5090408@cogentembedded.com> <52E6AE32.5050906@codethink.co.uk> <20140129062212.GD23833@verge.net.au> <52E8DAF6.5090105@cogentembedded.com> <20140129122202.GB26253@verge.net.au>
In-Reply-To: <20140129122202.GB26253-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Valentine Barshak <valentine.barshak-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 29-01-2014 16:22, Simon Horman wrote:

>>>> [snip]

>>>>>> +static struct of_device_id rcar_gen2_usb_phy_ofmatch[] = {
>>>>>> +    { .compatible = "renesas,usb-phy-r8a7790", },
>>>>>> +    { .compatible = "renesas,rcar-gen2-usb-phy", },

>>>>>     Frankly speaking, I don't understand the need for the clearly
>>>>> duplicate entries.

>>>> Thanks, will look into remove it.
>>>> Anyone else have any comments on this?

>>> I would like you to leave it there.

>>> As we know the r8a7790 is an R-Car Gen2 SoC.  But there are other R-Car
>>> Gen2 SoCs, such as the r8a7791, they it could plausibly make use of
>>> rcar-gen2-usb-phy until the driver is updated with a usb-phy-r8a7791 entry.

>>     Why not just "update" the driver this way now, may I ask?

> Because I don't believe that Ben has access to r8a7791 hardware
> to test the change and thus it makes sense to handle it separately.

    I believe Valentine has already tested the driver with both SoCs.

WBR, Sergei

