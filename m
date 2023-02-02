Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6574C61DA4
	for <linux-sh@archiver.kernel.org>; Thu,  2 Feb 2023 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjBBIW6 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 2 Feb 2023 03:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBIW5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 2 Feb 2023 03:22:57 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B959483957;
        Thu,  2 Feb 2023 00:22:47 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id s4so594210qvo.3;
        Thu, 02 Feb 2023 00:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNok7JkPboQ/45m03QkrG01Jx3vGfVh+k6zj14L0L94=;
        b=Qio4TO28ODdpYrF9w/vX0JbaRbZ44ppyUoAHpxW/26lLPQQMmAkt0zj+8UCkz2nVtR
         NxwnVk7pXwWIOXJ5KANAb69YTxHBOYAAe2rmxEZevJyWtYETsvR04j0VIUiLke0YbjSf
         YetSPAL883nnJOCvZ0OET+rQ5TJFnDoGczXhnXNZnRYqrM0XCazxT+VFXK6oh73wB/dz
         NQcVM3FOP3NOSXvF2A7NKwNbuTx7zwcYx+izNRHOiFH5/FztJzXEYmluV+yLv/swSuvn
         Qpdq50em3vtL2T2MkVhdUmPufEvT30oezfZRtO68eDf7W6pthBUoiGVDMyjIDW9v6Ahp
         w6xw==
X-Gm-Message-State: AO0yUKUDnMJV+dgmWNUPj9Q6yLizD3FkO5z4uxebanSHRAzIQljqfXV7
        b6AG08z75xnbAlH8/ADqWpdUetcv2m7mLg==
X-Google-Smtp-Source: AK7set9TXKWJD+CSQElX/nQkU+0IqgziUt03hDKtv3XMmcqhVwA+EB7s76NU6Vxv2bTH0INQ6MhB3g==
X-Received: by 2002:a0c:b306:0:b0:537:7d76:ea7c with SMTP id s6-20020a0cb306000000b005377d76ea7cmr7679308qve.25.1675326166411;
        Thu, 02 Feb 2023 00:22:46 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a204a00b006fef61300fesm5735367qka.16.2023.02.02.00.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:22:46 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5217ecc51d5so16232987b3.13;
        Thu, 02 Feb 2023 00:22:45 -0800 (PST)
X-Received: by 2002:a0d:c2c4:0:b0:514:a90f:10ea with SMTP id
 e187-20020a0dc2c4000000b00514a90f10eamr567022ywd.316.1675326165483; Thu, 02
 Feb 2023 00:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20230202053113.2782-1-rdunlap@infradead.org> <980912a0-f5a0-4dea-9b5b-565d05bc4a6c@app.fastmail.com>
In-Reply-To: <980912a0-f5a0-4dea-9b5b-565d05bc4a6c@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Feb 2023 09:22:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPyTRh_E-jRET0zObm1+RYcPy0YrnVr-+ozEO84F0DWw@mail.gmail.com>
Message-ID: <CAMuHMdWPyTRh_E-jRET0zObm1+RYcPy0YrnVr-+ozEO84F0DWw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: implicit access_ok() needs an #include
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Arnd,

On Thu, Feb 2, 2023 at 8:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Feb 2, 2023, at 06:31, Randy Dunlap wrote:
> > Building arch/sh/ has a build error/warning that is fixed by
> > adding an #include of a header file.
> >
> > ../arch/sh/include/asm/checksum_32.h: In function
> > 'csum_and_copy_from_user':
> > ../arch/sh/include/asm/checksum_32.h:53:14: error: implicit declaration
> > of function 'access_ok' [-Werror=implicit-function-declaration]
> >    53 |         if (!access_ok(src, len))
> >       |              ^~~~~~~~~
> >
> > Fixes: 7fe8970a78a1 ("sh32: convert to csum_and_copy_from_user()")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: linux-sh@vger.kernel.org
> > Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > v2: add Subject: and patch description
>
> Thanks for the fix!
>
> >
> >  arch/sh/include/asm/checksum_32.h |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff -- a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
> > --- a/arch/sh/include/asm/checksum_32.h
> > +++ b/arch/sh/include/asm/checksum_32.h
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include <linux/in6.h>
> > +#include <asm-generic/access_ok.h>
>
> This will work correctly, but it is not the intended usage of the
> header. Anything in asm-generic/*.h should only be included by
> a particular header, usually the asm/*.h with the same name or in this
> case the asm/uaccess.h header.
>
> I think the correct fix here is to include asm/uaccess.h instead
> of asm-generic/access_ok.h.

Which should already be there, or RSN:
https://lore.kernel.org/all/167514181688.11863.771497291150527329.git-patchwork-notify@kernel.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
