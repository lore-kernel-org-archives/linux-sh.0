From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 17 Jul 2020 07:11:49 +0000
Subject: Suggested patches for merging
Message-Id: <8538a950-8e21-29c7-dd0e-fa6e49e2bcef@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich!

After updating my SH kernel to the latest git version and applying various proposed
patches on top, my machines runs very stable. I suggest merging the following patches:

> [PATCH 01/10] sh: remove -Werror from Makefiles
> https://marc.info/?l=linux-sh&m9472940531658&w=2

> [PATCH 02/10] sh: sort the selects for SUPERH alphabetically
> https://marc.info/?l=linux-sh&m9472953631694&w=2

> [PATCH 03/10] sh: remove __KERNEL__ ifdefs from non-UAPI headers
> https://marc.info/?l=linux-sh&m9472967331732&w=2

> [PATCH 04/10] sh: move ioremap_fixed details out of <asm/io.h>
> https://marc.info/?l=linux-sh&m9472980331793&w=2

> [PATCH 05/10] sh: move the ioremap implementation out of line
> https://marc.info/?l=linux-sh&m9472993031837&w=2

> [PATCH 06/10] sh: don't include <asm/io_trapped.h> in <asm/io.h>
> https://marc.info/?l=linux-sh&m9472995331856&w=2

> [PATCH 07/10] sh: unexport register_trapped_io and match_trapped_io_handler
> https://marc.info/?l=linux-sh&m9472993331840&w=2

> [PATCH 08/10] dma-mapping: consolidate the NO_DMA definition in kernel/dma/Kconfig
> https://marc.info/?l=linux-sh&m9472994531848&w=2

> [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
> https://marc.info/?l=linux-sh&m9472994631849&w=2

> [PATCH 10/10] sh: use the generic dma coherent remap allocator
> https://marc.info/?l=linux-sh&m9472994631850&w=2

> [PATCH] sh: Implement __get_user_u64() required for 64-bit get_user()
> https://marc.info/?l=linux-sh&m9186232702043&w=2

> [PATCH v2 0/9] sh: Modernize printing of kernel messages
> https://lore.kernel.org/lkml/20200617143639.18315-1-geert+renesas@glider.be/

These patches fix multiple important issues on SH, but are most likely
going in through different trees:

> [PATCH v2] serial: core: Initialise spin lock before use in uart_configure_port()
> https://lore.kernel.org/linux-serial/20200706143548.63985-1-andriy.shevchenko@linux.intel.com/

> sh: Fix unneeded constructor in page table allocation
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?idsc348f31b63d28d176ed290eb1aa2a648f3e51e
> You seem to have already picked this one up?

> sh/tlb: Fix PGTABLE_LEVELS > 2
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=mm/tlb&id19a4bf8dcb42efc278940fb81c288c346b3eda

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
