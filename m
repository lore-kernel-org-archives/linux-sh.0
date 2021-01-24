Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D9C433DB
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D05E22AAA
	for <linux-sh@archiver.kernel.org>; Sun, 24 Jan 2021 16:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbhAXQjH (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 24 Jan 2021 11:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAXQjG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 24 Jan 2021 11:39:06 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68ADC061573
        for <linux-sh@vger.kernel.org>; Sun, 24 Jan 2021 08:38:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a8so14351987lfi.8
        for <linux-sh@vger.kernel.org>; Sun, 24 Jan 2021 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ctoEBI2i5qSDaC0iIxrYMHC9Wrr1yL3x5hVMup3Wrww=;
        b=N/AIU2Ydt/tF2+CD8gqiW4ydHgnSS4oFjogz+99Txd4Aoiu147DnskcYShDu8YL3zV
         mjiGiQhSwkClzl3vYYY4Dqg1MKlq26ptXPagoVxzJrTfw4z1Q5GPFGnwf0H85IcpEiiw
         5Ez6kEZUj7A6t56/EMIwcNwuUnZh7Zg5s7jpOOo44gSOl7d8+KyAO6GQzOzLArH+VYaN
         QJObFQ5w3xFD0kdPrYOCw+AEDWp2F1iCa44w0lLufEh06GmhcboK2ECqrykVoUIfvAVM
         6rpZcFiH2XqNnnFeZDEcdspc4Zz0XGN8CHZ2REJB/e6ITymf3oMtAui3CUDE2OkgssE5
         dEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ctoEBI2i5qSDaC0iIxrYMHC9Wrr1yL3x5hVMup3Wrww=;
        b=iArwHdNf/Lov0bZX3q63WSfbsvbyNqLjChRI7AlpewT4rYbHAn6J8dCYyTj/DLQ1yN
         5TWwKKwRBt4Dw6+S8cse91XthFiOE9WpWbpXHFjnysOYN2T5czK+jBaXrmZ/ANGLeaUl
         pUPbDCITuO71pakd9QlN9A+qDDWADeZQJKk8x9ei7guGcvuddOj/G2eZbIWizO9h2WC2
         2JO9IL7gKabg4KD9apqA5pTH3mhTYdo67BhbiEY+UE3SACqlnFtIjAgJ/d9yvcA1Manc
         JIDxBEVp2HdrYTO0VzXRJNRNu6BQRR4nfHTmLPpHhV6cHRAsVHXcD24PobWFo7yqIVTy
         KHTA==
X-Gm-Message-State: AOAM530u5lh7QaVDvikboPqr12idFa+Ds7ac6kNMmcxY3CnVoXhvj9Ss
        Y3ixVD7GYvbSYaKXsckHjO06rZUOS141f63p6jk=
X-Google-Smtp-Source: ABdhPJwEHmS60EtUWqb8xBHTeuIl3N2sLZflR/efUK2beZLSmUdnBoj2nZwBprNeJKtxA4JsIF8ki4cE46FSp44NAfE=
X-Received: by 2002:ac2:4d2b:: with SMTP id h11mr1480113lfk.218.1611506304378;
 Sun, 24 Jan 2021 08:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20210123165652.10884-1-geoffrey.legourrierec@gmail.com> <CAK8P3a30O6=0TeNJK1qq-k5gj-CXXaD=vvJqiHFSi8HVaurHzg@mail.gmail.com>
In-Reply-To: <CAK8P3a30O6=0TeNJK1qq-k5gj-CXXaD=vvJqiHFSi8HVaurHzg@mail.gmail.com>
From:   =?UTF-8?Q?Geoffrey_Le_Gourri=C3=A9rec?= 
        <geoffrey.legourrierec@gmail.com>
Date:   Sun, 24 Jan 2021 17:38:12 +0100
Message-ID: <CADFgU5DoO79Py0bN9SWsVCF=kH1ntySwRtGgeYa8FcS=QMVRJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use types.h and not time_types.h in sockios.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

> On Sat, Jan 23, 2021 at 5:56 PM Geoffrey Le Gourri=C3=A9rec
> <geoffrey.legourrierec@gmail.com> wrote:
> >
> > I did a quick header dependency analysis starting from __kernel_time64_=
t
> > (one of the offending types), but could "follow up" to linux/time_types=
.h
> > as expected; so I fail to understand how this could break. What's even
> > more confusing is linux/time_types.h includes linux/types.h itself.
>
> Could you try producing a preprocessed version of the source file using '=
gcc -E'
> instead of 'gcc -c', using the same arguments as in the failing command?
>
> The output of that should help pinpoint what is going wrong.

Hi Arnd,

Here is the preprocessed
uclibc-1.0.37/libpthread/nptl/sysdeps/unix/sysv/linux/lowlevelrobustlock.h
:
https://pastebin.com/ypWCZK83

Considering the following dependency chain:
include/uapi/asm-generic/posix_types.h (__kernel_time64_t and
__kernel_old_time_t defined here)
  -- included by: include/uapi/asm/posix_types_32.h (within #ifndef
__ASM_SH_POSIX_TYPES_32_H)

...It looks like we do not enter the __ASM_SH_POSIX_TYPES_32_H include guar=
d.
Searching for that in the uclibc source code, I fall upon this header:
https://repo.or.cz/uclibc-ng.git/blob/ab1dd83bec59c9e65c31efd6e887182948f62=
7be:/libc/sysdeps/linux/sh/bits/kernel_types.h
...with a preliminary comment that seems quite explicit (I am not
familiar at all with the
subject, sorry if I'm perhaps stating the obvious):

/* Note that we use the exact same include guard #define names
* as asm/posix_types.h. This will avoid gratuitous conflicts
* with the posix_types.h kernel header, and will ensure that
* our private content, and not the kernel header, will win.
* -Erik
*/
#if !defined __ASM_SH_POSIX_TYPES_H && !defined __ASM_SH_POSIX_TYPES_32_H
#define __ASM_SH_POSIX_TYPES_H
#define __ASM_SH_POSIX_TYPES_32_H

> I'm fairly sure the patch you sent gets you back to the original problem:
> Since it avoids including linux/time_types.h, the compiler no longer
> sees the line that fails to build, but at the same time you can not
> actually use the SIOCGSTAMP_OLD and SIOCGSTAMPNS_OLD
> constants any more, as the structures will be undefined.

That is correct, my patch just fixes the symptom. I plan to come back
to the Buildroot
folks with a proper patch once we've figured something out.

Thanks for your review,

--=20
Geoffrey


Le dim. 24 janv. 2021 =C3=A0 11:56, Arnd Bergmann <arnd@kernel.org> a =C3=
=A9crit :
>
> On Sat, Jan 23, 2021 at 5:56 PM Geoffrey Le Gourri=C3=A9rec
> <geoffrey.legourrierec@gmail.com> wrote:
> >
> > I did a quick header dependency analysis starting from __kernel_time64_=
t
> > (one of the offending types), but could "follow up" to linux/time_types=
.h
> > as expected; so I fail to understand how this could break. What's even
> > more confusing is linux/time_types.h includes linux/types.h itself.
>
> Could you try producing a preprocessed version of the source file using '=
gcc -E'
> instead of 'gcc -c', using the same arguments as in the failing command?
>
> The output of that should help pinpoint what is going wrong.
>
> I'm fairly sure the patch you sent gets you back to the original problem:
> Since it avoids including linux/time_types.h, the compiler no longer
> sees the line that fails to build, but at the same time you can not
> actually use the SIOCGSTAMP_OLD and SIOCGSTAMPNS_OLD
> constants any more, as the structures will be undefined.
>
>       Arnd
