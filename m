Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A32C433EF
	for <linux-sh@archiver.kernel.org>; Mon,  6 Dec 2021 16:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376660AbhLFQ1A (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:27:00 -0500
Received: from brightrain.aerifal.cx ([216.12.86.13]:46738 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376624AbhLFQZR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 6 Dec 2021 11:25:17 -0500
Date:   Mon, 6 Dec 2021 11:21:46 -0500
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arch-owner@vger.kernel.org, linux-mm@kvack.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        npiggin@gmail.com, hch@lst.de, arnd@arndb.de,
        linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] percpu: km: ensure it is used with NOMMU (either UP or
 SMP)
Message-ID: <20211206162140.GJ7074@brightrain.aerifal.cx>
References: <20211130172954.129587-1-vladimir.murzin@arm.com>
 <20211130172954.129587-2-vladimir.murzin@arm.com>
 <YaZiOnNd6fAnLcxz@fedora>
 <8c2b4666-cf13-3735-be1e-b8a1c71df113@arm.com>
 <YaqFyznA5hab3PUA@fedora>
 <a2473a90-bdd3-b5af-6967-73c59952b7c1@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2473a90-bdd3-b5af-6967-73c59952b7c1@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Dec 06, 2021 at 06:01:59AM -0600, Rob Landley wrote:
> On 12/3/21 3:02 PM, Dennis Zhou wrote:
> > On Wed, Dec 01, 2021 at 11:51:04AM +0000, Vladimir Murzin wrote:
> >> Hi,
> >> 
> >> On 11/30/21 5:41 PM, Dennis Zhou wrote:
> >> > Hello,
> >> > 
> >> > On Tue, Nov 30, 2021 at 05:29:54PM +0000, Vladimir Murzin wrote:
> >> >> Currently, NOMMU pull km allocator via !SMP dependency because most of
> >> >> them are UP, yet for SMP+NOMMU vm allocator gets pulled which:
> >> >>
> >> >> * may lead to broken build [1]
> >> >> * ...or not working runtime due to [2]
> >> >>
> >> >> It looks like SMP+NOMMU case was overlooked in bbddff054587 ("percpu:
> >> >> use percpu allocator on UP too") so restore that.
> >> >>
> >> >> [1]
> >> >> For ARM SMP+NOMMU (R-class cores)
> >> >>
> >> >> arm-none-linux-gnueabihf-ld: mm/percpu.o: in function `pcpu_post_unmap_tlb_flush':
> >> >> mm/percpu-vm.c:188: undefined reference to `flush_tlb_kernel_range'
> >> >>
> >> >> [2]
> >> >> static inline
> >> >> int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> >> >>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> >> >> {
> >> >>        return -EINVAL;
> >> >> }
> >> >>
> >> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> >> >> ---
> >> >>  mm/Kconfig | 3 +--
> >> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> >> index d16ba92..66331e0 100644
> >> >> --- a/mm/Kconfig
> >> >> +++ b/mm/Kconfig
> >> >> @@ -425,9 +425,8 @@ config THP_SWAP
> >> >>  # UP and nommu archs use km based percpu allocator
> >> >>  #
> >> >>  config NEED_PER_CPU_KM
> >> >> -	depends on !SMP
> >> >>  	bool
> >> >> -	default y
> >> >> +	default !SMP || !MMU
> >> >>  
> >> > 
> >> > Should this be `depends on !SMP || !MMU` with default yes? Because with
> >> > SMP && MMU, it shouldn't be an option to run with percpu-km.
> >> 
> >> IIUC these are equivalent, truth table would not change if is under "depends"
> >> or "default"
> >> 
> >> SMP    MMU   NEED_PER_CPU_KM
> >>  y      y    !y || !y => n || n => n
> >>  y      n    !y || !n => n || y => y
> >>  n      y    !n || !y => y || n => y
> >>  n      n    !n || !n => y || y => y
> >> 
> > 
> > I may be wrong, but I think this is slightly different as we're using
> > #ifdef / #if defined().
> > 
> >> > 
> >> >>  config CLEANCACHE
> >> >>  	bool "Enable cleancache driver to cache clean pages if tmem is present"
> >> >> -- 
> >> >> 2.7.4
> >> >>
> >> > 
> >> > It's interesting to me that this is all coming up at once. Earlier this
> >> > month I had the same conversation with people involved with sh [1].
> >> > 
> >> > [1] https://lore.kernel.org/linux-sh/YY7tp5attRyK42Zk@fedora/
> >> > 
> >> > I can pull this shortly once I see whatever happened to linux-sh.
> >> 
> >> Ahh, good to know! Adding SH folks here (start of discussion [0]). I see you came
> >> to the same conclusion, right? 
> > 
> > Yeah, I don't see anything else from linux-sh. So I'll go ahead and
> > apply this with my change if you're fine with that.
> 
> I can't test against current until I get some unrelated fixes from Rich Felker
> (who's been busy over the weekend), but I tested the "depends" version on 5.10
> and got a shell prompt on my "make ARCH=sh j2_defconfig" board.
> 
> Tested-by: Rob Landley <rob@landley.net>

Tested-by: Rich Felker <dalias@libc.org>

I've tested the version as originally posted and it works for j2 (sh2)
(both build and runtime checked). I'd tested the other (depends
version) before and I'm fine with either going upstream.

Rich
