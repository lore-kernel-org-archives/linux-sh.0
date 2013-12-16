From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 16 Dec 2013 01:13:07 +0000
Subject: Re: [PATCH] sh: Add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
Message-Id: <CABMQnVJO=_-BHt-zV7B=OuoBuHFy98Yo4dcHmwU7q2n8GSTwSg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2013/12/13 Andrew Morton <akpm@linux-foundation.org>:
> On Fri, 13 Dec 2013 09:10:38 +0900 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com> wrote:
>
>> Min_low_pfn and max_low_pfn were used in pfn_valid macro if defined
>> CONFIG_FLATMEM. When the functions that use the pfn_valid is used in driver
>> module, max_low_pfn and min_low_pfn is to undefined, and fail to build.
>>
>> ----
>> ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
>> ERROR: "max_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
>
> This could be a sign that the aoe driver is doing something which it
> shouldn't be doing.
>
> z:/usr/src/25> grep pfn drivers/block/aoe/*.[ch]
> z:/usr/src/25>
>
> Confused.  Can you please work out precisely where in AOE this
> reference is occurring?

min_low_pfn and max_low_pfn are referred from pfn_valid() in
./arch/sh/include/asm/page.h.

-- 
Nobuhiro Iwamatsu
