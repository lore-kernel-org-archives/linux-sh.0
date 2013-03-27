From: Ed Cashin <ecashin@coraid.com>
Date: Wed, 27 Mar 2013 18:06:57 +0000
Subject: Re: ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
Message-Id: <9EA8F092-4957-4A05-9C2C-359F0F133E8C@coraid.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[Cc linux-sh@vger.kernel.org]

Do you think that's from virt_addr_valid, used in aoeblk_open?

I see that when CONFIG_FLATMEM is defined, arch/sh/includ/asm/page.h
defines pfn_valid in terms of the undefined variables {min,max}_low_pfn, 
and virt_addr_valid in terms of pfn_valid.

On Mar 27, 2013, at 3:55 AM, Fengguang Wu wrote:

> 
> Hi Ed,
> 
> I'm not sure if it's a good bisect.. Anyway, here is an aoe build error.
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
> commit: e52a29326462badd9ceec90a9eb2ac2a8550e02e aoe: avoid races between device destruction and discovery
> date:   3 months ago
> config: make ARCH=sh titan_defconfig
> 
> All error/warnings:
> 
>   ERROR: "bio_alloc" [fs/xfs/xfs.ko] undefined!
>   ERROR: "__user_walk_fd" [fs/xfs/xfs.ko] undefined!
>   ERROR: "__up" [fs/xfs/xfs.ko] undefined!
>   ERROR: "remove_suid" [fs/xfs/xfs.ko] undefined!
>   ERROR: "__alloc_pages" [fs/xfs/xfs.ko] undefined!
>   ERROR: "get_unused_fd" [fs/xfs/xfs.ko] undefined!
>   ERROR: "d_alloc_root" [fs/xfs/xfs.ko] undefined!
>   ERROR: "__down_trylock" [fs/xfs/xfs.ko] undefined!
>   ERROR: "open_bdev_excl" [fs/xfs/xfs.ko] undefined!
>   ERROR: "sysctl_intvec" [fs/xfs/xfs.ko] undefined!
>   ERROR: "__ashrdi3" [fs/xfs/xfs.ko] undefined!
>   ERROR: "__create_workqueue_key" [fs/xfs/xfs.ko] undefined!
>   ERROR: "kmem_cache_size" [fs/xfs/xfs.ko] undefined!
>   ERROR: "init_waitqueue_head" [fs/xfs/xfs.ko] undefined!
>   ERROR: "__down" [fs/xfs/xfs.ko] undefined!
>   ERROR: "init_timer" [fs/xfs/xfs.ko] undefined!
>   ERROR: "kthread_create" [fs/xfs/xfs.ko] undefined!
>   ERROR: "get_sb_bdev" [fs/xfs/xfs.ko] undefined!
>   ERROR: "vmtruncate" [fs/xfs/xfs.ko] undefined!
>   ERROR: "block_sync_page" [fs/xfs/xfs.ko] undefined!
>   ERROR: "sync_page_range" [fs/xfs/xfs.ko] undefined!
>   ERROR: "d_alloc_anon" [fs/xfs/xfs.ko] undefined!
>   ERROR: "close_bdev_excl" [fs/xfs/xfs.ko] undefined!
>>> ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
>>> ERROR: "max_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
> 
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation

-- 
  Ed Cashin
  ecashin@coraid.com


