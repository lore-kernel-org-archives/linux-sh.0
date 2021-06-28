Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AE6C49EB7
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36873619B2
	for <linux-sh@archiver.kernel.org>; Mon, 28 Jun 2021 09:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhF1Jc2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Jun 2021 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhF1Jc2 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 28 Jun 2021 05:32:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FFEC061574
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 02:30:02 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z3so325049qkl.4
        for <linux-sh@vger.kernel.org>; Mon, 28 Jun 2021 02:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E72ySZbZCZJUglG4bV3l9a6211R6RN9M28XMGqPmIic=;
        b=Og6yi3wkkqPF391Xj/IuoiwJsVRCZ7ibznjPyr58+t2frYgGOcragsAcbWEw9/Lm9g
         5J2lkz3uaWNxLLDGVAdFcVFoNOD0Pl8tuHH87b4eBkGTZgyGkyNGJ0lOW6lqlOUHR0gT
         z3PbhZhyYWufY/vvxuBAiweYDOLC4KefQuoto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E72ySZbZCZJUglG4bV3l9a6211R6RN9M28XMGqPmIic=;
        b=gDxgT1hd9Cotke+20SSE0dnL18QGMj2S/rJhrXi16izKywyW38nzW27kHBnq3/gm+V
         57lSR7fNfxnnv99NqpxKwnmsfT4gowu6830OQ4QUF/X7y6IgAKCzrcZ/TglWrGPTGm11
         amp/uDpLFJ1JLZncjzXcA+QpZJ5E8EXFilW4LDT30MXfDFBkVRG4m679yBtUlquRms9g
         1G7pF3l6YHbhBP9lCScZQwpmSWCsnaqoDRN+uxz91PfKh33If7cIMPc38Iyuhh+vJLaI
         LjrJcmBbqC8i3bkc82fPVFvPNValbfLaG1pVs/o6X0yubOWI3u8nD5KufJLjt8zYh12u
         cqrQ==
X-Gm-Message-State: AOAM530iQuQPHfb7pooqUILdvr8YXC+ySqsDUzFYcWJe9qgc9v+cVbYw
        5FgGuZ3D2f/suPyLPn+Ef90gosEwzP9ImnhaQwc/q/wBrIA=
X-Google-Smtp-Source: ABdhPJwxqWTFWg875LeELm0St37Pwr8hO8VE72D3ovSrwjzrF4LIZI8Xq0Wumaj6tg+ZVpzLbABfLc3yhLSnNpq5slE=
X-Received: by 2002:a05:620a:cc1:: with SMTP id b1mr24390353qkj.468.1624872602089;
 Mon, 28 Jun 2021 02:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de> <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
 <27c78c11-b230-a5b5-6648-6b93daf6afda@physik.fu-berlin.de> <CAMuHMdV+SmxUtvAptYfVgy04jCHeABmsEpn3mcUfFQ_RfTF7eA@mail.gmail.com>
In-Reply-To: <CAMuHMdV+SmxUtvAptYfVgy04jCHeABmsEpn3mcUfFQ_RfTF7eA@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 28 Jun 2021 18:29:51 +0900
Message-ID: <CAFr9PXnuFWFy-3mUAo63aiP5qXmD9ULycWVn=_YG96ReohJAjg@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert,

On Mon, 28 Jun 2021 at 17:57, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > There is an unmerged patch set by Yoshinori Sato that adds device tree support for SH.
>
> But it does not include support for SH7724 yet, only for SH775[01]
> (note to myself: still have to try it on my landisk).

I have some landisks. Is there a sane u-boot for them? I think mine
still have the hacked up lilo thing.

> Fortunately most core devices on SH7724 and Ecovec should already
> have DT support in their drivers. The main missing pieces are
> interrupt and clock support.

This sounds like a fun project. I'm not sure if I could manage it
without the Hitachi/Renesas debugging dongle though.

Anyhow, it would be a shame to remove the ecovec just because it
doesn't have DT as it pretty much fully works with a few small patches
to fix some bit rot like ethernet and the LCD not working.
I sent a patch a few years ago for the ethernet and never got a response. :(

Cheers,

Daniel
