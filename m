Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF48C433DB
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 23:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D0B22E03
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 23:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbhARXcM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbhARXcK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 18:32:10 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3EC061573
        for <linux-sh@vger.kernel.org>; Mon, 18 Jan 2021 15:31:29 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id o11so18042654ote.4
        for <linux-sh@vger.kernel.org>; Mon, 18 Jan 2021 15:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B9jQLeuzniqUa+ZliXEHh8xjADWj1tX2whfa7fJ1Ffw=;
        b=J37ulR7IkwWTz+C9+n7/qGZWHzJm7IUhGlSb9+jPTGFmMge3Z9U7Tkrz4g/PZm3Lbl
         VFaa0NgWKC6DeAD0nqznNwuEn9hYOiywMEmTLSz68468stH8j+fZN3zNsi+hWunkDiBu
         IGjr7leYS3fVcM5wGgy/7WQBjG4HT8mCHEa++Rk3HWGzUL67i6COhfSKeJ3zaiZkVF1I
         8iWwWRS2z5jbF7UtcrskZsOHVmqqSzUZUZb0HF7YyTXK+CI0i5qrieTO+HJODqPwwtQ8
         YN6bKKZtPitdLqbvIsnGM31DSAMVgLSi1OvbTDINpxm5kakOI0fRWvgN5wGwaA5RQ4vY
         MU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B9jQLeuzniqUa+ZliXEHh8xjADWj1tX2whfa7fJ1Ffw=;
        b=GraU7T9pGnR3ubgOU5u+ddeWQ5MNIqwRu+ong5Oi7vWOminUkaBETq9CJ89gPm96fA
         Vme18iNlFIVR+YNq4Nfzp0gGQ7s5amanqRTiFip9Vwe6mzwNC5vDwRbxfso9S11iSFUU
         4c0LRswStYez82bFKGy5997w7ZdA7MhtiO/yGbn7x2Jg6K/sKln0y9DW74QZUt1hvnkE
         2O12cHkH3VPwVaafDnMB1PEwsu+42MddtK4EX0X+JlfQAh8c4npOVSW+ZFBvcJohksQ8
         guP+IvoSfqersiVTdYuEUFTulcXGgq6d7uwR908IQdBERXlvpLKGaKzCfJWjlgTkCbYr
         U6Xg==
X-Gm-Message-State: AOAM531WcKRXnarG3TmOmFJKZ729+3fVorMyoysObHRqeHVduDsOwmB4
        iwsqbPhan4DaRs8TnB0l0htGkw==
X-Google-Smtp-Source: ABdhPJxDg6RY2D2DwJRsQCNbDBhP5C1xuhvI+PCSvyzgQkBQSbxmIsJtkSdC/xsvmP7FEE6BzW5aNQ==
X-Received: by 2002:a9d:1d64:: with SMTP id m91mr1417911otm.290.1611012689416;
        Mon, 18 Jan 2021 15:31:29 -0800 (PST)
Received: from [192.168.86.73] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id b19sm3568933oib.6.2021.01.18.15.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 15:31:28 -0800 (PST)
Subject: Re: [PATCH v1] sh: Drop ARCH_NR_GPIOS definition
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio <linux-gpio@vger.kernel.org>
References: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
 <20201109121333.GC4077@smile.fi.intel.com>
 <10b4dc8e-db87-3f78-3ab7-e08469b9fe55@landley.net>
 <20201228213615.GF4077@smile.fi.intel.com>
 <3a20bc0f-cbdf-6498-5527-e7fd53c3b84d@physik.fu-berlin.de>
 <65ae5b43-d98c-8acf-8324-f83b8abbfa15@landley.net>
 <5606052b-0b3e-da9f-df36-39f0f625923e@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <6d756660-964e-a416-6f36-dccd54c81362@landley.net>
Date:   Mon, 18 Jan 2021 17:44:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5606052b-0b3e-da9f-df36-39f0f625923e@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/18/21 2:20 PM, John Paul Adrian Glaubitz wrote:
> Hi Rob!
> 
> On 1/2/21 3:12 AM, Rob Landley wrote:
>>> Rich already mentioned that he planned to pick up any patches the next
>>> weeks/days.
>>>
>>> I'm currently testing all the patches recently posted for any regressions.
>>
>> I spoke to him on wednesday and he said he was working on it.
> 
> Any news on this? I have tested or acked all patches now that I found on the
> list that are not applied yet. I can assemble a list of these if necessary.

I spoke to him on the 13th and he said he was working on it, just like I spoke
to him on the 6th and he said he was working on it. And so on for a few months now.

Assembling a list wouldn't hurt, but I've assembled a list at him multiple
times. I suspect what I need to do is assemble a git tree and submit a pull request.

Rob
