Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96420C433EF
	for <linux-sh@archiver.kernel.org>; Tue, 14 Dec 2021 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhLNUuM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Dec 2021 15:50:12 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:33574 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLNUuL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Dec 2021 15:50:11 -0500
Received: by mail-qk1-f174.google.com with SMTP id de30so18087849qkb.0;
        Tue, 14 Dec 2021 12:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sS8ThnAfgEIagUazFBk67DrTX4ixpcz5uSXW55pov0w=;
        b=Ac5oNkQAwgqX07UfRUl2Y7WXHO3jZVw0Qsrap+bb2elp076lj02Mk6Yxo6sTw1I+J0
         9NScLZCr6VJmSzeTlGcBrqEvMV9TSDED6btPBrGyPtg7Cl9NatNVZswiTPVloX1joBns
         3kN+d9ewQSkMir9KvcpFmYe1ah2aGwyA8/M6LEvmNvQmeOXxMsEySPXW95WK9l5hl6b6
         Guv3eBSckHeGlfRqsjD8xEGdPaDd/k/5UsNKFOkcUGOIEAfXcn3iEHPEis5fUDF9Vvts
         1G2dMX2XgYwBTxsTPsrDKOGwEe9zKxOyEm4K97Eolm3Ha7xV7Gl33ICsBx0r+Bq0/RnK
         avqw==
X-Gm-Message-State: AOAM531LO9mCEDhk3Ya4kEaLtDXLRO760G7Qf2Dy544jVZivur/G5XHU
        pfMctrXcalABoAE7ehXUjZo=
X-Google-Smtp-Source: ABdhPJwK4+ZFU7xss+xqFdXm1wARUT9REHRHqt3Km7rUsTKvt5KPRi6jXIyWGXhd+QLAvXrztvELNw==
X-Received: by 2002:a05:620a:4489:: with SMTP id x9mr6247018qkp.38.1639515009734;
        Tue, 14 Dec 2021 12:50:09 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id d5sm808059qte.27.2021.12.14.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:50:09 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:50:07 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arch-owner@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] percpu: km: ensure it is used with NOMMU (either UP or
 SMP)
Message-ID: <YbkDfyTbI/M6gaOw@fedora>
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com>
 <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com>
 <CAMuHMdXA73EuFC6e-pEz1Ovc9ySNk-mt-6O0L7KbO28PvqratA@mail.gmail.com>
 <YbjTuOhNxaPirK1L@fedora>
 <CAMuHMdUaLTbS_20t7jfPkkHqYV=9JNQf-XQ80UppZcrHGOoTfA@mail.gmail.com>
 <YbjuGhPTjuTCSu+m@fedora>
 <CAMuHMdW8Besfp3Pbj1tRJ4gKKUbR59pU1ACuUNnn4RXkgVo5Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8Besfp3Pbj1tRJ4gKKUbR59pU1ACuUNnn4RXkgVo5Qw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Dec 14, 2021 at 09:12:06PM +0100, Geert Uytterhoeven wrote:
> Hi Dennis,
> 
> On Tue, Dec 14, 2021 at 8:18 PM Dennis Zhou <dennis@kernel.org> wrote:
> > On Tue, Dec 14, 2021 at 08:02:58PM +0100, Geert Uytterhoeven wrote:
> > > On Tue, Dec 14, 2021 at 6:26 PM Dennis Zhou <dennis@kernel.org> wrote:
> > > > On Tue, Dec 14, 2021 at 05:29:22PM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, Dec 1, 2021 at 12:53 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > > > > > On 11/30/21 5:41 PM, Dennis Zhou wrote:
> > > > > > > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
> > > > > > >> Currently, NOMMU pull km allocator via !SMP dependency because most of
> > > > > > >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
> > > > > > >>
> > > > > > >> * may lead to broken build [1]
> > > > > > >> * ...or not working runtime due to [2]
> > > > > > >>
> > > > > > >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
> > > > > > >> use percpu allocator on UP too") so restore that.
> > > > > > >>
> > > > > > >> [1]
> > > > > > >> For ARM SMP+NOMMU (R-class cores)
> > > > > > >>
> > > > > > >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
> > > > > > >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
> > > > > > >>
> > > > > > >> [2]
> > > > > > >> static inline
> > > > > > >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> > > > > > >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> > > > > > >> {
> > > > > > >>        return -EINVAL;
> > > > > > >> }
> > > > > > >>
> > > > > > >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> > > > > > IIRC, RISC-V also have SMP+NOMMU, so adding them as well.
> > > > >
> > > > > I had seen the j-Core thread, but completely forgot about
> > > > > Canaan K210 (RV64 SMP+NOMMU).
> > > > >
> > > > > This became commit 3583521aabac76e5 ("percpu: km: ensure it is used
> > > > > with NOMMU (either UP or SMP)").  And now booting K210 prints:
> > > > >
> > > > >     percpu: wasting 10 pages per chunk
> > > > >
> > > > > a) Is this bad?
> > > >
> > > > It's not great.. Can you share the line on boot with the following
> > > > prefix: pcpu-alloc [1].
> > >
> > > There are no such lines.
> > > "make mm/percpu.i mm/percpu.s" and inspecting the generated files,
> > > and vmlinux, proves the code is there. But apparently it's not called.
> > >
> > > So there may be no issue on my system?
> >
> > I might be missing something, but that can't be right. Percpu calls
> > pcpu_dump_alloc_info() from pcpu_setup_first_chunk() which is called by
> > both embed/page first chunk code.
> >
> > Ummm. That can't be right. Percpu call pcpu_dump_alloc_info() from
> > pcpu_setup_first_chunk() which everyone should call. On my machine:
> >
> > $ dmesg | grep "pcpu-alloc"
> > [    0.065118] pcpu-alloc: s184320 r8192 d28672 u262144 alloc=1*2097152
> 
> Doh, it wasn't printed to the console, due to KERN_DEBUG. Dmesg
> does have it:
> 
> <7>[    0.000000] pcpu-alloc: s15520 r0 d29536 u45056 alloc=11*4096
> <7>[    0.000000] pcpu-alloc: [0] 0 [0] 1
> 

I see, so what's happening is we're allocating 11 pages * 2, and due to
percpu-km we round up to a contiguous 32 pages for backing pages. This
results in the warning of wasting 10 pages. Given the size of the static
region, I'm not too worried for now. I can't imagine the config would
use that much percpu memory.

We can massage the discrepancy for-v5.17. Basically in percpu-km, we
align to 4k even though our allocation gets rounded up to the next power
of 2. I don't have a lot of bandwidth right now, but I might be able to
think about it over the next few weeks.

Thanks,
Dennis
