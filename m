From: Andrew Murray <amurray@mpcdata.com>
Date: Thu, 29 Jul 2010 10:50:32 +0000
Subject: Coherent memory allocator
Message-Id: <AANLkTinQHQOATkLVc+v+mWBzc3rprnA11yvLmMOmBhuM@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Whilst trying to reduce boot time on an SH kernel I noticed the
coherent memory allocator (dma_generic_alloc_coherent) in
arch/sh/mm/consistent.c always memset's the memory it allocates to 0 -
regardless of the user's intention (i.e use of __GFP_ZERO flag as
argument).

I would expect this function to not memset it's memory and instead
allow the user to specify if they want the memory zeroed through the
gfp flags. This would ensure memory is only zeroed when required - and
when it is required the __get_free_pages implementation uses the more
efficient clear_page implementation.

However removing the memset may break drivers than rely on zeroed
memory even though they don't request it.

Is my reasoning valid? Shall I submit a patch?

Thanks,

Andrew Murray
