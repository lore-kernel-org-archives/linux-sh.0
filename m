Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C702C433F5
	for <linux-sh@archiver.kernel.org>; Tue, 14 Dec 2021 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhLNR0V (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Dec 2021 12:26:21 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43974 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhLNR0U (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Dec 2021 12:26:20 -0500
Received: by mail-qt1-f172.google.com with SMTP id q14so19056579qtx.10;
        Tue, 14 Dec 2021 09:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=826lo/OFrJk222r+sN9o+DWKehRdrydX6E4AepnaF0s=;
        b=s2vYVa1WitpfH1Hc2SgiPTFgZb+7tXbDIXN3nEOj8Rf0NZqcT43F1DnzqxSqEqHJCt
         N5RnCXSs5Hsr6lDqOQmRLhxaI8ZAhPMUjEieI/gUaLwb+yD5pRh9hv9i2q3joNSe7bUV
         UluKuNe3fzDgijIc10Olb1bbEf58v/7gJF9DvaPlIhuv2GsfOD/E8H6aNVOPnz2oRWlv
         bYPbFO7qsYeL438JNym7ZDCUemBjJacmxhk/H7mps5KllyBnU4ahgNIRKqpWemowsS7a
         U1EIwLxNMbz80ugAwSKx605rPfWO2j+xyepm3Ahxn+nQlqIaU3FZnODu6wH6qoxb5Eo/
         amdA==
X-Gm-Message-State: AOAM533P17yASiHRsAwu1Wo9RzcycwXcrYar+e1rTdyxUrTWLTFrmlTz
        sYR1Ithl2mWfzfuRcj63iCI=
X-Google-Smtp-Source: ABdhPJzssn55vxdoSsLT8NneKqIz7PCLs3RZ2yix4ovt3oIj6BFwXJ6bRiipof1/EM41W7TkUADNNQ==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr7408245qta.437.1639502778434;
        Tue, 14 Dec 2021 09:26:18 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id a16sm367167qta.94.2021.12.14.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:26:17 -0800 (PST)
Date:   Tue, 14 Dec 2021 12:26:16 -0500
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
Message-ID: <YbjTuOhNxaPirK1L@fedora>
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com>
 <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com>
 <CAMuHMdXA73EuFC6e-pEz1Ovc9ySNk-mt-6O0L7KbO28PvqratA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXA73EuFC6e-pEz1Ovc9ySNk-mt-6O0L7KbO28PvqratA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello,

On Tue, Dec 14, 2021 at 05:29:22PM +0100, Geert Uytterhoeven wrote:
> Hi Vladimir and Dennis,
> 
> On Wed, Dec 1, 2021 at 12:53 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> > On 11/30/21 5:41 PM, Dennis Zhou wrote:
> > > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
> > >> Currently, NOMMU pull km allocator via !SMP dependency because most of
> > >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
> > >>
> > >> * may lead to broken build [1]
> > >> * ...or not working runtime due to [2]
> > >>
> > >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
> > >> use percpu allocator on UP too") so restore that.
> > >>
> > >> [1]
> > >> For ARM SMP+NOMMU (R-class cores)
> > >>
> > >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
> > >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
> > >>
> > >> [2]
> > >> static inline
> > >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> > >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> > >> {
> > >>        return -EINVAL;
> > >> }
> > >>
> > >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > >> ---
> > >>  mm/Kconfig | 3 +--
> > >>  1 file changed, 1 insertion(+), 2 deletions(-)
> > >>
> > >> diff --git a/mm/Kconfig b/mm/Kconfig
> > >> index d16ba92..66331e0 100644
> > >> --- a/mm/Kconfig
> > >> +++ b/mm/Kconfig
> > >> @@ -425,9 +425,8 @@ config THP_SWAP
> > >>  # UP and nommu archs use km based percpu allocator
> > >>  #
> > >>  config NEED_PER_CPU_KM
> > >> -    depends on !SMP
> > >>      bool
> > >> -    default y
> > >> +    default !SMP || !MMU
> > >>
> > >
> > > Should this be `depends on !SMP || !MMU` with default yes? Because with
> > > SMP && MMU, it shouldn't be an option to run with percpu-km.
> >
> > IIUC these are equivalent, truth table would not change if is under "depends"
> > or "default"
> >
> > SMP    MMU   NEED_PER_CPU_KM
> >  y      y    !y || !y => n || n => n
> >  y      n    !y || !n => n || y => y
> >  n      y    !n || !y => y || n => y
> >  n      n    !n || !n => y || y => y
> >
> > >
> > >>  config CLEANCACHE
> > >>      bool "Enable cleancache driver to cache clean pages if tmem is present"
> > >> --
> > >> 2.7.4
> > >>
> > >
> > > It's interesting to me that this is all coming up at once. Earlier this
> > > month I had the same conversation with people involved with sh [1].
> > >
> > > [1] https://lore.kernel.org/linux-sh/YY7tp5attRyK42Zk@fedora/
> > >
> > > I can pull this shortly once I see whatever happened to linux-sh.
> >
> > Ahh, good to know! Adding SH folks here (start of discussion [0]). I see you came
> > to the same conclusion, right?
> >
> > IIRC, RISC-V also have SMP+NOMMU, so adding them as well.
> 
> I had seen the j-Core thread, but completely forgot about
> Canaan K210 (RV64 SMP+NOMMU).
> 
> This became commit 3583521aabac76e5 ("percpu: km: ensure it is used
> with NOMMU (either UP or SMP)").  And now booting K210 prints:
> 
>     percpu: wasting 10 pages per chunk
> 
> a) Is this bad?

It's not great.. Can you share the line on boot with the following
prefix: pcpu-alloc [1].

I'm a little surprised here because this means it's allocating not
against the right atomic size. I don't necesarily think it's an issue of
switching from percpu-vm to percpu-km.

> b) What exactly was this fixing, and how would I trigger the bad case
>    on K210 before, if it was affected at all?
> 

In v5.14, I merged Roman's request for percpu depopulation [2]. This
required calls to flush the tlb. There is an abstraction layer:
percpu-vm vs percpu-km. So if an architecture is using percpu-vm but
doesn't have an MMU AND doesn't map out appropriately the tlb flush
call, then it fails. This happened on arm + sh architectures. Now RV
might be mapping it out appropriately so they never saw the issue.

Now, there is also a bigger caveat with using percpu-vm without an MMU.
In percpu-vm, we allocate pages on demand and map them in into
pre-allocated vmas. This means there are 2 scenarios that I haven't
looked into deeper. 1, the vma alloc maps to allocating physical pages.
2, we're lucky percpu allocates backwards in the vma so we haven't had a
collision problem yet.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/tree/mm/percpu.c#n2507
[2] https://lore.kernel.org/lkml/20210419225047.3415425-1-dennis@kernel.org/

Thanks,
Dennis

> >
> > [0] https://lore.kernel.org/linux-mm/20211130172954.129587-1-vladimir.murzin@arm.com/T/
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
