Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034D1C433FE
	for <linux-sh@archiver.kernel.org>; Mon, 14 Nov 2022 11:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbiKNLfp (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 14 Nov 2022 06:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiKNLfo (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 14 Nov 2022 06:35:44 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03ACE0E8
        for <linux-sh@vger.kernel.org>; Mon, 14 Nov 2022 03:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668425743; x=1699961743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WHeLY9a6UKMTiG2de6Vs9bsuLF7tQZ2YgeC6xZyhGac=;
  b=ag1Bux/YoXXNI7o4j14KQkVB354F9UCMThcp+6Df2rxxCQTRugbMfAHv
   PZrAUBP5ZjXubsI5JUnS33+WL8Pn/QD46UIZDBurVQsgTSTp5X0hF80pH
   94SE/TV1rOP4O4qEszDxwt7RKt7uQ5tNpZgA4U9Oe+OrLv/a+3d5pV506
   IjCCRvsk7T9i4TNSfypRaHpU26+Yhm6vpvLouH+4Z3I8nPnDs6c5wGBHR
   SWe2o3EiErrIms1c0FaeCVnWwohdECD0hJTGIpr7Ur8zgLqH8OKnKYO7W
   MRJ4jSurXJYYg2Hr2mHsAwPmdZSEULRfyvgltypTa/sxprDwV3gdDlFvi
   A==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="214485317"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 19:35:42 +0800
IronPort-SDR: GbRtIEpjUg/0tVVuot8qRW07LveKuue5iwvQkdfBgvrBDiXkKSTvLqQnxLGEUQxd9HK/BzWeM3
 ona6lD7NSUH2TTLYCP2dxsLdGRBGOM5zX8aPPmVCAQofRyI7Tzcg/qtAkajDqd6YqaTIgm+fNq
 EMufuqTrvLD+YsHhWjg3i7IN8J6CGqVJeP0XxgU04WcHDdrOw2qgUKnotI69KSC7qkEZ3AA7jY
 BR1QsmvovmD4wbXnjdLEhTKj7KtF17oNeXy+1mh3fkf6irM3ryRrrlU8OoXIaJm7DFwR4O3b+X
 Chg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 02:48:56 -0800
IronPort-SDR: lA/pbD+pd2egu08lyEE6pvk58LZVn6wlZQDMMdLylgEBuyy4gCVs/p3i3B2VayCGEcYctXwqVq
 n2LSyhFAjiXdWeLGLW3k+QJrtv6mifvUhAsP3CHoTgMJvceX79W33g26onyD3YsTyuT5FzIu2O
 W3ujUuOvNijewLdSdoV7ClgiPvbmQI8zCXMXqRbOJnteVPOgoD9hElJlsxIwO6nx0HRlrU3EqY
 buQWATJSG1lbN6AebSxDbMMd2wxZhnaGkIJlBzuLek1SEr5eEZOI5RT2FVAd40zuCwqXrfjrmc
 2MU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2022 03:35:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9nLQ53FFz1Rwt8
        for <linux-sh@vger.kernel.org>; Mon, 14 Nov 2022 03:35:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668425739; x=1671017740; bh=WHeLY9a6UKMTiG2de6Vs9bsuLF7tQZ2YgeC
        6xZyhGac=; b=CUuGIPlwf3Bn8/s9EFG5W98t0wfQJthG48+ahxRGQogE6ytTX7G
        H+g5CYe+ZVHCgL6VjsYt/0d0iUEkeqCWLh4+6FeB/akADAFVY12TlCVYhVGpI+Pi
        x9cvnAXhvcN5MEd3To/kddt7GRpLgG/anpHt/sI8OgGdQj5RYqCDpLFVVLZ0GB2b
        3iDMkXsEtyz2foVR37V1+K7uaM8dgNoiO8osoGLrGKCC2E1ZM2tVLuVJwokC6IuH
        8U4zmnmlZ3kcdtp6s9LT0xKpS2gfTE+XImzeKORyTOIFRXGVg9XTxaQw+LiA2iBW
        o/Vm3gfA0BoViNa0vXSqfp1BgFkTmhCdtGg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jfiA_ZQD8fWS for <linux-sh@vger.kernel.org>;
        Mon, 14 Nov 2022 03:35:39 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9nLD6GLmz1RvLy;
        Mon, 14 Nov 2022 03:35:32 -0800 (PST)
Message-ID: <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 20:35:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Conor Dooley <conor@kernel.org>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor.Dooley@microchip.com, Paul Cercueil <paul@crapouillou.net>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/14/22 18:36, Vlastimil Babka wrote:
> On 11/14/22 06:48, Damien Le Moal wrote:
>> On 11/14/22 10:55, Damien Le Moal wrote:
>>> On 11/12/22 05:46, Conor Dooley wrote:
>>>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>>>>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> as we all know, we currently have three slab allocators. As we discussed
>>>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>>>>> two of them do not.
>>>>>>>
>>>>>>> The unsurprising reasons include code maintenance burden, other features
>>>>>>> compatible with only a subset of allocators (or more effort spent on the
>>>>>>> features), blocking API improvements (more on that below), and my
>>>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>>>>> without resorting to spelling out the letters.
>>>>>>>
>>>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>>>>> two to be removed, so I'd like to focus on it first.
>>>>>>>
>>>>>>> I believe SLOB can be removed because:
>>>>>>>
>>>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>>>>> by putting all objects together, which has its CPU performance costs
>>>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>>>>> SLOB impact is too much for those who tried. Googling for
>>>>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>>>>
>>>>>> I am all for removing SLOB.
>>>>>>
>>>>>> There are some devices with configs where SLOB is enabled by default.
>>>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>>>> included into this thread:
>>>>>>
>>>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>>>
>>>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>>>
>>>>>
>>>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>>>>> running make defconfig ends up with SLUB anyway, unless I miss something.
>>>>> Only a subset has both SLOB and EXPERT:
>>>>>
>>>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
>>>>
>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
>>>>
>>>> I suppose there's not really a concern with the virt defconfig, but I
>>>> did check the output of `make nommu_k210_defconfig" and despite not
>>>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
>>>>
>>>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
>>>> boots etc, but I have no workloads or w/e to run on it.
>>>
>>> I sent a patch to change the k210 defconfig to using SLUB. However...
> 
> Thanks!
> 
>>> The current default config using SLOB gives about 630 free memory pages
>>> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
>>> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
> 
> Thanks for the testing! How much RAM does the system have btw? I found 8MB
> somewhere, is that correct?

Yep, 8MB, that's it.

> So 230 pages that's a ~920 kB difference. Last time we saw less  dramatic
> difference [1]. But that was looking at Slab pages, not free pages. The
> extra overhead could be also in percpu allocations, code etc.
> 
>>> This is with a buildroot kernel 5.19 build including a shell and sd-card
>>> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
>>> definitely see more errors with shell commands failing due to allocation
>>> failures for the shell process fork. So as far as the K210 is concerned,
>>> switching to SLUB is not ideal.
>>>
>>> I would not want to hold on kernel mm improvements because of this toy
>>> k210 though, so I am not going to prevent SLOB deprecation. I just wish
>>> SLUB itself used less memory :)
>>
>> Did further tests with kernel 6.0.1:
>> * SLOB: 630 free pages after boot, shell working (occasional shell fork
>> failure happen though)
>> * SLAB: getting memory allocation for order 7 failures on boot already
>> (init process). Shell barely working (high frequency of shell command fork
>> failures)

I forgot to add here that the system was down to about 500 free pages
after boot (again from the shell with "cat /proc/vmstat").

>> * SLUB: getting memory allocation for order 7 failures on boot. I do get a
>> shell prompt but cannot run any shell command that involves forking a new
>> process.

For both slab and slub, I had cpu partial off, debug off and slab merge
on, as I suspected that would lead to less memory overhead.
I suspected memory fragmentation may be an issue but doing

echo 3 > /proc/sys/vm/drop_caches

before trying a shell command did not help much at all (it usually does on
that board with SLOB). Note that this is all with buildroot, so this echo
& redirect always works as it does not cause a shell fork.

>>
>> So if we want to keep the k210 support functional with a shell, we need
>> slob. If we reduce that board support to only one application started as
>> the init process, then I guess anything is OK.
> 
> In [1] it was possible to save some more memory with more tuning. Some of
> that required boot parameters and other code changes. In another reply [2] I
> considered adding something like SLUB_TINY to take care of all that, so
> looks like it would make sense to proceed with that.

If you want me to test something, let me know.

> 
> [1]
> https://lore.kernel.org/all/Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal/
> [2] https://lore.kernel.org/all/eebc9dc8-6a45-c099-61da-230d06cb3157@suse.cz/

-- 
Damien Le Moal
Western Digital Research

