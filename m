From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 12 Feb 2015 07:11:17 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: Add function to get SoCs revision data for R-Car Gen2
Message-Id: <54DC5215.1010500@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130107023101.GM2935@verge.net.au>
In-Reply-To: <20130107023101.GM2935@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Thanks for your review.

(2015/02/10 17:41), Geert Uytterhoeven wrote:
> Hi Iwamatsu-san,
>
> On Fri, Feb 6, 2015 at 2:33 AM, Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.yj@renesas.com>  wrote:
>> SoCs of R-Car Gen2 have some revision. This adds function to get SoCs revision
>> data, and change so that user can confirm from /proc/cpuinfo.
>
> Thanks for your patch.
>
>> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
>
>> +#define PRR 0xFF000044
>> +static unsigned int __init rcar_gen2_get_revision(void)
>> +{
>> +       void __iomem *addr = ioremap_nocache(PRR, 4);
>> +       u32 data = ioread32(addr);
>> +
>> +       iounmap(addr);
>> +
>> +       return ((data&  0xF0)>>  4) + 1;
>
> Is there any specific reason why you're not returning the fractional part
> (lowest 4 bits) of the ESx.y revision number?
> I.e. why not return "(data&  0xf0) + 0x10"?
>
>> +}

Because this version notation accommodate to the U-Boot.
However, if the notation that does not shift is preferred, I will change it.

I will update this patch.

>
> Gr{oetje,eeting}s,
>
>                          Geert
>

Best regards,
   Nobuhiro
