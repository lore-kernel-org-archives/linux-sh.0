Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6234C433EF
	for <linux-sh@archiver.kernel.org>; Sun, 14 Nov 2021 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998F260EE2
	for <linux-sh@archiver.kernel.org>; Sun, 14 Nov 2021 19:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbhKNTuu (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 14 Nov 2021 14:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbhKNTtT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 14 Nov 2021 14:49:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2021C061208
        for <linux-sh@vger.kernel.org>; Sun, 14 Nov 2021 11:44:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e3so25679228edu.4
        for <linux-sh@vger.kernel.org>; Sun, 14 Nov 2021 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhbWqnuppc9VHvw+T3sw7eqZTs709xUitHO7OSRR3cA=;
        b=RwkFiKJYladEGPysc3XBrcV7nziE7tUOkzLFggYNkVMZ1jil+kZIz9CYu5Kf9OFvL3
         Id17PglUQHb26nyeroZEeodszlRGrMRBGNjni6wK+2S6C+OHC8hcMgVjr5mAywX/iJN5
         Y/+LbD/jVkSN1IM4toWOl9TqTHR3cFxKvLvzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhbWqnuppc9VHvw+T3sw7eqZTs709xUitHO7OSRR3cA=;
        b=hTDP8quRaXziVTT7ch2+uL8LWjcRDo0x/1PuCdVyLCw3/zNarvC1b0YDqYxp0vMb5f
         eUEqHVZnZZkUvpUnFpiW1bVhvU1LXdTMMcW6DGSG3I1FaqwaLAdWAnOWnHJSQjrun4Dx
         7KlX1yGicuntSXYy/amVGifwH6YewnYwA7YA+li5VKCCCIbHa1HqCAzpmwRUkBgaRhUO
         a5N1BaE/03EEsY+Q2HUA6Z6Of8NQer4F4ABatEymSZ4CgQjDSFD+ADXPDYUk422LzG8I
         m9sPDN4fNzgRvFsdHBt01ciJ9GkyRyAIZ0xe4CrdmZsTa4OEH8Vlh+xeun0Uk/HIdV7q
         NecA==
X-Gm-Message-State: AOAM5339zs8GzNrLGQvgW6yPBrxKAqVmQv04FPUG30RIbpTbMs3HmULa
        DDGkVzqLbW5fAWuBP6//KlI4aCKXj7reYtyxrL0=
X-Google-Smtp-Source: ABdhPJxs08vCUkkUTkbrrSg7mBzJAQ+H3KAsOm4w2JVH+hcUuyFoCo4I/+Xg5rwtF88LatT3L0AamQ==
X-Received: by 2002:a05:6402:4d5:: with SMTP id n21mr45432539edw.303.1636919065755;
        Sun, 14 Nov 2021 11:44:25 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id jg36sm5368543ejc.44.2021.11.14.11.44.24
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 11:44:24 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id u18so26318587wrg.5
        for <linux-sh@vger.kernel.org>; Sun, 14 Nov 2021 11:44:24 -0800 (PST)
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr40526435wrt.131.1636919064600;
 Sun, 14 Nov 2021 11:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20211114185302.GA13363@brightrain.aerifal.cx>
In-Reply-To: <20211114185302.GA13363@brightrain.aerifal.cx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 11:44:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjro+9wzY=Po2PC3JHjUoaYegtOVaQmAdEufa4fo2aedg@mail.gmail.com>
Message-ID: <CAHk-=wjro+9wzY=Po2PC3JHjUoaYegtOVaQmAdEufa4fo2aedg@mail.gmail.com>
Subject: Re: [PULL] arch/sh updates for 5.16
To:     Rich Felker <dalias@libc.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, Nov 14, 2021 at 10:53 AM Rich Felker <dalias@libc.org> wrote:
>
> arch/sh updates for 5.16

I realize the answer this time is basically just "random fixes", but
even in that case I'd actually prefer to hear it spelled out what the
pull request actually contains.

I've pulled it, but please do give some indication of what has been
going on in sh land next time, ok?

                   Linus
