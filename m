From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 18 Aug 2012 13:41:39 +0000
Subject: Re: Build regressions/improvements in v3.6-rc2
Message-Id: <alpine.DEB.2.00.1208181538320.22662@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1208181538001.21972@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.1208181538001.21972@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>

On Sat, 18 Aug 2012, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.6-rc2 to v3.6-rc1[3], the summaries are:
>   - build errors: +4/-6

  + arch/sh/lib/mcount.S: Error: pcrel too far:  => 89

sh-allyesconfig

  + drivers/input/touchscreen/eeti_ts.c: error: implicit declaration of function 'gpio_free' [-Werror=implicit-function-declaration]:  => 243:2
  + drivers/input/touchscreen/eeti_ts.c: error: implicit declaration of function 'gpio_request_one' [-Werror=implicit-function-declaration]:  => 205:2

xtensa-allmodconfig

  + error: No rule to make target /scratch/kisskb/build/linus_m68k-allmodconfig_m68k/usr/include/linux/kvm_para.h:  => N/A

Known issue with kvm_para.h header export

> [1] http://kisskb.ellerman.id.au/kisskb/head/5338/ (all 116 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5315/ (all 116 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
