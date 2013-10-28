From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Oct 2013 19:31:45 +0000
Subject: Re: Build regressions/improvements in v3.12-rc7
Message-Id: <alpine.DEB.2.02.1310282029140.14406@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1310282028510.14364@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.02.1310282028510.14364@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org

On Mon, 28 Oct 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.12-rc7 to v3.12-rc6[3], the summaries are:
>   - build errors: +9/-10

  + /scratch/kisskb/src/arch/powerpc/kernel/cacheinfo.c: error: 'associativity' may be used uninitialized in this function [-Werror=uninitialized]:  => 575:2
  + /scratch/kisskb/src/arch/powerpc/kernel/cacheinfo.c: error: 'size_kb' may be used uninitialized in this function [-Werror=uninitialized]:  => 526:2
  + /scratch/kisskb/src/drivers/tty/serial/nwpserial.c: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]:  => 53:3

powerpc-randconfig

  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error: implicit declaration of function 'dma_alloc_writecombine' [-Werror=implicit-function-declaration]:  => 91:2
  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error: implicit declaration of function 'dma_free_writecombine' [-Werror=implicit-function-declaration]:  => 176:3

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6819/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6796/ (all 120 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
