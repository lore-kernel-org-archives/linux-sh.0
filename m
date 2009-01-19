From: Adrian McMenamin <lkmladrian@gmail.com>
Date: Mon, 19 Jan 2009 22:33:57 +0000
Subject: Re: Bug: Latest (rc2 and beyond) kernel fails on Dreamcast
Message-Id: <8b67d60901191433u51d062bgffa523c7da811cb8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60901181626l43a8728fh6f2a2ab146b45d90@mail.gmail.com>
In-Reply-To: <8b67d60901181626l43a8728fh6f2a2ab146b45d90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

2009/1/19 Adrian McMenamin <lkmladrian@gmail.com>:
> I haven't had time to look at this, but the most up to date kernel
> (and the one of around a week ago also) fails to boot, seemingly
> seeking an IP address for the 8139too based NIC.

> [    4.664236] Sending DHCP requests .<3>eth0: PCI Bus error 2200.
> [    4.669582] eth0: PCI Bus error 2200.
> [    4.673395] eth0: PCI Bus error 2200.
> [    4.677152] eth0: PCI Bus error 2200.
> [    4.680905] eth0: PCI Bus error 2200.
> [    4.684677] eth0: PCI Bus error 2200.
> [    4.688450] eth0: PCI Bus error 2200.
> [    4.692245] eth0: PCI Bus error 2200.
> [    4.695944] eth0: PCI Bus error 2200.
> [    4.699767] eth0: PCI Bus error 2200.
> [    4.703540] eth0: PCI Bus error 2200.
> [    4.707336] eth0: PCI Bus error 2200.
> [    4.711086] eth0: PCI Bus error 2200.
> [    4.714858] eth0: PCI Bus error 2200.
> [    4.718630] eth0: PCI Bus error 2200.
> [    4.722415] eth0: PCI Bus error 2200.
> [    4.726187] eth0: PCI Bus error 2200.
> [    4.729948] eth0: PCI Bus error 2200.
> [    4.733720] eth0: PCI Bus error 2200.
> [    4.737492] eth0: PCI Bus error 2200.
> [    4.741288] eth0: PCI Bus error 2200.
> [    4.745038] eth0: PCI Bus error 2200.
> [    4.748810] eth0: PCI Bus error 2200.
>
> and so on ... quite possibly for ever. Will investigate further.
>

And the bisection reveals the following:

adrian@bossclass:~/linux-2.6$ git bisect bad
58c6d3dfe436eb8cfb451981d8fdc9044eaf42da is first bad commit
commit 58c6d3dfe436eb8cfb451981d8fdc9044eaf42da
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue Jan 6 14:43:10 2009 -0800

    dma-coherent: catch oversized requests to dma_alloc_from_coherent()

    Prevent passing an order to bitmap_find_free_region() that is larger than
    the actual bitmap can represent.

    These requests can come from device drivers that have no idea how big the
    dma region is and need to rely on dma_alloc_from_coherent() to sort it out
    for them.

    Reported-by: Guennadi Liakhovetski <lg@denx.de>
    Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
    Cc: Pekka Enberg <penberg@cs.helsinki.fi>
    Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
    Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
    Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 5c8a694b778f36a3254103d99cb73b561cb84565
5efd4e32eb145f32ca4e96aefbea08f4f8f4d27d M	kernel
