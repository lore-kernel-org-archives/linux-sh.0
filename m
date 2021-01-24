Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90125C433E0
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5988621D79
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 18:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbhAXS6K (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 24 Jan 2021 13:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbhAXS6B (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Sun, 24 Jan 2021 13:58:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC81B22ADC
        for <linux-sh@vger.kernel.org>; Sun, 24 Jan 2021 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611514641;
        bh=JgF2iHZtIE+/1HdY0QYdlAtDj4UX8QmSDTTumHK+9DI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dlFu7KHZ28uwkTGcdnACm2jEZ9X1KsOUtybWxvzDQSS1GeIsgiI9iOSikoLW6q7/C
         aea227hT2u3D8zPI4A+M3tMhYAQFlZsLYmLKmgHKzIndEviAg7Tn2rO+/tQnvJxUlU
         MpSP03Ow6/aLsqM3+KZq0AEZQgwtzz44GPI7GsJ9dxiKJ22H5jqsampa4ZtgAx9yy/
         /PWkM2f2zgD1Jx5CIS1Zz0RoYQXSF/tTtJBbLcwjOaK/jyDU2TY53nw+9lT87bbNgO
         +FTMzPUVezR8y66LP2nXZncLGvknLjoaKUxKxsPE5GNm1DfewagJ6Hlpfs52dmuZay
         +n5Cc7uh5daeA==
Received: by mail-ot1-f53.google.com with SMTP id k8so10633696otr.8
        for <linux-sh@vger.kernel.org>; Sun, 24 Jan 2021 10:57:20 -0800 (PST)
X-Gm-Message-State: AOAM533Zdd6zR6abR/1oDkba2OxRNSbYFkYbfy6ZWvxfB+GgrKo3pp2u
        2+H+RLMViTWCj+1GcWW85Z/HHyfsBd9bhohPdIM=
X-Google-Smtp-Source: ABdhPJwI/nJpR4IhTMKGMoFV0V5/aNCTlJOTV+otbUEwO7aSxTkelKTL7l1w9pNsoF5VDF2ZQwZkLYxgTZRwI9BhojU=
X-Received: by 2002:a9d:3bb7:: with SMTP id k52mr169502otc.251.1611514640283;
 Sun, 24 Jan 2021 10:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20210123165652.10884-1-geoffrey.legourrierec@gmail.com>
 <CAK8P3a30O6=0TeNJK1qq-k5gj-CXXaD=vvJqiHFSi8HVaurHzg@mail.gmail.com> <CADFgU5DoO79Py0bN9SWsVCF=kH1ntySwRtGgeYa8FcS=QMVRJg@mail.gmail.com>
In-Reply-To: <CADFgU5DoO79Py0bN9SWsVCF=kH1ntySwRtGgeYa8FcS=QMVRJg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 24 Jan 2021 19:57:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2A6M_srCHzw6rOH3uPDYvQJuUdNujFf8NnumNO4WqnOA@mail.gmail.com>
Message-ID: <CAK8P3a2A6M_srCHzw6rOH3uPDYvQJuUdNujFf8NnumNO4WqnOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use types.h and not time_types.h in sockios.h
To:     =?UTF-8?Q?Geoffrey_Le_Gourri=C3=A9rec?= 
        <geoffrey.legourrierec@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, Jan 24, 2021 at 5:38 PM Geoffrey Le Gourri=C3=A9rec
<geoffrey.legourrierec@gmail.com> wrote:
> > On Sat, Jan 23, 2021 at 5:56 PM Geoffrey Le Gourri=C3=A9rec <geoffrey.l=
egourrierec@gmail.com> wrote:

> ...It looks like we do not enter the __ASM_SH_POSIX_TYPES_32_H include gu=
ard.
> Searching for that in the uclibc source code, I fall upon this header:
> https://repo.or.cz/uclibc-ng.git/blob/ab1dd83bec59c9e65c31efd6e887182948f=
627be:/libc/sysdeps/linux/sh/bits/kernel_types.h
> ...with a preliminary comment that seems quite explicit (I am not
> familiar at all with the
> subject, sorry if I'm perhaps stating the obvious):
>
> /* Note that we use the exact same include guard #define names
> * as asm/posix_types.h. This will avoid gratuitous conflicts
> * with the posix_types.h kernel header, and will ensure that
> * our private content, and not the kernel header, will win.
> * -Erik
> */
> #if !defined __ASM_SH_POSIX_TYPES_H && !defined __ASM_SH_POSIX_TYPES_32_H
> #define __ASM_SH_POSIX_TYPES_H
> #define __ASM_SH_POSIX_TYPES_32_H

Ok, so I guess this means that it's just a bug in uclibc. Most likely this =
code
dates back a very long time, back when the asm/posix_types.h in the
kernel was in fact defining the same types as user space. Since it now
only contains the __kernel_* prefixed types, you can probably just
remove this hack. If that doesn't work, then uclibc needs to be changed to
define the same types as the kernel header.

        Arnd
