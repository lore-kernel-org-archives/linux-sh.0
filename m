Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4ACC433F5
	for <linux-sh@archiver.kernel.org>; Thu,  9 Sep 2021 09:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F02B60FC0
	for <linux-sh@archiver.kernel.org>; Thu,  9 Sep 2021 09:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhIIJKU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIJKT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 9 Sep 2021 05:10:19 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E5C061575
        for <linux-sh@vger.kernel.org>; Thu,  9 Sep 2021 02:09:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g11so711515qvd.2
        for <linux-sh@vger.kernel.org>; Thu, 09 Sep 2021 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hDmckIUhW4xP9T5NuiftLSR/C86BoP2/jqvqwaE02o=;
        b=elmkR1Bbh6XmYNFdzgh0hgTXafz4Xm0DePk4KvEIO4eKkY/YIFL35pXMyfKDDIMcly
         m+giVBWl+V9uwEV0R1rRrkCPH1EP8TVl3mMmI30FTk8fuLAX3Bnr41QZnH6fILp+yikM
         mwzRxmpQjeh8+vCXZPKaMJd6KmVkM8eIJv5xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hDmckIUhW4xP9T5NuiftLSR/C86BoP2/jqvqwaE02o=;
        b=s3rl/mxgbO94RRzBOv7++qXUeG4fPTJWLfNTpFFJ9wHr8Xy1kkVncRS9a61CpRVU1M
         gxd6P/UgJR42GsV8e6L8B4ms+nYShXjy0C8VOtwamE9vEnbGCu5Ln/6XeFB4fFlP/JtO
         4DYvEM4fSloHVGtX/NhTiYOV4wjFkz02WzbzRVypACwe/+wRysLdqFBkB+mr2OmAMXpf
         irhS5JcobyoJLfGgFRovI48e+yGc9evuOza6tjGZuyHScKHhu4LNJKshDPQjnwIfsGmO
         dIB9mxvq6WsUvtvnT8UE+qugXgp4MUyUaOmJL/taqZtdXQ9xRgNsCISMgcjRNtdCCCpr
         xw8w==
X-Gm-Message-State: AOAM532dOR+KUAs4372SmlKH6IO8Mb2CHfv0/t7VtD836WRrQN/3cFbr
        Kk8hbcCRtN0eTpO5asCmN4hdWMaxAiZflqdq+Zjf3w==
X-Google-Smtp-Source: ABdhPJyqcsQzQ2sNTrTC3KyamsklcPHgYm8JKQNFbYRhEoJIdXr8/z97k7va01bC8GJla73vfLab0CgBPRrMjeIJHUs=
X-Received: by 2002:a0c:f58a:: with SMTP id k10mr1865801qvm.62.1631178549225;
 Thu, 09 Sep 2021 02:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
In-Reply-To: <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 9 Sep 2021 18:08:58 +0900
Message-ID: <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

HI Adrian,

On Thu, 9 Sept 2021 at 17:25, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> There are quite a number of patches on the mailing list that need reviewing and
> I fear if that doesn't happen in the foreseeable future, the SH port is being
> kicked out which would be a pity given that we're still maintaining the port in
> Debian and given that there is new hardware available with the J-Core board [2].

This really is a poor situation. The fact that there are patches means
that it's not totally dead but no one ever looking at them really puts
people off bothering in the future.
I might have a go at getting OF to work on the SH4 hardware I have but
knowing that the patches will probably never get looked at is very
demotivating.

Can we get a new maintainer from somewhere?

Cheers,

Daniel
