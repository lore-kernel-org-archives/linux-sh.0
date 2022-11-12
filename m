Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C756C4332F
	for <linux-sh@archiver.kernel.org>; Sat, 12 Nov 2022 01:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiKLBlF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 11 Nov 2022 20:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiKLBlE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 11 Nov 2022 20:41:04 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F265E41
        for <linux-sh@vger.kernel.org>; Fri, 11 Nov 2022 17:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668217263; x=1699753263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kWfbDk7epBE8N+lvIUYGuQa6NGCEfO5LUkxzV91Rv/U=;
  b=ScenQSV78QS+6txiKaxGh4XErU+/O/uSAljdjCMujR6WqCO9TAj14uIt
   /9fdJJDn7Bq7ieqfsz4qhvRV6LXDZc6KEQy20NCbVJbVeglLm32rrDlcJ
   4jMsfkYce3Ol66UAx/2eDRsIiM1WOx7vG/gAxL1WFWyL2HSdkZlkDdQ5q
   iR+E1pnX9BdLHrspQvpduJDTVHr2UNMt+KH2qo0Ei7vmzvohpp/TEx8vy
   8NTrsliEUSjlNM9WRd6vXA6CQ3Cm1+evDFRFX1Hv8Z6zHn8uuP4NBUa6a
   XZKoQ+yFqq3NMQBtz678a9WktS37Jarn3Ou//lhZdHgWVgArqjx+EU37p
   w==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="216094314"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 09:41:02 +0800
IronPort-SDR: +bnqH2CbdgtKW+Eep1Mo2pFlvxCl1So7czx3uamF5XqkhoetQY+aaTVEO975IVx0VL8jVb/kPP
 Rxm2lEKs6AzK0AkiC9nFqixqMloTA+OgglPFN51TpXJpGefcxTfszxKrfwmDrE1jEC6GZH+zSE
 Q0Dc2FCyrEJYw2pelcXdB0LEUH4le2AFxtEA9RL8Gi/FHIazpPD+2fBpkg4CsgyPPbOpAXl3sq
 gR1t1TUHkt6IJ1YKKtGbEkeanwuachmH0P8u/q5ZpCDyIg7uvYFPXGqlr4pSdExp74IvD9ROJo
 WTw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 16:54:19 -0800
IronPort-SDR: tmEO2mrY4MpP5DMKb5S8y14oex1KuJrJj0c+aUEr0ti+CpHjp6NvutPutnaT83EBx4Vv/UZu36
 rg+0LYQ91fwgCtg3bugK8clviscaP7vnRIVsbXq+BJ5Bwo03UrW3KSc6PpSNvfS+GFtiffDbtm
 /FNz+GIvSiQ8ez7wXh+aoDWg9siydH+fM3jK8UQaFdLpxztN6kHmDH5VRLf3/VB7MOCTS5NlYA
 30aiPPPu2MoAG9l974+FfQuKJgiB+QLMBdTpQK79Ri8ukLff54bZ9iiJxOPXjtOEqYgigaM6q6
 dKQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:41:03 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8JFB4Mjmz1RwvL
        for <linux-sh@vger.kernel.org>; Fri, 11 Nov 2022 17:41:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668217260; x=1670809261; bh=kWfbDk7epBE8N+lvIUYGuQa6NGCEfO5LUkx
        zV91Rv/U=; b=acKB5rbyd7hrfHD2WcnmJAZM0hles5KMhCVg5bTRE1bJsBgXIkJ
        M6SPUmxSD5C2N2i0rsyaXU6WXmWxdiwNJmrU6d6KKRtdMwssBJwNBlai2aeYpfhF
        aomIE2Iv5PVN4MdiMFAw/wiCSAmDTPtx7iUO/imZdktjrdIHn18KsKmvBmR72t5N
        +CvXhDLB7523CvgEs/qSgWUeKr5vwKrq4me6zbHRVzds/J/TWH6Nht7oZRvXeKQl
        zGZCqc2DAohrk0YWQcTYDerhSlA+qe8sAHlbvBhCWyRzfxxFADDczW/q35emG5yX
        CmIcE/FubHNMVpb6fIbjRiJkRexAtVoUwgg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YevITXCpsNUS for <linux-sh@vger.kernel.org>;
        Fri, 11 Nov 2022 17:41:00 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8JF265dcz1RvLy;
        Fri, 11 Nov 2022 17:40:54 -0800 (PST)
Message-ID: <e4076fcb-9736-937d-634b-5b8fb342723e@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 10:40:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y260tkNHc2vFITJ3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/12/22 05:46, Conor Dooley wrote:
> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>
>>>> Hi,
>>>>
>>>> as we all know, we currently have three slab allocators. As we discussed
>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>> two of them do not.
>>>>
>>>> The unsurprising reasons include code maintenance burden, other features
>>>> compatible with only a subset of allocators (or more effort spent on the
>>>> features), blocking API improvements (more on that below), and my
>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>> without resorting to spelling out the letters.
>>>>
>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>> two to be removed, so I'd like to focus on it first.
>>>>
>>>> I believe SLOB can be removed because:
>>>>
>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>> by putting all objects together, which has its CPU performance costs
>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>> SLOB impact is too much for those who tried. Googling for
>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>
>>> I am all for removing SLOB.
>>>
>>> There are some devices with configs where SLOB is enabled by default.
>>> Perhaps, the owners/maintainers of those devices/configs should be
>>> included into this thread:
>>>
>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
> 
>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
> 
>>
>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>> running make defconfig ends up with SLUB anyway, unless I miss something.
>> Only a subset has both SLOB and EXPERT:
>>
>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
> 
>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
> 
> I suppose there's not really a concern with the virt defconfig, but I
> did check the output of `make nommu_k210_defconfig" and despite not
> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
> 
> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
> boots etc, but I have no workloads or w/e to run on it.

I will try with SLUB over the weekend.

-- 
Damien Le Moal
Western Digital Research

