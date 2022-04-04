Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEEBC433FE
	for <linux-sh@archiver.kernel.org>; Mon,  4 Apr 2022 23:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiDDXgb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiDDXg3 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 4 Apr 2022 19:36:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BEE5132F
        for <linux-sh@vger.kernel.org>; Mon,  4 Apr 2022 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649115269; x=1680651269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+5MMmPyU6ZJJ0lTiy81U+nJ/FsY36S456cHlcxHKPSc=;
  b=GYrYJBoFgM+ducMPKoqP6fknGJVwtHAaMvbGF/XNau1AgYVVN19RRLeK
   gxsSvsfA6mxahtOaJy9hCLlM6Jjc9loxJm0tsgnpmDCkAq2uhRyf7kjea
   fGqZkWAVqOx2ysqUm3oHO+ylceIYUgYWk6bwuoH9UBhPHckbMWyswi1TQ
   b93iUBSXoeFnQcYFUSa9lKVNf3Mb+OzoaxWXbtGPXe7NzKUeT/RXiJtou
   YNyEsf+X6QVQIcCfiMdF+5ssC4x9BSbw22McdOOnnIWjI1dPZUylLkVhS
   CyKCxLGGA2mX/gRlPESWlbmD5MKKu7CPSp6XiGj1qoOJiZzwavLdD35sU
   w==;
X-IronPort-AV: E=Sophos;i="5.90,235,1643644800"; 
   d="scan'208";a="301247871"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2022 07:34:26 +0800
IronPort-SDR: rLuSE1MHiII4KfLsHvac4V+Xh2TbOnKHs7AiDTLqhM1eWDUHBi5wrdiHnP4ebNDfl/KBelNM1D
 vJprYefovGKD7E/BHi4KSc1JuQZ2OlBAEVFEsE6UTFpA8KEUfhEi0tiw0hOdGeZmSf9im1U5QQ
 lx2A+YkoRdiU2Cpa/yb6P/DMvzPYOAyVuuFd6f4xVVldGBPIlXBSoyw93ruPuO5sRvkVzyJJn0
 NFeCxoYR8NSNF1qUB6SmRKFhgH2E6Brc6OswiNh9a/hi82gNqRs16RXsUJNGYmqW207f0kl1Xi
 +OjQ89R9SWyeGS1NL3Gpf2Xt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:06:00 -0700
IronPort-SDR: bcvJhs35JRqeDl3Oe4EuOy/9/dIBdJ3ECHegieotfvgmqbufQ4rI7LCFPJoUc9h8FZvClVYo6D
 kKGm3C8ZNo+hySQ92Jjl3/rXXoZSFT1e3yp6cqGNOtO4ccMQUHR2BkXkmt/FC8UK6nm9cC7Ipi
 X0k4EzdRhNgr6Cq8XO/oReC+E1Mqy9PgBXV+CJKw/Bkxpg2ZTvTiq2ci9vWEoL23QszXJ+hjVr
 u7oy31I5+YCJ5FHVbY5xUAeNgOeAHsGkwx2DpvGQOgXiq2BQhWzWwRTKdLg1HeITW1SrtzMSFL
 NFY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2022 16:34:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KXRv55W7Sz1SVp6
        for <linux-sh@vger.kernel.org>; Mon,  4 Apr 2022 16:34:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649115264; x=1651707265; bh=+5MMmPyU6ZJJ0lTiy81U+nJ/FsY36S456cH
        lcxHKPSc=; b=NmXGSpihtKJypsJDwlOSBugs5bzoYpMuuBDgh/oBqIn+/Eb8mMq
        lI6D/MptbIBjXUVDl/UMgUaRdw4yZZvwum/7IJjbVyOrmgTT+k/7Pf/TIW2Szu6k
        gc7mfbb8PoLSzmV7Wh2r1w3TskdGFURxSc8XADmTZENiyab6u+3Ep2eTIOdqdSF6
        NWkS2OD25F1vSAjy1UWzi5Cy3L1OuNi1q6ge7xGAumKL2x02HwBUCiLi9eXMfRNm
        SiZfFUOR8TizSU1svfJKmtFfvy1CHmvgomNA5aLGazPZojpQLhdHYFwFf34/zQHz
        XYUG2Wmpho9kURuveUVhewHi9fGM2cECXOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tSLO39BElkiT for <linux-sh@vger.kernel.org>;
        Mon,  4 Apr 2022 16:34:24 -0700 (PDT)
Received: from [10.225.163.2] (unknown [10.225.163.2])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KXRv20dN1z1Rvlx;
        Mon,  4 Apr 2022 16:34:21 -0700 (PDT)
Message-ID: <5245096f-6003-39a9-6e5e-db2fc4f567fd@opensource.wdc.com>
Date:   Tue, 5 Apr 2022 08:34:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rich Felker <dalias@libc.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 4/4/22 22:22, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Mon, Apr 4, 2022 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>>> On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
>>>> If there are no other objections, I'll just queue this up for 5.18 in
>>>> the asm-generic
>>>> tree along with the nds32 removal.
>>>
>>> So it is the last day of te merge window and arch/h8300 is till there.
>>> And checking nw the removal has also not made it to linux-next.  Looks
>>> like it is so stale that even the removal gets ignored :(
>>
>> I was really hoping that someone else would at least comment.
> 
> Doh, I hadn't seen this patch before ;-)
> Nevertheless, I do not have access to H8/300 hardware.
> 
>> 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
>> changes, but I think
>>     Rich still cares about it and wants to add J32 support (with MMU)
>> in the future
> 
> Yep, when the SH4 patents will have expired.
> I believe that's planned for 2016 (Islamic calendar? ;-)
> 
> BTW, the unresponsiveness of the SH maintainers is also annoying.
> Patches are sent to the list (sometimes multiple people are solving
> the same recurring issue), but ignored.
> 
> Anyway, I do regular boot tests on SH4.
> 
>> 5. K210 was added in 2020. I assume you still want to keep it.
> 
> FTR, I do regular boot tests on K210.

FYI, we identified the problem that makes userspace execution unreliable.
Working on a fix.


-- 
Damien Le Moal
Western Digital Research
