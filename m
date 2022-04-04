Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1587C433F5
	for <linux-sh@archiver.kernel.org>; Mon,  4 Apr 2022 13:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349885AbiDDNO2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 4 Apr 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiDDNO0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 4 Apr 2022 09:14:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81E3BF91
        for <linux-sh@vger.kernel.org>; Mon,  4 Apr 2022 06:12:28 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MYvTs-1nWsLS2quW-00UrPF; Mon, 04 Apr 2022 15:07:22 +0200
Received: by mail-wr1-f41.google.com with SMTP id m30so14451164wrb.1;
        Mon, 04 Apr 2022 06:07:22 -0700 (PDT)
X-Gm-Message-State: AOAM530c+h48op2UHtrEOs0VSiSnb0bcPTTsU412fVGXz/sZO+rUotG2
        ZdNR7F0VUfMeUPzOgR43T6lpYLpXslI/47MAmvk=
X-Google-Smtp-Source: ABdhPJw/K8sYYGcKUcFc4yTdlw9+SOONHXxVgL1yKBMYbeG+8L+jnCtk7Gvh9Q0ehBPBsNK344bb2OH5nTaXtmbK2/w=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr17503109wrh.407.1649077642251; Mon, 04
 Apr 2022 06:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
In-Reply-To: <YkmWh2tss8nXKqc5@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 15:07:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
Message-ID: <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9BmX5wrEOGpmHMR2F3z2Bt76ujJUbajTL4OWilqNZyahkgTnsN5
 14FWdmHHezznXtIKj30YQnL5gC3iajJkT0ImRntZ1zrXMWolfqEb72+GyMls66tZlqV2Lbn
 1cKSFI9PpeFrzdepwtWOp4AeNRB3x+YHr1zbFS6aIkwogNnJU84nLjHAG9P0TapZC4VAcve
 C0d2Cm06UyXPfBpXDBvwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JdGcPWsaUBQ=:F6gYGnIvQUhn5XX8Dji3ua
 TrzBwpAewxATj44lpG3pd8VbJtc7IN45lmk3fSLeC2YdgxUYl98dJ9d9eYfsU+LGqxu8fKUVO
 4STvGviB8Z81fuu7Hzzc/MFOW4qCGX2Py6sXuEDxE0i+4d9mZxf3d3KnGXTb7KGrB4I+0rPLV
 QLReqs/oCWFBYR/jtyJmSKYJUWzGUIFZtBp5ade2Y+H1jQ0ob536UfjYIs/lCBMqmlTsAOzhL
 3I+Ne1lLwQtIkodAB+ajQby9tFm8uXvM/x3I5i1fPIvwmDckelsC6qntewPnzZ5y2fb5o0uzF
 7IesYSMjlNqLh7FkM/76z9Z0fAscHWrkkHXtZSi+trqj14iPz9WyoLrSn8v1cl8T9xJze4Jc2
 u5XsIx6s1EvzzD9W7u48sbUM36oTjKUfeO8Nj7oF/a8TQx+VW3K0DZmO4O72ExrdJ7hx/qf84
 6CVz+A0BPjo+UA88smM0GpBIu6zj88RKm2Fa3xh8j2ukX66A4voNiHuJbS1ZKKi01zPH0Lwks
 Lv52VUyKSWPJUebhTwevwExg4vL02riMmPTCowl0rmXZAjJH67LiG0ihEzF3lGq6Sn6ep4/7j
 SsDTLTg9d0r1bbm4yk9sAqCU520Z3GkbN5gcFOhRemWTmnncz+OhHUGGXjOpGVkErTYCYHw1x
 4lN1CAp/oJRPnc+EmKLUyoLkHAXbiKK6MfLWcA/H9UWJMR35NtQZUzO8gqKNQmq2Dg7AMOaNS
 hTLksbP22R9FjbOYe2DCuJe0I63NFsfSSeoknBoapZj+knXkb4TdOsujyFOgZ70P4pjEaHbSI
 Z/oalLKLfpOmVGmevzWZfxSA6JxazEhEqRvT4VDZ3Vluq5grbY=
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
> > If there are no other objections, I'll just queue this up for 5.18 in
> > the asm-generic
> > tree along with the nds32 removal.
>
> So it is the last day of te merge window and arch/h8300 is till there.
> And checking nw the removal has also not made it to linux-next.  Looks
> like it is so stale that even the removal gets ignored :(

I was really hoping that someone else would at least comment.
I've queued it up now for 5.19.

Should we garbage-collect some of the other nommu platforms where
we're here? Some of them are just as stale:

1. xtensa nommu has does not compile in mainline and as far as I can
tell never did
   (there was https://github.com/jcmvbkbc/linux-xtensa/tree/xtensa-5.6-esp32,
which
   worked at some point, but I don't think there was enough interest
to get in merged)

2. arch/sh Hitachi/Renesas sh2 (non-j2) support appears to be in a similar state
    to h8300, I don't think anyone would miss it

8<----- This may we where we want to draw the line ----

3. arch/sh j2 support was added in 2016 and doesn't see a lot of
changes, but I think
    Rich still cares about it and wants to add J32 support (with MMU)
in the future

4. m68k Dragonball, Coldfire v2 and Coldfire v3 are just as obsolete as SH2 as
   hardware is concerned, but Greg Ungerer keeps maintaining it, along with the
   newer Coldfire v4 (with MMU)

5. K210 was added in 2020. I assume you still want to keep it.

7. Arm32 has several Cortex-M based platforms that are mainly kept for
    legacy users (in particular stm32) or educational value.


       Arnd
