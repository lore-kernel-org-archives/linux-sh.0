From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Jun 2013 08:34:24 +0000
Subject: Re: Build regressions/improvements in v3.10-rc4
Message-Id: <alpine.DEB.2.00.1306031022150.19041@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1306031018320.18831@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.1306031018320.18831@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org

On Mon, 3 Jun 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.10-rc4 to v3.10-rc3[3], the summaries are:
>   - build errors: +6/-2
>   - build warnings: +66/-132

  + arch/powerpc/sysdev/mpic.c: error: case label does not reduce to an integer constant:  => 890:9, 898:9, 886:9, 894:9

powerpc-randconfig

  + error: No rule to make target /etc/sound/msndinit.bin:  => N/A
  + error: No rule to make target /etc/sound/msndperm.bin:  => N/A

i386-randconfig

  + error: spi-rspi.c: undefined reference to `shdma_chan_filter':  => .text+0x64f28), .text+0x65108)
  
sh-randconfig

There seems to be something wrong with the dependencies for SH_DMAE_BASE,
with more failures in linux-next for kota2_defconfig and marzen_defconfig
on ARM (http://kisskb.ellerman.id.au/kisskb/buildresult/8848370/ resp.
 http://kisskb.ellerman.id.au/kisskb/buildresult/8848367/)

> [1] http://kisskb.ellerman.id.au/kisskb/head/6290/ (all 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6268/ (all 120 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
