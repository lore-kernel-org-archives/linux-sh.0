From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 03 Nov 2015 12:05:05 +0000
Subject: Re: [PATCH] arm64: Increase the max granular size
Message-Id: <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
 <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
In-Reply-To: <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Nov 03, 2015 at 12:07:06PM +0100, Geert Uytterhoeven wrote:
> On Wed, Oct 28, 2015 at 8:09 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Tue, Sep 22, 2015 at 07:59:48PM +0200, Robert Richter wrote:
> >> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> >>
> >> Increase the standard cacheline size to avoid having locks in the same
> >> cacheline.
> >>
> >> Cavium's ThunderX core implements cache lines of 128 byte size. With
> >> current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
> >> share the same cache line leading a performance degradation.
> >> Increasing the size fixes that.
> >>
> >> Increasing the size has no negative impact to cache invalidation on
> >> systems with a smaller cache line. There is an impact on memory usage,
> >> but that's not too important for arm64 use cases.
> >>
> >> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> >> Signed-off-by: Robert Richter <rrichter@cavium.com>
> >
> > Applied. Thanks.
> 
> This patch causes a BUG() on r8a7795/salvator-x, for which support is not
> yet upstream.
> 
> My config (attached) uses SLAB. If I switch to SLUB, it works.
> The arm64 defconfig works, even if I switch from SLUB to SLAB.
[...]
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:2283!
> Internal error: Oops - BUG: 0 [#1] SMP
[...]
> Call trace:
> [<ffffffc00014f9b4>] __kmem_cache_create+0x21c/0x280
> [<ffffffc00068be50>] create_boot_cache+0x4c/0x80
> [<ffffffc00068bed8>] create_kmalloc_cache+0x54/0x88
> [<ffffffc00068bfc0>] create_kmalloc_caches+0x50/0xf4
> [<ffffffc00068db08>] kmem_cache_init+0x104/0x118
> [<ffffffc00067d7d8>] start_kernel+0x218/0x33c

I haven't managed to reproduce this on a Juno kernel. Could you please
add some debug printing to see what's being passed to kmalloc_slab()?
The freelist_size getting out of bounds?

-- 
Catalin

