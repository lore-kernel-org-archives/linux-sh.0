Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E5C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 14 Dec 2021 20:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhLNUMT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:12:19 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:40559 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhLNUMT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Dec 2021 15:12:19 -0500
Received: by mail-ua1-f46.google.com with SMTP id y5so36913370ual.7;
        Tue, 14 Dec 2021 12:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+mb+oH7+4rpXpD/Z6lXjKtCNpCU2szRv7YE142Zc5o=;
        b=F3uckS6zCDp0Mcus/gHatrG4GZPMPKirbX1clZTXjy8JAiXvP0gSBG+eJ0UBolNWZC
         IUouwnSsTZ5gcAiHfcVd1jba6duhi/GNwWJLyg75EKI4OiR1Wd/QT3Bddikjldd9mIPK
         0mtvleh4MHIqoDCWvSm4Ahwt0xthL7P6Za/wOu0T7f1yfbE9A2G6XFlu01weSGACMngq
         Cw6F/0vRpaTWo8DmT5wpOlU/TWM5NNDqKfwQjvO1aEMTU8EX8YBcwaHd6VpSFC1bjWpl
         j17gx9p2tnk6iHPrd3JapjvijfdzNOEMejw/KaXmiK3E18E5oMuO0mMEJqdeT3EXPQRd
         512Q==
X-Gm-Message-State: AOAM532pODwpLB/oSUTpZcZ7xxpeqqxYbENwd01vDhy6mSIWJ+VSoFnY
        UpKyms9/i6hnNjbTDwe9iPMR7ecVCAbDvw==
X-Google-Smtp-Source: ABdhPJxlxXBlxVoVotuuLlBSuWgdye8dyENPexIt1SRJ+NSZTLYG4DqqY92JoeioNscHzsfidBY+Mg==
X-Received: by 2002:a67:f912:: with SMTP id t18mr1376059vsq.6.1639512738578;
        Tue, 14 Dec 2021 12:12:18 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 23sm173526vkk.17.2021.12.14.12.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 12:12:18 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id y22so983451uap.2;
        Tue, 14 Dec 2021 12:12:18 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr1300775vst.5.1639512737845;
 Tue, 14 Dec 2021 12:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com> <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com> <CAMuHMdXA73EuFC6e-pEz1Ovc9ySNk-mt-6O0L7KbO28PvqratA@mail.gmail.com>
 <YbjTuOhNxaPirK1L@fedora> <CAMuHMdUaLTbS_20t7jfPkkHqYV=9JNQf-XQ80UppZcrHGOoTfA@mail.gmail.com>
 <YbjuGhPTjuTCSu+m@fedora>
In-Reply-To: <YbjuGhPTjuTCSu+m@fedora>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Dec 2021 21:12:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8Besfp3Pbj1tRJ4gKKUbR59pU1ACuUNnn4RXkgVo5Qw@mail.gmail.com>
Message-ID: <CAMuHMdW8Besfp3Pbj1tRJ4gKKUbR59pU1ACuUNnn4RXkgVo5Qw@mail.gmail.com>
Subject: Re: [PATCH] percpu: km: ensure it is used with NOMMU (either UP or SMP)
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arch-owner@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Dennis,

On Tue, Dec 14, 2021 at 8:18 PM Dennis Zhou <dennis@kernel.org> wrote:
> On Tue, Dec 14, 2021 at 08:02:58PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Dec 14, 2021 at 6:26 PM Dennis Zhou <dennis@kernel.org> wrote:
> > > On Tue, Dec 14, 2021 at 05:29:22PM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, Dec 1, 2021 at 12:53 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > > > > On 11/30/21 5:41 PM, Dennis Zhou wrote:
> > > > > > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
> > > > > >> Currently, NOMMU pull km allocator via !SMP dependency because most of
> > > > > >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
> > > > > >>
> > > > > >> * may lead to broken build [1]
> > > > > >> * ...or not working runtime due to [2]
> > > > > >>
> > > > > >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
> > > > > >> use percpu allocator on UP too") so restore that.
> > > > > >>
> > > > > >> [1]
> > > > > >> For ARM SMP+NOMMU (R-class cores)
> > > > > >>
> > > > > >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
> > > > > >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
> > > > > >>
> > > > > >> [2]
> > > > > >> static inline
> > > > > >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> > > > > >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> > > > > >> {
> > > > > >>        return -EINVAL;
> > > > > >> }
> > > > > >>
> > > > > >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

> > > > > IIRC, RISC-V also have SMP+NOMMU, so adding them as well.
> > > >
> > > > I had seen the j-Core thread, but completely forgot about
> > > > Canaan K210 (RV64 SMP+NOMMU).
> > > >
> > > > This became commit 3583521aabac76e5 ("percpu: km: ensure it is used
> > > > with NOMMU (either UP or SMP)").  And now booting K210 prints:
> > > >
> > > >     percpu: wasting 10 pages per chunk
> > > >
> > > > a) Is this bad?
> > >
> > > It's not great.. Can you share the line on boot with the following
> > > prefix: pcpu-alloc [1].
> >
> > There are no such lines.
> > "make mm/percpu.i mm/percpu.s" and inspecting the generated files,
> > and vmlinux, proves the code is there. But apparently it's not called.
> >
> > So there may be no issue on my system?
>
> I might be missing something, but that can't be right. Percpu calls
> pcpu_dump_alloc_info() from pcpu_setup_first_chunk() which is called by
> both embed/page first chunk code.
>
> Ummm. That can't be right. Percpu call pcpu_dump_alloc_info() from
> pcpu_setup_first_chunk() which everyone should call. On my machine:
>
> $ dmesg | grep "pcpu-alloc"
> [    0.065118] pcpu-alloc: s184320 r8192 d28672 u262144 alloc=1*2097152

Doh, it wasn't printed to the console, due to KERN_DEBUG. Dmesg
does have it:

<7>[    0.000000] pcpu-alloc: s15520 r0 d29536 u45056 alloc=11*4096
<7>[    0.000000] pcpu-alloc: [0] 0 [0] 1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
