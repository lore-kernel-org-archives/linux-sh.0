From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 13 Mar 2009 01:02:41 +0000
Subject: Re: [PATCH] dmaengine: sh: Add support DMA-Engine driver for DMA of
Message-Id: <49B9B0B1.6020703@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B8AF67.8080309@renesas.com>
 <20090312112231.GE1475@console-pimps.org>
In-Reply-To: <20090312112231.GE1475@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matt Fleming <matt@console-pimps.org>
Cc: Linux-sh <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, maciej.sosnowski@intel.com, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>

Hi, Matt.

Thank you for your review.

Matt Fleming wrote:
> On Thu, Mar 12, 2009 at 03:44:55PM +0900, Nobuhiro Iwamatsu wrote:
>> This supports DMA-Engine driver for DMA of SuperH.
>> This supported all DMA channels, and it was tested in SH7722/SH7780.
>> This can not use with SH DMA API and can control this in Kconfig.
>>
> 
> I was working on support for this, but fortunately for me you beat me
> to a finished implementation ;-)
> 
> The code looks good to me. Just a few (very very) minor nits.
> 
> Reviewed-by: Matt Fleming <matt@console-pimps.org>
> 
> [...]
> 
>> +/* for dma engine */
>> +/* mode */
>> +#define SHDMA_MIX_IRQ	(1 << 1)
> 
> The proper multi-line kernel comment style is
> 
> 	/*
> 	 *
> 	 */
> 
> though this comment can all fit on one line.
> 
OK, I fix it.
>> +
>> +static void dmae_init(struct sh_dmae_chan *sh_chan)
>> +{
>> +	u32 chcr = RS_DEFAULT; /* default is DUAL mode */
>> +	sh_dmae_writel(sh_chan, chcr, CHCR);
>> +}
>> +
>> +/*
>> + * Reset DMA controler
> 
> controler -> controller
> 
Oops, thank you.

I fix your check point and resend patch.

Best regards,
  Nobuhiro
