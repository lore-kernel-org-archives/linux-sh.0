Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A9C11F65
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7790561C9B
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhF3JpB (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:45:01 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:36631 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3JpB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Jun 2021 05:45:01 -0400
Received: by mail-ua1-f46.google.com with SMTP id g21so795780uaw.3;
        Wed, 30 Jun 2021 02:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xl5NeFOIsI3Sk7MVUzbxj4kzQalIdqLW+9gbaGWjxMg=;
        b=NjB/ipHPkuZwjlJvzsM2dDo6egCpSMuFrDLiDGT1MhvaIQl2CgJhsAlAoiibJfXs4R
         F/PUEztxFu1nj/6RI/V51S0XcFsoGDGpQ+++gQUHORUIr01icSp9ZKajsyzmYGoZ4Wre
         L5tweT26w0oJPvHgFa8FMA3OLellsKWbGFvm8YArbHl04Bh9bsgEfmPKzZl2THkKEZ9v
         23yUn2P+KdEkwq+DZE/ioK+M8n+hQUWAcVgLsztJfuN91Ws8Y9y9rEoa1yOhWNoZKffZ
         JJLbZec27PRf9hFSnwgtg4xMwo6UHgEL7fhGIop2jtM++7oMz9Y1LZBTjsloWDlwc4D1
         omog==
X-Gm-Message-State: AOAM531dDfDz6i4FBqGUUgOdVh+sIkmTwQ1XkcDTMqr1+KsCq3y2JvI4
        Sqye26Hzd9TplhaQrUrQseL67hkRWR0c1Y+FC37Mq+t6o5QFsg==
X-Google-Smtp-Source: ABdhPJy59Q7579VDqY03zoPtW3ZRoKON7mejTBYjl8FhrRPTrrTiMLsDTJDkwWiaYXtDHO1PcH2rDgISAjsQXBHNSQQ=
X-Received: by 2002:ab0:647:: with SMTP id f65mr31277210uaf.4.1625046152037;
 Wed, 30 Jun 2021 02:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <20210627220544.8757-4-rdunlap@infradead.org>
 <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
In-Reply-To: <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Jun 2021 11:42:20 +0200
Message-ID: <CAMuHMdUDEOicErpLuheXGReV6QpsV+r6tM468g_6fs7KFYrAnQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Adrian,

On Wed, Jun 30, 2021 at 11:36 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/28/21 12:05 AM, Randy Dunlap wrote:
> > kernel.h defines READ and WRITE, so rename the SH math-emu macros
> > to MREAD and MWRITE.
> >
> > Fixes these warnings:
> >
> > ../arch/sh/math-emu/math.c:54: warning: "WRITE" redefined
> >    54 | #define WRITE(d,a) ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> > In file included from ../arch/sh/math-emu/math.c:10:
> > ../include/linux/kernel.h:37: note: this is the location of the previous definition
> >    37 | #define WRITE   1
> > ../arch/sh/math-emu/math.c:55: warning: "READ" redefined
> >    55 | #define READ(d,a) ({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> > In file included from ../arch/sh/math-emu/math.c:10:
> > ../include/linux/kernel.h:36: note: this is the location of the previous definition
> >    36 | #define READ   0
> >
> > Fixes: 4b565680d163 ("sh: math-emu support")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

> This one no longer applies to Linus' tree:

Worked fine for me.
Ah, Linus tree still doesn't have b1deeeb93933d390[1] ("sh: fix
trivial misannotations"), which has been lingering in sh/for-next
since the beginning or March.

[1] Note to Gmail: No, I don't want to correct this to "b1de b93933d390".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
