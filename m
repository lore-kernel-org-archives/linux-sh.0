From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 13 Dec 2013 02:42:10 +0000
Subject: Re: [PATCH] sh: Add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
Message-Id: <52AA7402.1050806@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

(2013/12/13 10:12), Kuninori Morimoto wrote:
> 
> Hi
> 
>> Min_low_pfn and max_low_pfn were used in pfn_valid macro if defined
>> CONFIG_FLATMEM. When the functions that use the pfn_valid is used in driver
>> module, max_low_pfn and min_low_pfn is to undefined, and fail to build.
>>
>> ----
>> ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
>> ERROR: "max_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
>> make[2]: *** [__modpost] Error 1
>> make[1]: *** [modules] Error 2
>> ----
> (snip)
>> +#ifdef CONFIG_FLATMEM
>> +/* need in pfn_valid macro */
>> +EXPORT_SYMBOL(min_low_pfn);
>> +EXPORT_SYMBOL(max_low_pfn);
>> +#endif
> 
> I'm not sure detail of min/max_low_pfn,
> but these exist under ${LINUX}/mm/[no]bootmem.c ?
> 

Yes, I know.

> EXPORT_SYMBOL() on arch/sh/kernel/sh_ksyms_32.c
> seems strange for me.

Handling of these depends on CPUs.
And in SH32, it may be referred to from modules.
Therefore, I have feeling that it is not amusing that sh_ksyms_32.c defines these using EXPORT_SYMBOL.

Would you explain the reason that you thought to be strange?

> 
> Best regards
> ---
> Kuninori Morimoto

Best regards,
  Nobuhiro


