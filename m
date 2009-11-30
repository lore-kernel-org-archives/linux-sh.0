From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 30 Nov 2009 10:11:29 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <ubpikcofi.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> > because currect kernel can not use CONFIG_CACHE_WRITEBACK
> >
> Uhm, why not? Where is the bug report on this?

Now I searched by git bisect
I tested on ms7724se / ecovec24

-------------------------
eb3118f652ea7751ecf6a7e467bb637895e3be3b is first bad commit
commit eb3118f652ea7751ecf6a7e467bb637895e3be3b
Author: Matt Fleming <matt@console-pimps.org>
Date:   Thu Oct 29 21:53:30 2009 +0000

sh: Do not apply virt_to_phys() to a physical address

The variable 'phys' already contains the physical address to flush. It
is not a virtual address and should not be passed to virt_to_phys().

Signed-off-by: Matt Fleming <matt@console-pimps.org>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>
-------------------------

When I use this commit,
user-side init doesn't work on ms7724se.
 -> kernel side seems working, after that it say
------------
...
Looking up port of RPC 100003/2 on 192.168.10.77
Looking up port of RPC 100005/1 on 192.168.10.77
VFS: Mounted root (nfs filesystem) on device 0:12.
Freeing unused kernel memory: 104k freed
Kernel panic - not syncing: Attempted to kill init!
------------

And ecovec24 quite doesn't work.
 -> kernel size eigher.

Best regards
--
Kuninori Morimoto
