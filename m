Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B3EC4332F
	for <linux-sh@archiver.kernel.org>; Mon, 14 Nov 2022 05:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiKNFss (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 14 Nov 2022 00:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKNFsr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 14 Nov 2022 00:48:47 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7A165B6
        for <linux-sh@vger.kernel.org>; Sun, 13 Nov 2022 21:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668404925; x=1699940925;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=v1sR2mwFH9dmYdHzu0koJ50qxkQ0XF8GxeWMZxBQMlk=;
  b=n/pXLgFvI/qArFcSy32jZu2URNF/62OB626MfZ3BtPyqkyeqF7ZnstGx
   nF0+GkhCcLD4A3WKUXVLCkV4LSHFXSmFWaVxc8dKM0eis9x1vtSV/FIG9
   IjP20KLBAqsRMeP4n96bRnj1uotokToAIxFscCFXrKWooXdV8RDcGVpal
   DFlPU+wgmGTpitj+giG353oXvAovsLqHQps0P/QMEQ1QRm428vxoPa3RJ
   q9SPU1y5kWYeCgw6VAnQJf/+UTRIxRMBqBHQ8DWj+stBprr8u0P+wG+2Z
   vXRRjm7FZqtJHQNs6rpQ00y4LKNPA6lALuev9cqdM8YhXRWy0Qse84ZyJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="320535397"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 13:48:40 +0800
IronPort-SDR: m3TzNRedR0stE62n/VE2S/wGjvMexZr/F+LH30K8S+lERzrnT2zCXwJWqzVyylSiiw/ei7lTeQ
 l46HmR9UbgUqdzMw4vl7u/EDZ7HKfCnD0PtBMbwxZ2Y87PZQKSPEf7nOh4P9a5V/+v2vh/NEDF
 r7EzUiQHNhcV7WMJjv+PzHH7tuWWMEgm8dplwgLKwr9xiDM4uBCc9Um1uENF2eh/PXRHxyIfLJ
 oDe7fFFg9cKnrEdMHP0boIW5K0QIyZeSjgZCGG0a0/9GRGuMnc00o4gbLZsZpbfCRUkwHw5VIU
 Jto=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 21:01:54 -0800
IronPort-SDR: tFpu2fJuefhKVMF14n9hC1qn0QqFaXoVYgMGlIz5LLlYM0/x/aoiWfb/pwggtiOlChc6JbsCeE
 4xUOYOqfAbkjr1QK8wTOpsoH9ioALX8R3mKdgL1/Dyb+8oziJfpV4OdfoZGsCxqLUAR66STSrW
 iJxY/n8/0ED7FJsN8jZJqvQUcpp+QRTupzj+SZRRUvRYupm608tqdcTJbO1VRTE1Bptdig2pas
 i0ZBi1GAiZB3TARK+oot6ljUqDp7XzpblfYtiu7z5Dxn9sKOdtx7pYajIVav//cSSIcAY00Y/c
 +cI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 21:48:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9ddz4qm6z1Rwt8
        for <linux-sh@vger.kernel.org>; Sun, 13 Nov 2022 21:48:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668404917; x=1670996918; bh=v1sR2mwFH9dmYdHzu0koJ50qxkQ0XF8GxeW
        MZxBQMlk=; b=Jj+OgXCgQLjiUSHdOF9I6MrgaqryVIX7t3nKyq6ZmaxCJrCDf+D
        tGBRwgMUBBGTq4WU22kKDQ58BiVzcFr1xRFoFfI1n8Bxo5+TB1XvlNxdODgFNzfR
        jI637Q7j4BNG1aLfH2JTTKH2lh843Eo9/6TImWIKH46gMtBWsZjKCoxGm9Oozafp
        gcs1atYVDBJpU4XwoYUztHkasGYGgZWrc/JjNE7l3NWvxCnS7nVLlm25abnZU+4P
        jNICFUVM5vo+y+8k+C+JC5BZmVgZ8TARD4EmnhnyFopFQzr/VUu1urRgOa3vVo3h
        xfnBECv6draKEFEd/vChz733S2WF8QS+58w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CrKbSniQ2XmJ for <linux-sh@vger.kernel.org>;
        Sun, 13 Nov 2022 21:48:37 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9ddp5cqHz1RvLy;
        Sun, 13 Nov 2022 21:48:30 -0800 (PST)
Message-ID: <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 14:48:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Conor Dooley <conor@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
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
Organization: Western Digital Research
In-Reply-To: <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/14/22 10:55, Damien Le Moal wrote:
> On 11/12/22 05:46, Conor Dooley wrote:
>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> as we all know, we currently have three slab allocators. As we discussed
>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>>> two of them do not.
>>>>>
>>>>> The unsurprising reasons include code maintenance burden, other features
>>>>> compatible with only a subset of allocators (or more effort spent on the
>>>>> features), blocking API improvements (more on that below), and my
>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>>> without resorting to spelling out the letters.
>>>>>
>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>>> two to be removed, so I'd like to focus on it first.
>>>>>
>>>>> I believe SLOB can be removed because:
>>>>>
>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>>> by putting all objects together, which has its CPU performance costs
>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>>> SLOB impact is too much for those who tried. Googling for
>>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>>
>>>> I am all for removing SLOB.
>>>>
>>>> There are some devices with configs where SLOB is enabled by default.
>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>> included into this thread:
>>>>
>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>
>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>
>>>
>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>>> running make defconfig ends up with SLUB anyway, unless I miss something.
>>> Only a subset has both SLOB and EXPERT:
>>>
>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
>>
>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
>>
>> I suppose there's not really a concern with the virt defconfig, but I
>> did check the output of `make nommu_k210_defconfig" and despite not
>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
>>
>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
>> boots etc, but I have no workloads or w/e to run on it.
> 
> I sent a patch to change the k210 defconfig to using SLUB. However...
> 
> The current default config using SLOB gives about 630 free memory pages
> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
> 
> This is with a buildroot kernel 5.19 build including a shell and sd-card
> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
> definitely see more errors with shell commands failing due to allocation
> failures for the shell process fork. So as far as the K210 is concerned,
> switching to SLUB is not ideal.
> 
> I would not want to hold on kernel mm improvements because of this toy
> k210 though, so I am not going to prevent SLOB deprecation. I just wish
> SLUB itself used less memory :)

Did further tests with kernel 6.0.1:
* SLOB: 630 free pages after boot, shell working (occasional shell fork
failure happen though)
* SLAB: getting memory allocation for order 7 failures on boot already
(init process). Shell barely working (high frequency of shell command fork
failures)
* SLUB: getting memory allocation for order 7 failures on boot. I do get a
shell prompt but cannot run any shell command that involves forking a new
process.

So if we want to keep the k210 support functional with a shell, we need
slob. If we reduce that board support to only one application started as
the init process, then I guess anything is OK.

-- 
Damien Le Moal
Western Digital Research

