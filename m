Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA560C433E0
	for <linux-sh@archiver.kernel.org>; Mon,  4 Jan 2021 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E680207BC
	for <linux-sh@archiver.kernel.org>; Mon,  4 Jan 2021 11:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhADK7z (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 4 Jan 2021 05:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADK7y (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 4 Jan 2021 05:59:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4E0C061794
        for <linux-sh@vger.kernel.org>; Mon,  4 Jan 2021 02:59:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id dk8so26942401edb.1
        for <linux-sh@vger.kernel.org>; Mon, 04 Jan 2021 02:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2XTKO07RkHiN0jB+08Hz0QNSOJZsUf68U5bg9AP9cs=;
        b=u3Al1M7Wsh5+XczAi/pOAVxGnzkXUFMCkcxICIuYrz595GUTSAOZkoZvXz9tDIxAKt
         wqP3enhqv/unLZ6A3QVuN+L8+bnKO/HXnzLfMy0YMUVCsh0403c4sELYb7FEI7l70aZJ
         suxf6zZE4qw0gmPQ+G4J0fHkHlGAmWcaEHTszviYghZqCFJlISUjczqI2i442VkT+xzx
         YmzhfLEjXWl9LOC9ijsf7yRvU5U5pcgGd3+N2nRxWkRoL26NkLI1MCflaFGfbN0rSwlC
         DgpU6cFKd3uIkryUdxlilFNPCh1DlL0hhThGbzDvk3xLh8lgSJU2G+bnivZPkB6QXy/F
         g8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2XTKO07RkHiN0jB+08Hz0QNSOJZsUf68U5bg9AP9cs=;
        b=RGxHzbtQcYlVGx5SnpvTaG8SmZll/uvPZdIp6iOkScDsSvZWYFJKN/elgH613nPHZg
         9jDyKevrfwBMj19mEUKauEcrtndKx3k7t2aWt5tTcj4GE7tOv3JtDf8z+UB+h+34KG/L
         dSdd3La4Q1hyzdHxeU6yPZwIIuqmdhAVn7juUJ3vLZpkSu6lGfC8QZLV0rLNNVNsbbxB
         YlJx273Q7XA985CNK6k5SmNgs7tWe3fKl5xuFUQWXhrYZBvxA+eLAqtLK3osNh4aouFf
         V7578cjTZMUEMdEevLXeSEKAVCWiO5ejdAu8FYQ5RYc5tGJmQ6qbBbJFzopqzy6tz8dq
         ZOkg==
X-Gm-Message-State: AOAM532qD8YTs2uCRjA3EOK+AHVknotb0wNobUXbj7RBkOBsmM+Uiko1
        P2zwr2PpaovfOg8WZ5AdEq5unA7fZMrRJrYrzUXRHLnZmbXiVA==
X-Google-Smtp-Source: ABdhPJxEDCzGN8lF8s7Zq1HSgD41i43NfdbGXKwtZzJex9SqO6eZU3I/GnlTV4KTo8Zi829rcprET0w/CP+iAlxzf3g=
X-Received: by 2002:a05:6402:229b:: with SMTP id cw27mr69366993edb.23.1609757953078;
 Mon, 04 Jan 2021 02:59:13 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuNKqyvku1im6_zS5PjK9nG3Jf6qNwpQjaB8WRWO5BXzA@mail.gmail.com>
 <b516dd0d-787e-96bc-0f0d-3811c4be1642@physik.fu-berlin.de>
In-Reply-To: <b516dd0d-787e-96bc-0f0d-3811c4be1642@physik.fu-berlin.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Jan 2021 16:28:59 +0530
Message-ID: <CA+G9fYtpsoKjHR3Fr-so4SFopMUH+5m=RR9py2Uc9NKTmvm5Eg@mail.gmail.com>
Subject: Re: [sh] smp-shx3.c: error: ignoring return value of 'request_irq',
 declared with attribute warn_unused_result
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     open list <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, 1 Jan 2021 at 20:18, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hello Naresh!
>
> On 12/9/20 6:26 PM, Naresh Kamboju wrote:
> > Linux next 20201209 tag the arch 'sh' defconfig build failed to build with
> > gcc-8, gcc-9 and gcc-10.
> >
> > arch/sh/kernel/cpu/sh4a/smp-shx3.c: In function 'shx3_prepare_cpus':
> > arch/sh/kernel/cpu/sh4a/smp-shx3.c:76:3: error: ignoring return value
> > of 'request_irq', declared with attribute warn_unused_result
> > [-Werror=unused-result]
> >    request_irq(104 + i, ipi_interrupt_handler,
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         IRQF_PERCPU, "IPI", (void *)(long)i);
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> I can't reproduce this issue on Linus' current tree as of today.
>
> Maybe the issue has been fixed in the meantime?

Seems like this has been fixed in the meantime.

- Naresh
