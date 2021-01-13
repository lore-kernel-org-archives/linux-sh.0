Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A1C433E9
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 13:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E45223434
	for <linux-sh@archiver.kernel.org>; Wed, 13 Jan 2021 13:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbhAMNNm (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbhAMNNj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Jan 2021 08:13:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1318C0617A3
        for <linux-sh@vger.kernel.org>; Wed, 13 Jan 2021 05:12:59 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s75so2044066oih.1
        for <linux-sh@vger.kernel.org>; Wed, 13 Jan 2021 05:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fdbS54GqVo27RKIb394FVommJ3jzsvbwkChCJpoBs10=;
        b=PVEbqAZeBJW2YFegfj76rdkG/cpKL0XGDuI4Qp+3Iu0ffmtJ8yVlTSlZkyDsUrxoW1
         1aPrQrl8kFj6kunyZgCZepDkdQNsYdntoFKz+LJzfff5ynbU4H4efTQpjHkpeHFzCyjs
         z94LkXlQwj5i1/xQgnxGTq6JZTvWlm8NeCC0XmCNKCIFvG0JYc5Ioqq9eK9LmLcjLEk1
         gwwFvOWvNu3mc3M1VacdRE3SAKVL5TCnc9fmr13dLg2YWsltAGP6Z5FNFY2RMF68TWNw
         RP69+RZWbMcIKjDi2HbzBRGPh1Z3D63bDm6OMzXSjnMkN8VjjYECePY1i1vwqdpXgal2
         RALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdbS54GqVo27RKIb394FVommJ3jzsvbwkChCJpoBs10=;
        b=ncdULhr+kcB1N8+xD17jPlhmXwT1A5wrmFtnsP4EyopjEzH0Sncu6FSI+xiM9SKaSt
         8qfBveuMPzMKpALzAOF7kMPykPQbpSC/wHXDrBcPXD0G2Kj1aCulUpL3B6veJHQ6jcv1
         d9aePHMXSG7FPtK8+9RelFfQeJI/98yTmeQ4LOkzbMqPnj1B0P54+frs1ntyANIZN97f
         nbFzabs4xoJCYEIdhB12aDQh2bsNK+oqQZMYx6G1zLJFhYxF3UKdj4oC+8VOVjN+Rwgi
         /z4eyUHUMkfRiTGXYSo28PwcyggkMOV7pLS+eCG/egoOqEkhDlxrm672xhhXKlqVvyp8
         Hc+w==
X-Gm-Message-State: AOAM530vpbLaEIDUdLjGBQIfbTbzV0Ogxgftq7m3mOK3cfAN1bMIOd+A
        gO1TfFNKLQd7Bt8359FwieA02047J3YdWZ+V
X-Google-Smtp-Source: ABdhPJxKBnozlqjNqarKxoCMuLzs+VDColNyRj35Xxa4TM9sLnGr/J2365+4IBng3r7eYq3swz0amA==
X-Received: by 2002:aca:1006:: with SMTP id 6mr1079084oiq.159.1610543578610;
        Wed, 13 Jan 2021 05:12:58 -0800 (PST)
Received: from [192.168.86.73] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id j126sm388108oib.13.2021.01.13.05.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 05:12:57 -0800 (PST)
Subject: Re: Old platforms: bring out your dead
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
 <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
 <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
 <CAMuHMdUNe1A0RpkYdyRy9OJ+RDfUe_3KcAVnsCK+pP0jzJwtVA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <ad9688cc-ef99-212e-103a-56d9cc32a334@landley.net>
Date:   Wed, 13 Jan 2021 07:25:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUNe1A0RpkYdyRy9OJ+RDfUe_3KcAVnsCK+pP0jzJwtVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/13/21 2:21 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Wed, Jan 13, 2021 at 8:58 AM Rob Landley <rob@landley.net> wrote:
>> On 1/12/21 4:46 PM, Linus Walleij wrote:
>>> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>> Yeah, I have the same impression that's the strong commercial interest pushes
>>>> hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
>>>> they're motivated by corporate decisions.
>>>>
>>>> There has to be a healthy balance between hobbyist and commercial use. I understand
>>>> that from a commercial point of view, it doesn't make much sense to run Linux
>>>> on a 30-year-old computer. But it's a hobbyist project for many people and hacking
>>>> Linux stuff for these old machines has a very entertaining and educational factor.
>>>
>>> This is actually one of the most interesting things written in this discussion.
>>>
>>> I have both revamped and deleted subarchitectures in the ARM tree. We
>>> never deleted anyone's pet project *unless* they were clearly unwilling to
>>> work on it (such as simply testning new patches) and agreed that it will
>>> not go on.
>>
>> Another fun aspect of old hardware is it serves as prior art for patents. The
>> j-core hardware implementation schedule has in part been driven by specific
>> patents expiring, as in "we can't do $FEATURE until $DATE".
> 
> Indeed, so that's why the release of j4 is postponed to 2016...
> /me runs date (again).

We renamed it J32 because although the patents have expired the trademarks have
not, and provoking Renesas' lawyers more than necessary seemed gratuitous.

It's actually been feature complete for years now, but we've never ported the
kernel to it. (Rich has been working on a kernel port since new year's though.
Jeff Garzik sponsored some engineering time in our 2021 budget to finally get
that done, which has been our blocker for publishing because the lab tests don't
guarantee we won't have to change bits of the API in response to real world loads.)

>> When I did an sh4 porting contract in 2018 I got that board updated to a
>> current-ish kernel (3 versions back from then-current it hit some intermittent
>> nor flash filesystem corruption that only occurred intermittently under
>> sustained load; had to ship so I backed off one version and never tracked it
>> down). But these days I'm not always on the same continent as my two actual sh4
>> hardware boards, have never gotten my physical sh2 board to boot, and $DAYJOB is
>> all j-core stuff not sh4.
> 
> Which is not upstream, investing in the future?

Alas I'm not in charge of what is cleared for public release. (I complain about
it on the weekly calls from time to time.) We have actual marketing people now
(Mike and Bunga) so I'm not supposed to do the website in raw stylesheet-less
html with vi anymore.

Unpublished stuff we _mean_ to publish is a form of technical debt. It
_shouldn't_ be (release early release often) but Jeff insists on doing
everything in Mercurial which makes dogfooding our github repos as part of our
normal process darn awkward, and once there a little out of sync with the rest
of the build it becomes a todo item...

Rob
