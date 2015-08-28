From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 10:30:16 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <55E03838.3080604@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 8/28/2015 5:13 AM, Simon Horman wrote:

>>>> @@ -1688,6 +1712,16 @@ static int ravb_probe(struct platform_device *pdev)
>>>>   	priv->avb_link_active_low >>>>   		of_property_read_bool(np, "renesas,ether-link-active-low");
>>>>
>>>> +	if (of_device_is_compatible(np,
>>>> +				"renesas,etheravb-r8a7795")) {
>>>
>>>     Please respect the rules. And do you really need the break the line here?
>>>
>>>> +		irq = platform_get_irq(pdev, 1);
>>>> +		if (irq < 0) {
>>>> +			error = -ENODEV;
>>>
>>>     Please propagate the error instead.

>> Sure, will do.

> On closer examination the above is consistent with the existing
> error handling for another call to platform_get_irq() in the same function.
> Shall we fix that first?

    Yes, and I'll look into that.

WBR, Sergei

