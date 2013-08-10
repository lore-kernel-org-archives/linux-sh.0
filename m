From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Aug 2013 18:19:30 +0000
Subject: Re: Build regressions/improvements in v3.11-rc4
Message-Id: <alpine.DEB.2.02.1308102018470.30367@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1308102018140.30352@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.02.1308102018140.30352@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org

On Sat, 10 Aug 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.11-rc4 to v3.11-rc3[3], the summaries are:
>   - build errors: +20/-35

  + arch/powerpc/kernel/cacheinfo.c: error: 'size_kb' may be used uninitialized in this function [-Werror=uninitialized]:  => 526:16
  + arch/powerpc/kernel/pci_dn.c: error: 'ret' may be used uninitialized in this function [-Werror=uninitialized]:  => 97:8
  + arch/powerpc/kvm/book3s_hv.c: error: 'vcpus_to_update[need_vpa_update]' may be used uninitialized in this function [-Werror=uninitialized]:  => 1187:22
  + arch/powerpc/kvm/book3s_xics.c: error: implicit declaration of function 'get_tb' [-Werror=implicit-function-declaration]:  => 812:3
  + arch/powerpc/mm/hash_native_64.c: error: 'a_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 578:10
  + arch/powerpc/platforms/cell/axon_msi.c: error: 'ph' may be used uninitialized in this function [-Werror=uninitialized]:  => 172:2
  + arch/powerpc/platforms/cell/axon_msi.c: error: 'prop' may be used uninitialized in this function [-Werror=uninitialized]:  => 237:2
  + arch/powerpc/platforms/cell/beat_iommu.c: error: 'dma_base' may be used uninitialized in this function [-Werror=uninitialized]:  => 69:11
  + arch/powerpc/platforms/cell/beat_iommu.c: error: 'dma_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 68:2
  + arch/powerpc/platforms/cell/beat_iommu.c: error: 'io_page_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 68:54
  + arch/powerpc/platforms/cell/beat_wrapper.h: error: 'io_space_id' may be used uninitialized in this function [-Werror=uninitialized]:  => 249:2
  + arch/powerpc/platforms/cell/beat_wrapper.h: error: 'ioid' may be used uninitialized in this function [-Werror=uninitialized]:  => 249:2
  + arch/powerpc/platforms/cell/spufs/inode.c: error: incompatible types when assigning to type 'kgid_t' from type 'int':  => 628:16
  + arch/powerpc/platforms/cell/spufs/inode.c: error: incompatible types when assigning to type 'kuid_t' from type 'int':  => 623:16
  + arch/powerpc/platforms/powernv/pci-ioda.c: error: 'hose' may be used uninitialized in this function [-Werror=uninitialized]:  => 1175:74
  + arch/powerpc/platforms/pseries/pci.c: error: 'pcie_link_speed_stats' may be used uninitialized in this function [-Werror=uninitialized]:  => 150:31

powerpc-randconfig

  + arch/sh/mm/cache-sh4.c: error: 'cached_to_uncached' undeclared (first use in this function):  => 99:17
  + arch/sh/mm/cache-sh4.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6510/ (all 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6490/ (all 120 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
