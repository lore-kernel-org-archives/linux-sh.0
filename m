From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Apr 2013 18:56:11 +0000
Subject: Re: Build regressions/improvements in v3.9-rc7
Message-Id: <alpine.DEB.2.00.1304162052420.2358@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1304162052210.2338@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.1304162052210.2338@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org

On Tue, 16 Apr 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.9-rc7 to v3.9-rc6[3], the summaries are:
>   - build errors: +8/-10

  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function '__ioremap_at' [-Werror=implicit-function-declaration]:  => 225:2
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function '__iounmap_at' [-Werror=implicit-function-declaration]:  => 316:3
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'in_le32' [-Werror=implicit-function-declaration]:  => 70:2
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'ioremap' [-Werror=implicit-function-declaration]:  => 213:2  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]:  => 318:3
  + drivers/pcmcia/electra_cf.c: error: implicit declaration of function 'out_le32' [-Werror=implicit-function-declaration]:  => 147:2

powerpc-randconfig

>   - build warnings: +164/-34

And my eye fell on this one:

  + include/math-emu/double.h: warning: "__LITTLE_ENDIAN" is not defined [-Wundef]:  => 59:5
  + include/math-emu/single.h: warning: "__LITTLE_ENDIAN" is not defined [-Wundef]:  => 50:5

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6094/ (all 118 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6063/ (all 118 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
