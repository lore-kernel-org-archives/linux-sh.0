From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 09 Apr 2013 21:07:02 +0000
Subject: Re: Build regressions/improvements in v3.9-rc6
Message-Id: <alpine.DEB.2.00.1304092304550.23730@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1304092304220.23715@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.1304092304220.23715@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org

On Tue, 9 Apr 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.9-rc6 to v3.9-rc5[3], the summaries are:
>   - build errors: +8/-13

Ignoring R_PPC64_REL24 truncated relocations, as usual:

  + error: binder.c: undefined reference to `get_vm_area':  => .text+0x2fe8b8)
  + error: binder.c: undefined reference to `map_vm_area':  => .text+0x2fa11c) 
  + error: binder.c: undefined reference to `zap_page_range':  => .text+0x2fa354)

sh4/sh-randconfig

  + error: cuboot-pq2.c: undefined reference to `fsl_get_immr':  => .text+0x314)

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6063/ (all 118 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6041/ (all 118 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
