Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D191FC433F5
	for <linux-sh@archiver.kernel.org>; Fri,  3 Dec 2021 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbhLCVFb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:05:31 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:44918 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbhLCVFb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 3 Dec 2021 16:05:31 -0500
Received: by mail-qv1-f41.google.com with SMTP id i12so3956834qvh.11;
        Fri, 03 Dec 2021 13:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Qn8OGxN0mJ4XVtOk0dKCgNrTcXxTzqRnKO2MY3F8Sk=;
        b=RhBdj96i+MnI0Accp1tPkhcmy/caHVjXY4sZtGG/bLGYPg0AWHQzPuMUqeQJg9lzkH
         ADYqZR5DLMKEbKcP7X+XT5yiu2TPfj4fiSSh3yCRHOn1+APweJlnUCLTS8garIjKuUt4
         C0bV8sdP8HY41xXjw+m9nj3rB2d+Uiv8lws/JJXQhcI25KmjzwpaMIxPxq9Ws/ki0k0Z
         lSEEXECAwdZZozrg2N8nPhEUjVg2N0WcpOq/CUWCea+MFI5FbBWvpyKYF0bDU1Mh3il8
         4Hzij9jdLFcg0AILU9Ueqc+afPx9dN8kiS9ebTxQaUYEtjuPkcHYQQwaaoBTw9NHNa+Q
         Fl1g==
X-Gm-Message-State: AOAM531gbuLDU9q8jTsX8EEsud4q+WDE1+aKzxCI6SIfQGXWjEOOq4j9
        uJddF88/qjxula+p2WsQ2/I=
X-Google-Smtp-Source: ABdhPJwVSd9Ncb8R9IUZw28uewtm6Pr4Gucg24jRcXLaX+SLJpH7xPFJoA4D8MSy7KkJE2ZtK6aqJw==
X-Received: by 2002:a05:6214:27e9:: with SMTP id jt9mr21965622qvb.131.1638565326487;
        Fri, 03 Dec 2021 13:02:06 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id n20sm2988821qkp.65.2021.12.03.13.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:02:06 -0800 (PST)
Date:   Fri, 3 Dec 2021 16:02:03 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-arch-owner@vger.kernel.org,
        linux-mm@kvack.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, npiggin@gmail.com, hch@lst.de,
        arnd@arndb.de, linux-sh@vger.kernel.org, dalias@libc.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] percpu: km: ensure it is used with NOMMU (either UP or
 SMP)
Message-ID: <YaqFyznA5hab3PUA@fedora>
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com>
 <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Dec 01, 2021 at 11:51:04AM +0000, Vladimir Murzin wrote:
> Hi,
> 
> On 11/30/21 5:41 PM, Dennis Zhou wrote:
> > Hello,
> > 
> > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
> >> Currently, NOMMU pull km allocator via !SMP dependency because most of
> >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
> >>
> >> * may lead to broken build [1]
> >> * ...or not working runtime due to [2]
> >>
> >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
> >> use percpu allocator on UP too") so restore that.
> >>
> >> [1]
> >> For ARM SMP+NOMMU (R-class cores)
> >>
> >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
> >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
> >>
> >> [2]
> >> static inline
> >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> >> {
> >>        return -EINVAL;
> >> }
> >>
> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> >> ---
> >>  mm/Kconfig | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index d16ba92..66331e0 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -425,9 +425,8 @@ config THP_SWAP
> >>  # UP and nommu archs use km based percpu allocator
> >>  #
> >>  config NEED_PER_CPU_KM
> >> -	depends on !SMP
> >>  	bool
> >> -	default y
> >> +	default !SMP || !MMU
> >>  
> > 
> > Should this be `depends on !SMP || !MMU` with default yes? Because with
> > SMP && MMU, it shouldn't be an option to run with percpu-km.
> 
> IIUC these are equivalent, truth table would not change if is under "depends"
> or "default"
> 
> SMP    MMU   NEED_PER_CPU_KM
>  y      y    !y || !y => n || n => n
>  y      n    !y || !n => n || y => y
>  n      y    !n || !y => y || n => y
>  n      n    !n || !n => y || y => y
> 

I may be wrong, but I think this is slightly different as we're using
#ifdef / #if defined().

> > 
> >>  config CLEANCACHE
> >>  	bool "Enable cleancache driver to cache clean pages if tmem is present"
> >> -- 
> >> 2.7.4
> >>
> > 
> > It's interesting to me that this is all coming up at once. Earlier this
> > month I had the same conversation with people involved with sh [1].
> > 
> > [1] https://lore.kernel.org/linux-sh/YY7tp5attRyK42Zk@fedora/
> > 
> > I can pull this shortly once I see whatever happened to linux-sh.
> 
> Ahh, good to know! Adding SH folks here (start of discussion [0]). I see you came
> to the same conclusion, right? 
> 

Yeah, I don't see anything else from linux-sh. So I'll go ahead and
apply this with my change if you're fine with that.

> IIRC, RISC-V also have SMP+NOMMU, so adding them as well.
> 
> [0] https://lore.kernel.org/linux-mm/20211130172954.129587-1-vladimir.murzin@arm.com/T/
> 
> Cheers
> Vladimir
> 

Thanks,
Dennis
