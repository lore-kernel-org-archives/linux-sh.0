From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 25 Jul 2017 13:03:34 +0000
Subject: Re: [PATCH] sh: remove references to CPU_SUBTYPE_SH7764
Message-Id: <d272349d-8986-b3ad-7be4-4ed57cc6d200@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363002940.3137.65.camel@x61.thuisdomein>
 <6feee411-289a-51d9-f413-1f670fafa12a@cogentembedded.com>
In-Reply-To: <6feee411-289a-51d9-f413-1f670fafa12a@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>, Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/25/2017 03:54 PM, Sergei Shtylyov wrote:

>> Since release v2.6.29 the tree has a few references to the Kconfig
>> symbol CPU_SUBTYPE_SH7764 and the Kconfig macro
>> CONFIG_CPU_SUBTYPE_SH7764. But the actual symbol CPU_SUBTYPE_SH7764 was
>> never added to the tree. Perhaps no one noticed because these references
>> were never used alone. Anyhow, these references serve no purpose and
>> can be removed.
>>
>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>> ---
>> Untested: I don't have the hardware. Neither do I have the compiler for
>> this architecture at hand.
> [...]
>> diff --git a/drivers/net/ethernet/renesas/sh_eth.c
>> b/drivers/net/ethernet/renesas/sh_eth.c
>> index 33e9617..44a3d7b 100644
>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>> @@ -1653,7 +1653,6 @@ static int sh_eth_open(struct net_device *ndev)
>>
>>      ret = request_irq(ndev->irq, sh_eth_interrupt,
>>  #if defined(CONFIG_CPU_SUBTYPE_SH7763) || \
>> -    defined(CONFIG_CPU_SUBTYPE_SH7764) || \
>>      defined(CONFIG_CPU_SUBTYPE_SH7757)
>>                  IRQF_SHARED,
>>  #else
>
>     This code is long gone -- what tree is your patch based upon?

    Oops, didn't realize this mail was from 2013. :-)

MBR, Sergei

