Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D779C433F5
	for <linux-sh@archiver.kernel.org>; Wed, 15 Dec 2021 07:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhLOH4j (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 15 Dec 2021 02:56:39 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:46661 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhLOH4i (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 15 Dec 2021 02:56:38 -0500
Received: by mail-vk1-f170.google.com with SMTP id m16so13914849vkl.13;
        Tue, 14 Dec 2021 23:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVQUCRhJvXZRgFxiFcRA88PjQcq5cJWHq/xScnHpVHY=;
        b=IZGG+PnMRlTqJF7GecR8Uh/rl7XNBFlHffiseJ7yBNtC3HrYlYhbh7ToeRh08Z/ANX
         1m5UnPDRAn86dwKWv/+ymH6wH4noG/u5SDa8R4HM2b/5bJKNWOuK3ynP+X0SANrP7RzN
         lAH4T6NVI28ksJeK7bjGazvA7LKAvWuKdjLHN/e3kfsbe5pB0Q6ZJi0R7jC5sP//OY9V
         gILzyoizMzVyhJGRcmUy3CHyqHuP/RC54utl12EwwVzLyw0OZ9jrSjWFwqgErHUm2N/k
         0M5SBfMYGwQsvIcspsfiOrWDg2uJWVdQ3P6Jv6l0bxqh+k115AZbeKpnUOtcFfgc+NcM
         ul1w==
X-Gm-Message-State: AOAM532e0BTt/zzaw/KTLIsGrk0gWEkfkw40ORmYHJImOF5mQi25lGey
        AXa6OEdMpOvjcDFMi/3gZh/hU/Gub6Q3BQ==
X-Google-Smtp-Source: ABdhPJyWEhXr8Jesb4/lV+pb/9e8JvFOfpssrLSQTkCyHQAqzoGFPTXNvsmFxqS7x5u1/T1kntFYsg==
X-Received: by 2002:a05:6122:c9b:: with SMTP id ba27mr2651173vkb.14.1639554997600;
        Tue, 14 Dec 2021 23:56:37 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id x21sm305800ual.11.2021.12.14.23.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 23:56:37 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id 30so39428660uag.13;
        Tue, 14 Dec 2021 23:56:36 -0800 (PST)
X-Received: by 2002:a9f:248b:: with SMTP id 11mr8960109uar.14.1639554996714;
 Tue, 14 Dec 2021 23:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com> <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com> <CAMuHMdXA73EuFC6e-pEz1Ovc9ySNk-mt-6O0L7KbO28PvqratA@mail.gmail.com>
 <YbjTuOhNxaPirK1L@fedora> <CAMuHMdUaLTbS_20t7jfPkkHqYV=9JNQf-XQ80UppZcrHGOoTfA@mail.gmail.com>
 <YbjuGhPTjuTCSu+m@fedora> <CAMuHMdW8Besfp3Pbj1tRJ4gKKUbR59pU1ACuUNnn4RXkgVo5Qw@mail.gmail.com>
 <YbkDfyTbI/M6gaOw@fedora>
In-Reply-To: <YbkDfyTbI/M6gaOw@fedora>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Dec 2021 08:56:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXBYaz6N0vkA+oP3Cf4iBiWs=bEn0Y9z=JHg3u3wmc1Rg@mail.gmail.com>
Message-ID: <CAMuHMdXBYaz6N0vkA+oP3Cf4iBiWs=bEn0Y9z=JHg3u3wmc1Rg@mail.gmail.com>
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

On Tue, Dec 14, 2021 at 9:50 PM Dennis Zhou <dennis@kernel.org> wrote:
> On Tue, Dec 14, 2021 at 09:12:06PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Dec 14, 2021 at 8:18 PM Dennis Zhou <dennis@kernel.org> wrote:
> > > On Tue, Dec 14, 2021 at 08:02:58PM +0100, Geert Uytterhoeven wrote:
> > > > On Tue, Dec 14, 2021 at 6:26 PM Dennis Zhou <dennis@kernel.org> wrote:
> > > > > On Tue, Dec 14, 2021 at 05:29:22PM +0100, Geert Uytterhoeven wrote:
> > > > > > On Wed, Dec 1, 2021 at 12:53 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > > > > > > On 11/30/21 5:41 PM, Dennis Zhou wrote:
> > > > > > > > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
> > > > > > > >> Currently, NOMMU pull km allocator via !SMP dependency because most of
> > > > > > > >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
> > > > > > > >>
> > > > > > > >> * may lead to broken build [1]
> > > > > > > >> * ...or not working runtime due to [2]
> > > > > > > >>
> > > > > > > >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
> > > > > > > >> use percpu allocator on UP too") so restore that.
> > > > > > > >>
> > > > > > > >> [1]
> > > > > > > >> For ARM SMP+NOMMU (R-class cores)
> > > > > > > >>
> > > > > > > >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
> > > > > > > >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
> > > > > > > >>
> > > > > > > >> [2]
> > > > > > > >> static inline
> > > > > > > >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> > > > > > > >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> > > > > > > >> {
> > > > > > > >>        return -EINVAL;
> > > > > > > >> }
> > > > > > > >>
> > > > > > > >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> >
> > > > > > > IIRC, RISC-V also have SMP+NOMMU, so adding them as well.
> > > > > >
> > > > > > I had seen the j-Core thread, but completely forgot about
> > > > > > Canaan K210 (RV64 SMP+NOMMU).
> > > > > >
> > > > > > This became commit 3583521aabac76e5 ("percpu: km: ensure it is used
> > > > > > with NOMMU (either UP or SMP)").  And now booting K210 prints:
> > > > > >
> > > > > >     percpu: wasting 10 pages per chunk
> > > > > >
> > > > > > a) Is this bad?
> > > > >
> > > > > It's not great.. Can you share the line on boot with the following
> > > > > prefix: pcpu-alloc [1].
> > > >
> > > > There are no such lines.
> > > > "make mm/percpu.i mm/percpu.s" and inspecting the generated files,
> > > > and vmlinux, proves the code is there. But apparently it's not called.
> > > >
> > > > So there may be no issue on my system?
> > >
> > > I might be missing something, but that can't be right. Percpu calls
> > > pcpu_dump_alloc_info() from pcpu_setup_first_chunk() which is called by
> > > both embed/page first chunk code.
> > >
> > > Ummm. That can't be right. Percpu call pcpu_dump_alloc_info() from
> > > pcpu_setup_first_chunk() which everyone should call. On my machine:
> > >
> > > $ dmesg | grep "pcpu-alloc"
> > > [    0.065118] pcpu-alloc: s184320 r8192 d28672 u262144 alloc=1*2097152
> >
> > Doh, it wasn't printed to the console, due to KERN_DEBUG. Dmesg
> > does have it:
> >
> > <7>[    0.000000] pcpu-alloc: s15520 r0 d29536 u45056 alloc=11*4096
> > <7>[    0.000000] pcpu-alloc: [0] 0 [0] 1
> >
>
> I see, so what's happening is we're allocating 11 pages * 2, and due to
> percpu-km we round up to a contiguous 32 pages for backing pages. This
> results in the warning of wasting 10 pages. Given the size of the static
> region, I'm not too worried for now. I can't imagine the config would
> use that much percpu memory.
>
> We can massage the discrepancy for-v5.17. Basically in percpu-km, we
> align to 4k even though our allocation gets rounded up to the next power
> of 2. I don't have a lot of bandwidth right now, but I might be able to
> think about it over the next few weeks.

Note that K210 has only 8 MiB of SRAM, so wasting 10 pages means
wasting 0.5% of RAM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
