Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CDC433EF
	for <linux-sh@archiver.kernel.org>; Tue, 14 Dec 2021 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhLNTDN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Dec 2021 14:03:13 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:43711 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbhLNTDN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Dec 2021 14:03:13 -0500
Received: by mail-ua1-f42.google.com with SMTP id n9so17614184uaq.10;
        Tue, 14 Dec 2021 11:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQOtmTw19Qz+cRCih9T5sdKR1tGH5OnUCCIrsQi5CfA=;
        b=NuAXOm5coI6Pkb/bVcqoBR+9XC4/4bbKBTyJlbkfeGH3Rjv0XcRKRTZE58cO5Cl5wF
         4/2vxMoF6kU1APQExnIhDxGIInRs9F84ySZidBg1kz7ePR5SHnyGa57MxqxF6qnqEOZY
         mFIKY/AYU7wO9IIu6ogTXzGyL+7r6AiEr9xfqjT4uWN+CFus//OZgiKSLbvdOtP5+uI0
         +JRoFow8/wx9QMAQBNcgaxJ1VG1a05PmyoR/yEacgswyauQDhIFcZWAwbmH9hafVq/g5
         Wkfm3/1CoUFCnek7O0pUHDo0vcjg54zcJg8vQ8YGhKI/mIYeqAWa26vcNB5kqyxb1HbS
         6zWQ==
X-Gm-Message-State: AOAM533996lR67kTqbxRN4KJQLTqv/mHHdBrRftVLEzhTKxMbNwExMbu
        AJ47/C4i6bnJiGKkdWYrcIB8YzgaUBKvgA==
X-Google-Smtp-Source: ABdhPJxnQ+uL9ReXza0Fjdvynsu1WuOYcPDcBIJBwfW7GFcJN2nn679SGkIPq/8MxSI6KJWzFNHGuQ==
X-Received: by 2002:a67:fc91:: with SMTP id x17mr802609vsp.23.1639508591832;
        Tue, 14 Dec 2021 11:03:11 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id s25sm141924vsk.20.2021.12.14.11.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 11:03:10 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id 30so36575230uag.13;
        Tue, 14 Dec 2021 11:03:10 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr859450vsf.38.1639508590267;
 Tue, 14 Dec 2021 11:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com> <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com> <CAMuHMdXA73EuFC6e-pEz1Ovc9ySNk-mt-6O0L7KbO28PvqratA@mail.gmail.com>
 <YbjTuOhNxaPirK1L@fedora>
In-Reply-To: <YbjTuOhNxaPirK1L@fedora>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Dec 2021 20:02:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUaLTbS_20t7jfPkkHqYV=9JNQf-XQ80UppZcrHGOoTfA@mail.gmail.com>
Message-ID: <CAMuHMdUaLTbS_20t7jfPkkHqYV=9JNQf-XQ80UppZcrHGOoTfA@mail.gmail.com>
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

On Tue, Dec 14, 2021 at 6:26 PM Dennis Zhou <dennis@kernel.org> wrote:
> On Tue, Dec 14, 2021 at 05:29:22PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 1, 2021 at 12:53 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > > On 11/30/21 5:41 PM, Dennis Zhou wrote:
> > > > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
> > > >> Currently, NOMMU pull km allocator via !SMP dependency because most of
> > > >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
> > > >>
> > > >> * may lead to broken build [1]
> > > >> * ...or not working runtime due to [2]
> > > >>
> > > >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
> > > >> use percpu allocator on UP too") so restore that.
> > > >>
> > > >> [1]
> > > >> For ARM SMP+NOMMU (R-class cores)
> > > >>
> > > >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
> > > >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
> > > >>
> > > >> [2]
> > > >> static inline
> > > >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> > > >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> > > >> {
> > > >>        return -EINVAL;
> > > >> }
> > > >>
> > > >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > > >> ---
> > > >>  mm/Kconfig | 3 +--
> > > >>  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/mm/Kconfig b/mm/Kconfig
> > > >> index d16ba92..66331e0 100644
> > > >> --- a/mm/Kconfig
> > > >> +++ b/mm/Kconfig
> > > >> @@ -425,9 +425,8 @@ config THP_SWAP
> > > >>  # UP and nommu archs use km based percpu allocator
> > > >>  #
> > > >>  config NEED_PER_CPU_KM
> > > >> -    depends on !SMP
> > > >>      bool
> > > >> -    default y
> > > >> +    default !SMP || !MMU
> > > >>
> > > >
> > > > Should this be `depends on !SMP || !MMU` with default yes? Because with
> > > > SMP && MMU, it shouldn't be an option to run with percpu-km.
> > >
> > > IIUC these are equivalent, truth table would not change if is under "depends"
> > > or "default"
> > >
> > > SMP    MMU   NEED_PER_CPU_KM
> > >  y      y    !y || !y => n || n => n
> > >  y      n    !y || !n => n || y => y
> > >  n      y    !n || !y => y || n => y
> > >  n      n    !n || !n => y || y => y
> > >
> > > >
> > > >>  config CLEANCACHE
> > > >>      bool "Enable cleancache driver to cache clean pages if tmem is present"
> > > >> --
> > > >> 2.7.4
> > > >>
> > > >
> > > > It's interesting to me that this is all coming up at once. Earlier this
> > > > month I had the same conversation with people involved with sh [1].
> > > >
> > > > [1] https://lore.kernel.org/linux-sh/YY7tp5attRyK42Zk@fedora/
> > > >
> > > > I can pull this shortly once I see whatever happened to linux-sh.
> > >
> > > Ahh, good to know! Adding SH folks here (start of discussion [0]). I see you came
> > > to the same conclusion, right?
> > >
> > > IIRC, RISC-V also have SMP+NOMMU, so adding them as well.
> >
> > I had seen the j-Core thread, but completely forgot about
> > Canaan K210 (RV64 SMP+NOMMU).
> >
> > This became commit 3583521aabac76e5 ("percpu: km: ensure it is used
> > with NOMMU (either UP or SMP)").  And now booting K210 prints:
> >
> >     percpu: wasting 10 pages per chunk
> >
> > a) Is this bad?
>
> It's not great.. Can you share the line on boot with the following
> prefix: pcpu-alloc [1].

There are no such lines.
"make mm/percpu.i mm/percpu.s" and inspecting the generated files,
and vmlinux, proves the code is there. But apparently it's not called.

So there may be no issue on my system?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
