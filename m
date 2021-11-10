Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF7CC433F5
	for <linux-sh@archiver.kernel.org>; Wed, 10 Nov 2021 21:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA67610FF
	for <linux-sh@archiver.kernel.org>; Wed, 10 Nov 2021 21:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhKJVgi (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:36:38 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:51812 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhKJVgh (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 10 Nov 2021 16:36:37 -0500
Date:   Wed, 10 Nov 2021 16:33:46 -0500
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] Fix the j-core SOC build.
Message-ID: <20211110213345.GK7074@brightrain.aerifal.cx>
References: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
 <20211003021851.GA2559@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003021851.GA2559@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sat, Oct 02, 2021 at 10:18:51PM -0400, Rich Felker wrote:
> On Sat, Oct 02, 2021 at 02:32:15PM -0500, Rob Landley wrote:
> > From: Rob Landley <rob@landley.net>
> > 
> > Commit b67177ecd956 broke the j-core SOC build with a link failure, because
> > mm/percpu.c function pcpu_post_unmap_tlb_flush() calls flush_tlb_kernel_range()
> > which is defined under #ifdef CONFIG_MMU.
> > 
> > Signed-off-by: Rob Landley <rob@landley.net>
> > ---
> > 
> >  arch/sh/kernel/smp.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
> > index 65924d9ec245..3ec8f32aad85 100644
> > --- a/arch/sh/kernel/smp.c
> > +++ b/arch/sh/kernel/smp.c
> > @@ -468,4 +468,9 @@ void flush_tlb_one(unsigned long asid, unsigned long vaddr)
> >  	local_flush_tlb_one(asid, vaddr);
> >  }
> > 
> > +#else
> > +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > +{
> > +	local_flush_tlb_all();
> > +}
> >  #endif
> 
> local_flush_tlb_all() is defined in arch/sh/mm/nommu.c as BUG(); so
> this is most likely wrong unless it just doesn't get called. I think
> there should probably be something at a very general level dummying
> out these functions/macros on nommu but I don't know where it should
> be.

I've looked into this some more, and while arch/arm does dummy its
equivalent functions out on nommu, arch/sh has always had them as
BUG(), and indeed it makes some sense to catch erroneous usage.
pcpu_post_unmap_tlb_flush should probably have the flush under #ifdef
CONFIG_MMU or something.

I've added the author of the commit that broke this to Cc in case he
has any thoughts.

Rich
