Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940DAC64E7A
	for <linux-sh@archiver.kernel.org>; Wed, 25 Nov 2020 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AD0206D9
	for <linux-sh@archiver.kernel.org>; Wed, 25 Nov 2020 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="P7clXpYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbgKYRfJ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgKYRfJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 Nov 2020 12:35:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3FC0613D4
        for <linux-sh@vger.kernel.org>; Wed, 25 Nov 2020 09:35:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w202so2974612pff.10
        for <linux-sh@vger.kernel.org>; Wed, 25 Nov 2020 09:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BV0v+15X2FkT5Tc7Eld7ojOQSu1bWnaE02Q0w4hL2jA=;
        b=P7clXpYpTkbTzjUDjeeySiucJwLR/4OyJZbjvZgdNQEUGjwl2o5IOVKgS75he5LHo0
         6JO6035okSLOm+YGYKX5QE4T6DpBS56/9q5lvnRXJoMnRBONZI6sSFmNU41gUCJwL6bX
         YBFBA7MdyQTzUuqKq8hSbSlm8vIy7hT15TBGY2zBy7EbeTPM7SX+lGQ/Aie3sFcevUpv
         MyVU1TrA1qMRm5xEaT4Fa7+ZKk9Rqo9Kkf8A10HyK53iv9K+gt2n3I5KH2ABIrIYY5T4
         cSCHTeDSvp+D8M46aGEcMRIPtYwjPQaNz8B9tWB84hsy2GRIO93mrRr0PXT4zHDNyFsL
         bXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BV0v+15X2FkT5Tc7Eld7ojOQSu1bWnaE02Q0w4hL2jA=;
        b=QDxcm9T70ubYNWAdEa0lPo+VivF/hPKHDZxPlgetPZDezvzeuvem0voAQbgI+g4vxD
         j0PuvYHNI4vuE3glyG/Gq4HtIVA8rOSLLjoF1vh87/D6RcSps0PDtDGw2yutgXKwCaOj
         VqDWd+v4bdXKCW/DGZGKqXyvKJQjX3WLgy/yq2o9Mb2u+N9kjciy/R/nCEiEam8tt8fp
         +xpbH0Ndkig5A4TMokdvc+9lNQ+PrGBY0YujL600XNAJN3g4twX6FUUYyTFgYNguNaD0
         pzmwykQNz/vn4ik0+S/T0MEy3a5wItDr9XKMMtkakoTaszIHeQgwf1yk9RpeCzQXe6yi
         W7+Q==
X-Gm-Message-State: AOAM5324UkKqamytgFS0YzrAEkIP3jjF13fy1zwHsbMThfYxLnEPtOLz
        yw1kHS0dDY5nKSh+uxRnLvdcZyiJWmCrYw==
X-Google-Smtp-Source: ABdhPJxYIl8eaWz0+A1ayPioJqeo0AFpao3YZbgz+F/rFetyeXQVqI+Swe2bRVOasK90E/8VyjOo2g==
X-Received: by 2002:a17:90b:508:: with SMTP id r8mr5297588pjz.151.1606325708285;
        Wed, 25 Nov 2020 09:35:08 -0800 (PST)
Received: from [192.168.8.125] (mo49-103-34-100.air.mopera.net. [49.103.34.100])
        by smtp.gmail.com with ESMTPSA id a18sm2516739pfa.151.2020.11.25.09.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 09:35:07 -0800 (PST)
Subject: Re: message ids
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <401c48c1-ccf1-8177-d45b-eb632ba799df@landley.net>
 <e43e6569-99bb-4e24-e9c5-45f9c3244d86@landley.net>
 <CAMuHMdVJFLhJtVCv+M1zxOu2DpGi3o5GAi4VTf7OQsx_gYypeA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <2b4e374c-f1a3-87b3-5536-eb965b09d7ff@landley.net>
Date:   Wed, 25 Nov 2020 11:46:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVJFLhJtVCv+M1zxOu2DpGi3o5GAi4VTf7OQsx_gYypeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/23/20 2:11 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Sun, Nov 22, 2020 at 4:00 PM Rob Landley <rob@landley.net> wrote:
>> On 11/12/20 1:47 AM, Rob Landley wrote:
>>> Message-Id: <20200917154547.139019-1-fazilyildiran@gmail.com>
>>> Message-ID: <93d98bab-01dd-5530-9fdb-76faf8dcdd41@infradead.org>
>>> Message-ID: <20200919025206.17729-1-miaoqinglang@huawei.com>
>>> Message-Id: <20200924043139.522028-1-hch@lst.de> # does not apply with git am???
>>> Message-Id: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
>>> Message-Id: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
>>> Message-Id: <1604889952-30841-1-git-send-email-wangqing@vivo.com>
>>> Message-Id: <1604889303-26722-1-git-send-email-wangqing@vivo.com>
>>> Message-ID: <66582445-4ec9-86d0-e286-8e21590f608a@kernel.dk>
>>> Message-Id: <20201110154939.3285928-1-geert+renesas@glider.be>
>>> Message-Id: <20201110155029.3286090-1-geert+renesas@glider.be>
>>>
>>> I have no idea why the hch@lst.de one applies with "patch -p1" but not with
>>> "git am", that's where I ran out of brain. But they all apply as patches and the
>>> result boots.
>>
>> FYI here are the patches from this list I forwarded to Rich right after -rc3
>> came out. They built in my local tree, the result booted, and I didn't spot
>> obvious regressions.
>>
>> If anybody else wants to try them, I can put them in a -git tree or attach them
>> to an email?
> 
> BTW, the modern way to refer to patches is by prepending
> "https://lore.kernel.org/r/"
> to the message IDs.

That was a grep of the saved email files because Rich asked for msgids, and then
I forwarded the email here after 2 weeks later after repeated poking didn't get
further action on the pending patch pile.

I just did a fresh pull and git log arch/sh/boards/mach-sh03/rtc.c and the last
time it was touched is January, despite

  Message-Id: <1604889303-26722-1-git-send-email-wangqing@vivo.com>

Touching that file. (And that's an obvious "remove duplicate #include" not "I
decided not to apply this one because $TECHNICAL_REASON".)

The pull I did was to a tree with all the patches applied and it didn't complain
about conflicts, so presumably they still apply?

Rob
