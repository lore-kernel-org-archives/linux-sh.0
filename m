From: Rob Herring <robherring2@gmail.com>
Date: Fri, 25 Jan 2013 14:31:12 +0000
Subject: Re: [PATCH] DT: add vendor prefixes for Renesas and Toshiba
Message-Id: <51029730.8050107@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1301241708360.7826@axis700.grange> <20130125041206.GK13691@verge.net.au>
In-Reply-To: <20130125041206.GK13691@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org

On 01/24/2013 10:12 PM, Simon Horman wrote:
> On Thu, Jan 24, 2013 at 05:09:45PM +0100, Guennadi Liakhovetski wrote:
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> I'm curious to know who would ack and or pick-up this patch.

I have applied it. You would know if get_maintainers.pl had been used.

Rob

> 
>> ---
>>  .../devicetree/bindings/vendor-prefixes.txt        |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 902b1b1..5d811b2 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -42,6 +42,7 @@ powervr	PowerVR (deprecated, use img)
>>  qcom	Qualcomm, Inc.
>>  ramtron	Ramtron International
>>  realtek Realtek Semiconductor Corp.
>> +renesas	Renesas Electronics Corporation
>>  samsung	Samsung Semiconductor
>>  sbs	Smart Battery System
>>  schindler	Schindler
>> @@ -52,6 +53,7 @@ snps 	Synopsys, Inc.
>>  st	STMicroelectronics
>>  stericsson	ST-Ericsson
>>  ti	Texas Instruments
>> +toshiba	Toshiba Corporation
>>  via	VIA Technologies, Inc.
>>  wlf	Wolfson Microelectronics
>>  wm	Wondermedia Technologies, Inc.
>> -- 
>> 1.7.2.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 

