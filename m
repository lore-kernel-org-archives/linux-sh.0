Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF65CCA479
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jul 2022 09:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiGAJmF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiGAJmE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jul 2022 05:42:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708005C9EE
        for <linux-sh@vger.kernel.org>; Fri,  1 Jul 2022 02:42:02 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p7so3076318ybm.7
        for <linux-sh@vger.kernel.org>; Fri, 01 Jul 2022 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7WkaE4UplPR9g6PXITQSoGxqocYmDuMj7V8IXNG4nHE=;
        b=o/icSX7EYaDr5CQtcNGx2zhumstPfDHcBFWg+on1+8CGEhnmQUB86cqAxXNMAFUUYP
         MkiPmIY82JD9hW60FTI9nyiZl/taPYZGVyMbgAX5mmoCiokjtSiB3EUiP6ncWaFXQasV
         f5DXC87Sp7HMHIM5Db5Bu0pIIb2wdZWrq5p9F2JccFYjppf3+lg5PSzjCgCHCV1PO4uf
         sfj1PId5y4l1HNhL+6rlz04kTFQtat0PnjxGgfqZ9jjwJmS1TGXuosAb3QWfuctC4off
         p+975vNhN2+WZkNwfZFN1n9dHsM7dklac1kBCIRt6DBgI6A0PzWOyP7XHUlkntzsDamH
         sSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7WkaE4UplPR9g6PXITQSoGxqocYmDuMj7V8IXNG4nHE=;
        b=Uzp2R9cn3zLSpvWpYjEpF2irnyZ7OLyHp46Emr71GRjflvKokK/4r9piNS9JGshRZK
         jzCLu9ydZS0pRr6rZEHcoi+at8K0pdQiuD4yj1nJ2nrF/ZZjePPSj4MVpxI6Y6tEUUQD
         KHPuNwHiVmatWtC5CGLP+2V9TCyxy5BNCOITL/fqqZrq1pDKu4Ikt3lZ0ANyEgp9FcCG
         uj8PYc9RzLAdxKT89b++AputcyaLgdZhPWp3GYQvXROzkhA0FU2CiWcWzQ7gsz1Nqsh3
         AbCz3e4rKxYLtXuC5Cd40kC/wwkhw1iaXfrE1dvdvsWbE875KBQ+mLY21iBpm3Ur9HkI
         LApg==
X-Gm-Message-State: AJIora/Qobr3flDdhhIT50VWK19uDC/6l+UsIRPZe2zn5diZ9u5ST2cJ
        RFfLSdBkJxuQc2gyFaVrnFlj2SkrbbfjfS8DkE36Vw==
X-Google-Smtp-Source: AGRyM1vGyRnUQaQ2a9Cl91wMlrhSEkd/ZeG5HlS8zoLj0GJa+tXHl0U3awLZiSPBVgIXdFQYboQuB7lYervCr/HAOs0=
X-Received: by 2002:a25:94a:0:b0:668:df94:fdf4 with SMTP id
 u10-20020a25094a000000b00668df94fdf4mr13606867ybm.425.1656668521567; Fri, 01
 Jul 2022 02:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-9-elver@google.com>
 <045a825c-cd7d-5878-d655-3d55fffb9ac2@csgroup.eu>
In-Reply-To: <045a825c-cd7d-5878-d655-3d55fffb9ac2@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Fri, 1 Jul 2022 11:41:25 +0200
Message-ID: <CANpmjNOeyZ0MZ_esOnR7TUE1R5Vf+_Ejt5JRQ1AoAmhkCrVrBA@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] powerpc/hw_breakpoint: Avoid relying on caller synchronization
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, 1 Jul 2022 at 10:54, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi Marco,
>
> Le 28/06/2022 =C3=A0 11:58, Marco Elver a =C3=A9crit :
> > Internal data structures (cpu_bps, task_bps) of powerpc's hw_breakpoint
> > implementation have relied on nr_bp_mutex serializing access to them.
> >
> > Before overhauling synchronization of kernel/events/hw_breakpoint.c,
> > introduce 2 spinlocks to synchronize cpu_bps and task_bps respectively,
> > thus avoiding reliance on callers synchronizing powerpc's hw_breakpoint=
.
>
> We have an still opened old issue in our database related to
> hw_breakpoint, I was wondering if it could have any link with the
> changes you are doing and whether you could handle it at the same time.
>
> https://github.com/linuxppc/issues/issues/38
>
> Maybe it is completely unrelated, but as your series modifies only
> powerpc and as the issue says that powerpc is the only one to do that, I
> thought it might be worth a hand up.

I see the powerpc issue unrelated to the optimizations in this series;
perhaps by fixing the powerpc issue, it would also become more
optimal. But all I saw is that it just so happens that powerpc relied
on the nr_bp_mutex which is going away.

This series will become even more complex if I decided to add a
powerpc rework on top (notwithstanding the fact I don't have any ppc
hardware at my disposal either). A separate series/patch seems much
more appropriate.

Thanks,
-- Marco
