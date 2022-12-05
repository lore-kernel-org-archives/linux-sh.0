Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD89C4708C
	for <linux-sh@archiver.kernel.org>; Mon,  5 Dec 2022 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLEMZ6 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 5 Dec 2022 07:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiLEMZ5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 5 Dec 2022 07:25:57 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5007863C8
        for <linux-sh@vger.kernel.org>; Mon,  5 Dec 2022 04:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670243156; x=1701779156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=neMU4Ok0awO5Rq5skIsVHn5TxIHDupVu3e9O7MCpojQ=;
  b=pTDUK1wUz7tmxn0Cd/iIQNWCHZzCyHTNl+sepQNL4JrtcOGWg+Qy1/S5
   oZY8AwetLFlE4G9DE/oyACmxo4tYHU1kZwy+KDIu7nBgOv5jP+L8seF3W
   RUp3Q8hyAH1GnqMhjh+zy7X85FSyRIB4KnubsjIAYU06bG9p05fuPhczJ
   9MRdLZF6J4aIsC5lVI7mpCFZvQNk+4Xj1TnS9J4uJqMKaNkrDYQdjMk5G
   G3YCuv2T9Pery9m/owL3QzOrjp/jElPP3KDGGEoE9GhtwQ8tqGaT3qahZ
   rMWZxZZl2teVmOXziYtpFQl04JH7kKOVgpPB7rZCM9Mt/BebjzwvkUJfG
   g==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665417600"; 
   d="scan'208";a="330010010"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 20:25:56 +0800
IronPort-SDR: OXIlC9C5+jrJn8xIql7U3yUDq7TTvwlXSnLVBUrVmAF7l3YQIh3e45i/KGFzvd//DRw7VylrUK
 AwNc8S4N/XAoZFBvRBTD6yKsmd+89qJ2Tcqs4PzeOmeoUx1W2pbsXIyHNXz1hkz2bCKI1rqxD0
 rCtsH1Fze+26WzvBCV+bJk/5jfiF6vp4gGiy93G1kGSjx8lhH4+HuyY0+h3KqCXndfu45rv+Bd
 z+fVE+FG+iNRkYUWFGW0lO48gufpQ03izlYAjP/Bg+E2bmdFkAP4lGbDWlwFNj5PawlRpvBJzt
 pJo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 03:38:45 -0800
IronPort-SDR: y5Qlqnns+gDCkqTvN4taaHBfr1Xy/RfdhO6Lztu+27RTjVCVRXVsDtjqb1ZFyzd3/ZVP7gBmwl
 3ypzGjQYaUE1GvR1+cov3wV66gBko0NUNGndDQu0k0oVl7YHMrXmOzzW5Gf75U069KrLRqHZlD
 tH2kYKlq5Unh1RUxb6fO0idBXQlTBevnvcFdfZohCTmkuPw2flym4Z1FTQhOaPWBCnEwi5lCxV
 p8Mxj7iIsiMXChQq1Zkqtf05pcA2WuhE/Spx38EiRZxlK526Z0Onmk0o9PaGZbLZFN6lLpcJCE
 ho4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 04:25:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NQjSg0YtMz1RvTr
        for <linux-sh@vger.kernel.org>; Mon,  5 Dec 2022 04:25:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670243154; x=1672835155; bh=neMU4Ok0awO5Rq5skIsVHn5TxIHDupVu3e9
        O7MCpojQ=; b=gTyQiIEtSVqvwVxAB8CGYS4bn2kbh+onxccWNV2pvnEJ+s1MACa
        HasKpuudsHW2I0jpWQdI60uCpE7syCOp5DmV8WeF6T6GDyzSPOBIxbLb7JDtpHL5
        z5WMuG/3pXadnoyPHiZTHDyRqi/tbpww8Sg/bIzhlqIcBH2f6rEuO69h9qEgK0Il
        YwwhRbfChGSHLra69SncbFAS7Oz90ikKUlvaT+EUgBl6anL+lhhs3zTcrxrzs8j8
        bdXdPtuE1b0NNsUMqYgYuSIBtAeQCvvpiy0EXzJwyjPKIe9SCPH9nwmayNXQzf2K
        BYgRH3gvTis3DJ01W8qmCcKom9ZOBBUx1mw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id letmxBM4uYKr for <linux-sh@vger.kernel.org>;
        Mon,  5 Dec 2022 04:25:54 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NQjSW6BW3z1RvLy;
        Mon,  5 Dec 2022 04:25:47 -0800 (PST)
Message-ID: <e62bc865-3b6f-2790-3dbf-6485cb233c4e@opensource.wdc.com>
Date:   Mon, 5 Dec 2022 21:25:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 12/12] mm, slob: rename CONFIG_SLOB to
 CONFIG_SLOB_DEPRECATED
To:     Palmer Dabbelt <palmer@dabbelt.com>, vbabka@suse.cz
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, 42.hyeyoo@gmail.com, roman.gushchin@linux.dev,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        willy@infradead.org, patches@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, tony@atomide.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org,
        Arnd Bergmann <arnd@arndb.de>, josh@joshtriplett.org,
        Conor Dooley <conor@kernel.org>, christophe.leroy@csgroup.eu,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org
References: <mhng-b0214281-7ee5-4698-a158-980427a97472@palmer-ri-x1c9a>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <mhng-b0214281-7ee5-4698-a158-980427a97472@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 12/3/22 02:59, Palmer Dabbelt wrote:
[...]
>> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
>> index 1a56eda5ce46..4cf0f297091e 100644
>> --- a/arch/riscv/configs/nommu_virt_defconfig
>> +++ b/arch/riscv/configs/nommu_virt_defconfig
>> @@ -22,7 +22,8 @@ CONFIG_EXPERT=y
>>  # CONFIG_KALLSYMS is not set
>>  # CONFIG_VM_EVENT_COUNTERS is not set
>>  # CONFIG_COMPAT_BRK is not set
>> -CONFIG_SLOB=y
>> +CONFIG_SLUB=y
>> +CONFIG_SLUB_TINY=y
>>  # CONFIG_MMU is not set
>>  CONFIG_SOC_VIRT=y
>>  CONFIG_NONPORTABLE=y
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Though I don't have a K210 to test against, maybe Damien still does?

I did test and it is OK.

-- 
Damien Le Moal
Western Digital Research

