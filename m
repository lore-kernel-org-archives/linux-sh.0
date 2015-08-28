From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 10:20:49 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <55E03601.2010202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 8/28/2015 5:01 AM, Simon Horman wrote:

>>> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>>>
>>> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>>> [horms: updated changelog]
>>
>>     I don't see any. ;-)
>>
>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>> ---
>>>   .../devicetree/bindings/net/renesas,ravb.txt       |  6 ++-
>>>   drivers/net/ethernet/renesas/ravb.h                |  1 +
>>>   drivers/net/ethernet/renesas/ravb_main.c           | 47 +++++++++++++++++++---
>>>   3 files changed, 47 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
>>> index 1fd8831437bf..0b4ec02c35a4 100644
>>> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
>>> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
[...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
>>> index a157aaaaff6a..1832737063f3 100644
>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>> @@ -809,6 +809,7 @@ struct ravb_private {
>>>
>>>   	unsigned no_avb_link:1;
>>>   	unsigned avb_link_active_low:1;
>>> +	int emac_irq;
>>>   };

>>     Why not add it above the bit fields?

> Using an int seems reasonable to me as it is used to hold
> an integer value returned by request_irq().

    No question about the field type, only about its placement.

[...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 026d98435d87..bf604a869458 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -1185,16 +1185,36 @@ static const struct ethtool_ops ravb_ethtool_ops = {
[...]
>>> +		if (error) {
>>> +			netdev_err(ndev, "cannot request IRQ\n");
>>> +			goto out_napi_off;
>>> +		}
>>> +		error = request_irq(priv->emac_irq,
>>> +				ravb_interrupt,	IRQF_SHARED, ndev->name, ndev);
>>
>>     Likewise.
>>     And using the same handler for both interrupts doesn't look good.

> It does seem a little odd. I will confirm that detail.

    If the EMAC indeed uses a separate interrupt, please specify its handler 
directly. The same for the separate AVB-DMAC interrupt (I somewhat doubt that 
we really need it in the current driver though).

[...]

MBR, Sergei

