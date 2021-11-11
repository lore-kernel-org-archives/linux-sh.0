Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA7C433EF
	for <linux-sh@archiver.kernel.org>; Thu, 11 Nov 2021 02:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0D3611AD
	for <linux-sh@archiver.kernel.org>; Thu, 11 Nov 2021 02:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhKKCEC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 10 Nov 2021 21:04:02 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:44630 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhKKCEC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 10 Nov 2021 21:04:02 -0500
Received: by mail-qk1-f169.google.com with SMTP id 132so4388927qkj.11
        for <linux-sh@vger.kernel.org>; Wed, 10 Nov 2021 18:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1rPig1UqMkwM9P7mlGjyTx29oVMWgyy35AI//wbRtWQ=;
        b=tuoBHynllig8g/6+L2fMGhav1hq550BLi/yVuVADB2GIwSADPQzsc5tnBIM8/EjgdA
         uxT4nJVgAMEU81DUH++xh+qOxl285EF634bi/gFy+hpl7XQazvqUtqkBbERmYq6CzofJ
         7tjkaBANaomKmeK7xKk8Oj4uDi8PmMrztI9OQpxoDqYInCwkLUj00xpubZEHNILmr2Su
         nyOsH6HRZYnSU7KdF16SyDeIulN1yLbsJ8+tPqI34elRKjeeHMHfLeWx0Yxokx7j6o5w
         8a1YL0ve0oAyWtvWEQpBo8J/mjh0P5SQ5eAMGqC0XWbELgNWQ8Sd1CTJGAGUviSZvhmD
         Ei9A==
X-Gm-Message-State: AOAM53353wcghseGme42pUcGu6+c7/ba9OofklFFRwFBmodpGBvF6dmj
        w9yLqtm3PKtawpw0tfw453o=
X-Google-Smtp-Source: ABdhPJwOMw8ozr7dRlg32Fdj2l8kJJ7Oqv9TGaoaY6htx28oQHc8me3NmltneeUqxS1ZAPvToOsIqw==
X-Received: by 2002:a05:620a:2790:: with SMTP id g16mr3176201qkp.403.1636596073440;
        Wed, 10 Nov 2021 18:01:13 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id v7sm760928qki.98.2021.11.10.18.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 18:01:12 -0800 (PST)
Date:   Wed, 10 Nov 2021 21:01:10 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Rob Landley <rob@landley.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Fix the j-core SOC build.
Message-ID: <YYx5ZuWFSNOu/wah@fedora>
References: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
 <20211003021851.GA2559@brightrain.aerifal.cx>
 <20211110213345.GK7074@brightrain.aerifal.cx>
 <20211111005312.GM7074@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111005312.GM7074@brightrain.aerifal.cx>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello,

On Wed, Nov 10, 2021 at 07:53:13PM -0500, Rich Felker wrote:
> On Wed, Nov 10, 2021 at 04:33:46PM -0500, Rich Felker wrote:
> > On Sat, Oct 02, 2021 at 10:18:51PM -0400, Rich Felker wrote:
> > > On Sat, Oct 02, 2021 at 02:32:15PM -0500, Rob Landley wrote:
> > > > From: Rob Landley <rob@landley.net>
> > > > 
> > > > Commit b67177ecd956 broke the j-core SOC build with a link failure, because
> > > > mm/percpu.c function pcpu_post_unmap_tlb_flush() calls flush_tlb_kernel_range()
> > > > which is defined under #ifdef CONFIG_MMU.
> > > > 
> > > > Signed-off-by: Rob Landley <rob@landley.net>
> > > > ---
> > > > 
> > > >  arch/sh/kernel/smp.c |    5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
> > > > index 65924d9ec245..3ec8f32aad85 100644
> > > > --- a/arch/sh/kernel/smp.c
> > > > +++ b/arch/sh/kernel/smp.c
> > > > @@ -468,4 +468,9 @@ void flush_tlb_one(unsigned long asid, unsigned long vaddr)
> > > >  	local_flush_tlb_one(asid, vaddr);
> > > >  }
> > > > 
> > > > +#else
> > > > +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > > > +{
> > > > +	local_flush_tlb_all();
> > > > +}
> > > >  #endif
> > > 
> > > local_flush_tlb_all() is defined in arch/sh/mm/nommu.c as BUG(); so
> > > this is most likely wrong unless it just doesn't get called. I think
> > > there should probably be something at a very general level dummying
> > > out these functions/macros on nommu but I don't know where it should
> > > be.
> > 
> > I've looked into this some more, and while arch/arm does dummy its
> > equivalent functions out on nommu, arch/sh has always had them as
> > BUG(), and indeed it makes some sense to catch erroneous usage.
> > pcpu_post_unmap_tlb_flush should probably have the flush under #ifdef
> > CONFIG_MMU or something.
> > 
> > I've added the author of the commit that broke this to Cc in case he
> > has any thoughts.
> 
> I think we actually have the wrong commit to blame; it looks like
> 93274f1dd6b0 ("percpu: flush tlb in pcpu_reclaim_populated()") added
> the TLB flush. However, this rabbit hole seems to go a lot deeper.
> According to the comments in the files, percpu-km.c, not percpu-vm.c,
> is supposed to be used on nommu archs. However, mm/Kconfig has
> NEED_PER_CPU_KM depending on !SMP rather than !SMP || !MMU, which
> mismatches the comments in the source. So should we be trying to fix
> the Kconfig constraints to use -km? Or fixing -vm to work on nommu
> like it used to?
> 
> Rich

I'm surprised I haven't heard any reports of this until now. Thanks for
ccing me. Fwiw, it's generally good to cc the author / subsystem
maintainer when there is an issue.

I would need to think about it a little bit more, but I think
percpu-km.c was written more in the mindset of !MMU == !SMP. It sounds
like for superh that's not true.

Given that, if sh has no MMU, then it really should be using percpu-km.c
not percpu-vm.c as there is no notion of unpopulated pages for that
configuration. I think we should fix the Kconfig constraints and give
that a shot. I didn't have any known users of !mmu/percpu-km.c, so I
didn't want to make the changes without someone verifying it or needing
it.

Thanks,
Dennis
