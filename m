Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D60C433F5
	for <linux-sh@archiver.kernel.org>; Sun, 12 Sep 2021 17:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E82B60F8F
	for <linux-sh@archiver.kernel.org>; Sun, 12 Sep 2021 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhILRHM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 12 Sep 2021 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhILRHM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 12 Sep 2021 13:07:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8378CC061757
        for <linux-sh@vger.kernel.org>; Sun, 12 Sep 2021 10:05:57 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q3so9022883iot.3
        for <linux-sh@vger.kernel.org>; Sun, 12 Sep 2021 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLM/qMdzxceOUrX6oXopeVubbXjNKiq4kNF47n2hgmE=;
        b=FsZxfERYIM8U1yU21gKvztnQAGDhifbCdXvd/eWZvfA3yl3xfjfYdxns5LfOdPwKCV
         BBvODz7Ld2Jsy190Vg5t5plJCOqR12ZjW3lf+wfK3Pr8ftlU0bz5L3xLXkFYbl8It8In
         pfeIY4ojux8ipccpnMDAWxoHaJboDOowxQa5Q8TfjJtj7nWpeHI+ELOxEepPBIziOq6S
         6JrO6oMSKmhH7O3+k8OydPFcfTGLs6nyFnZSMtasNELvlgS8e7H1d+1vXxE3eM9EQD29
         N2Lpj2hVpzbZM1lIl21XByJhAkx/M39VBMmHeFTt3W97p1Q8/cMXIaCfC3Y4tbTWbiNF
         kZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLM/qMdzxceOUrX6oXopeVubbXjNKiq4kNF47n2hgmE=;
        b=Tp4NiDQEXNMAkccfMdUjHlkxqHfGJnvo8WHts69by9VKD/efLgOhPyad2RV0+HzleU
         NKnNDnJFEJI6sg26tRHt2c7ECMB6fCWF7SJy7+sErOA6OkNFxoHhGGONSXzOJ7z7p7XW
         Slmpg9SBQ3ypIyKAaNu/hRwdb0WIedy9eBGZ/ELF14dcybsZu0N0jHiFrl7kAS1udcSB
         tInAg5Fs0EZfcE658NBxD+AOHgHQkTAwxiA5UohWL1l82OkphQuQoQN7hwPhNAzbDFA0
         avHFBFAi71nawkBJ5eY0Z3Viwymr6uMLnU/dXOzK2QBGD117H4k/ELvfxhyf0rcpJpie
         KF3Q==
X-Gm-Message-State: AOAM530RV2isg2MEm3XnlLzH8UaCs8xhDVDx6hR2SCPHQgQ/xkFYb4Ke
        2ZqIuMRt5Xv7GBE2lKPVWd6aoQ==
X-Google-Smtp-Source: ABdhPJw99yFVxvHeAk0qT0t0AfUdPQbQVfbyFGP62yJs1ajIgYc+mMBgsA7/honfxQY4Rk/VuYPn0A==
X-Received: by 2002:a02:aa17:: with SMTP id r23mr6241739jam.52.1631466356813;
        Sun, 12 Sep 2021 10:05:56 -0700 (PDT)
Received: from [192.168.10.11] ([172.58.141.119])
        by smtp.gmail.com with ESMTPSA id t14sm3142441ilu.67.2021.09.12.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 10:05:56 -0700 (PDT)
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, Daniel Palmer <daniel@0x0f.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
 <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
 <20210912015740.GJ13220@brightrain.aerifal.cx>
 <5aa5301e-9b01-4e96-e185-13c2d4d7b675@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <7a7d2e62-8a8a-0572-8f9f-beb95deeabc7@landley.net>
Date:   Sun, 12 Sep 2021 12:25:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5aa5301e-9b01-4e96-e185-13c2d4d7b675@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 9/12/21 5:36 AM, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 9/12/21 03:57, Rich Felker wrote:
>> Hi. I see there's a situation that needs my attention here. I will
>> plan to review and merge anything important/blocking that doesn't have
>> problems this week.
> 
> I'm glad to here that you're still active. I will try to help assembling
> the list of patches. I won't be able to test them though as I'm not at
> home so I'm unable to reset the machine in case it crashes due to a bad
> kernel patch. So, basically, I just have one shot free.

I smoketest on qemu-system-sh4 first just because it's so convenient, then test
on my j-core (sh2+) turtle board because it's the next most convenient thing
(it's USB powered and one lives in my backpack).

>> At the same time, I am open to the possibility of a new maintainer or
>> co-maintainer if that ends up being what makes sense. Are there any
>> candidates?
> 
> I would generally be interested to help although I'm not as knowledgeable
> when it comes to low-level kernel development.

I'm in a similar position: I can put more cycles into this (and I've collected
patch stacks for Rich before), but I don't have the domain expertise to make
judgement calls about device tree representation, interrupt routing, nontrivial
lock ordering, knowing when you need a memory barrier and why...

(Also, I've been running up to 3 days behind on my email recently, and catching
up on weekends...)

Rob
