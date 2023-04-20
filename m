Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F60C77B73
	for <linux-sh@archiver.kernel.org>; Thu, 20 Apr 2023 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDTHQZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDTHQX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 20 Apr 2023 03:16:23 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBBA2D64
        for <linux-sh@vger.kernel.org>; Thu, 20 Apr 2023 00:16:22 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-54fb615ac3dso29821967b3.2
        for <linux-sh@vger.kernel.org>; Thu, 20 Apr 2023 00:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974982; x=1684566982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UTJW3bj/HzkvbzkVb4xYalheH8Kcmmdf0/uZwOX4jY=;
        b=QEGBXPZF/wQJsI7i3Rqp6cYo+t1S8IQp20Pza6azMy1fmXuL4BmIL4FZgI8VntxrG+
         5SXs4JnnYXT6QOad7KQNKcfIZ0Efwoployp3d7beRyNmtXXQA4TBYfIUMRieZ79dcEBG
         tcf7lnevhpF7Lq5Dql8zg6nxDRHj3W6eUobyt9dRS52+c9VEgVienJkXIKbZJ/zM0KEf
         +qHL+rmXkj0u2Mvr5uWLM46aotN41BTuiI/XgzsDtTdUKx1Ff5ZOjuR8RgiKfcQ/uPuL
         LKC4n+4wgimQb1jI0ePv1/yxtmKinXO3Vqk0bJbDfY9rV26BOfIvRXUG+sUfvk+xrQgC
         A/3A==
X-Gm-Message-State: AAQBX9csKHir0ybjcV1/dkxH41i94ia544QpYT1H3vub4BGjAPCpmdyk
        W0w0k0KtIpRdJjgbE6ZIdHnfjOiTTtUXrw==
X-Google-Smtp-Source: AKy350YCEJY7c3PNENBnKsHpcpeGl/+HuLEbiVHF6HjrQlpUoMFCOI70lfTZ+2P0FZf+yjRu22Zm4Q==
X-Received: by 2002:a81:8394:0:b0:54d:61e0:c821 with SMTP id t142-20020a818394000000b0054d61e0c821mr128670ywf.24.1681974981684;
        Thu, 20 Apr 2023 00:16:21 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id z128-20020a818986000000b005460251b0d9sm186294ywf.82.2023.04.20.00.16.21
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 00:16:21 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-54f6a796bd0so28081497b3.12
        for <linux-sh@vger.kernel.org>; Thu, 20 Apr 2023 00:16:21 -0700 (PDT)
X-Received: by 2002:a81:6c57:0:b0:54f:6471:c913 with SMTP id
 h84-20020a816c57000000b0054f6471c913mr139198ywc.27.1681974981075; Thu, 20 Apr
 2023 00:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
 <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net> <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
 <f321805d-346b-36d5-247f-3c092aa7bea1@landley.net> <CAMuHMdXX7+-KF7eEoqY4NH90e9g=ykapfma7V050NaKW1Qb-vQ@mail.gmail.com>
 <33f74e06-6b62-3f13-ed09-8efb4f05ac5c@landley.net> <b6ba777419f0d94c5f39cfc4698e2dd4f7319e16.camel@physik.fu-berlin.de>
 <b42c6496ffb531459eb7995fd4b5e828f599b4fe.camel@physik.fu-berlin.de> <b2415afc-5df9-cd95-9dd5-b31a3f9db6fc@landley.net>
In-Reply-To: <b2415afc-5df9-cd95-9dd5-b31a3f9db6fc@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 09:16:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwYZMfjWNidampfj2M=EawUYOR2VdG=Wv5Die+E6KGpA@mail.gmail.com>
Message-ID: <CAMuHMdUwYZMfjWNidampfj2M=EawUYOR2VdG=Wv5Die+E6KGpA@mail.gmail.com>
Subject: Re: [PATCH] Fix J-core aic warning spam
To:     Rob Landley <rob@landley.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob,

On Thu, Apr 20, 2023 at 3:09 AM Rob Landley <rob@landley.net> wrote:
> On 4/19/23 05:25, John Paul Adrian Glaubitz wrote:
> > I just wanted to perform a test build of the J2 kernel, but I'm getting lots of error messages
> > from the assembler about unknown opcodes when trying to build j2_defconfig.
>
> J-core binary toolchain tarball:
>
> https://landley.net/toybox/downloads/binaries/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.xz
>
> Build script on top of Rich's musl-cross-make:
>
> https://landley.net/toybox/faq.html#cross2
>
> https://github.com/landley/toybox/blob/master/scripts/mcm-buildall.sh
>
> Fishing around in the for loop at the end of the script, the mcm-buildall.sh
> invocation for _just_ sh2eb would be:
>
>   ~/path/to/mcm-buildall.sh i686:: sh2eb:fdpic:--with-cpu=mj2
>
> Alas, this will build an i686 compiler (twice!) before building the sh2eb
> compiler, because the script makes portable toolchain tarballs which are
> statically linked on the host, and you can't do that with glibc because Ulrich
> Dr. Pepper was insane and his successors have been spineless, so it builds an
> i686 musl compiler first. (Could do x86_64, but didn't see a reason to make it
> less portable and use more memory? I should bench if it's noticeably faster...)

Good luck building Firefox with a 32-bit compiler ;-)

> The script builds an i686 host compiler internally (see
> BOOTSTRAP=i686-linux-musl near-ish the top), but gcc has this horrific two stage
> build thing it does where it builds and then rebuilds builds itself with itself,
> and that second i686 compiler would be the "builds with itself" one. (That's why
> it's at the start of the list in the for loop.) If you try to build anything
> ELSE with that compiler, autoconf winds up going "compiler can't create
> executables" because the stupid, it burns...
>
> Feel free to peel out simpler compiler toolchain builds if you've got a
> preference? The interesting bits for your purposes are probably:
>
> https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-9.4.0/0007-j2.diff
>
> https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.33.1/0001-j2.diff
>
> Jeff also has an sh2-elf toolchain build somewhere. That's more for bare metal,
> but I've confirmed it builds the kernel (as of 5.x somewhere anyway).

There's also [1], which is why it's good for Arnd to have the J-core
toolchain patches.

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
