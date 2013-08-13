From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Aug 2013 08:53:06 +0000
Subject: Re: Build regressions/improvements in v3.11-rc5
Message-Id: <alpine.DEB.2.02.1308131052320.25160@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1308131050570.25134@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.02.1308131050570.25134@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: linux-sh@vger.kernel.org

On Tue, 13 Aug 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.11-rc5 to v3.11-rc4[3], the summaries are:
>   - build errors: +11/-21

  + arch/sh/drivers/pci/pci.c: error: 'sh_io_port_base' undeclared (first use in this function):  => 304:23
  + drivers/atm/eni.c: error: conflicting types for 'dump_mem':  => 166:13
  + lib/checksum.c: error: redefinition of 'csum_partial_copy_from_user':  => 156:1
  + lib/checksum.c: error: redefinition of 'csum_tcpudp_nofold':  => 184:8
  + lib/checksum.c: error: redefinition of 'ip_compute_csum':  => 146:9
  + lib/checksum.c: error: redefinition of 'ip_fast_csum':  => 110:9

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6532/ (all 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6510/ (all 120 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
