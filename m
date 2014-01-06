From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Jan 2014 09:05:21 +0000
Subject: Re: Build regressions/improvements in v3.13-rc7
Message-Id: <CAMuHMdWfHtGQQ-s1z0u-PKagD0i+_pd4=H02=TyMiFfcJW63og@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388998868-31448-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1388998868-31448-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Jan 6, 2014 at 10:01 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.13-rc7[1] to v3.13-rc6[3], the summaries are:
>   - build errors: +14/-4

  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2
  + /scratch/kisskb/src/drivers/mtd/maps/vmu-flash.c: error: (near
initialization for 'vmu_flash_driver.drv'):  => 805:3, 803:3, 804:3
  + /scratch/kisskb/src/drivers/mtd/maps/vmu-flash.c: error: expected
declaration specifiers or '...' before string constant:  => 824:20,
822:16, 823:15
  + /scratch/kisskb/src/drivers/mtd/maps/vmu-flash.c: error: field
name not in record or union initializer:  => 805:3, 803:3, 804:3
  + /scratch/kisskb/src/include/linux/maple.h: error: field 'dev' has
incomplete type:  => 80:16
  + /scratch/kisskb/src/include/linux/maple.h: error: field 'drv' has
incomplete type:  => 85:23

sh-randconfig

  + /scratch/kisskb/src/drivers/tty/serial/nwpserial.c: error:
implicit declaration of function 'udelay'
[-Werror=implicit-function-declaration]:  => 53:3
  + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

powerpc-randconfig

  + error: No rule to make target /etc/sound/msndinit.bin:  => N/A
  + error: No rule to make target /etc/sound/msndperm.bin:  => N/A
  + error: No rule to make target /etc/sound/pndsperm.bin:  => N/A
  + error: No rule to make target /etc/sound/pndspini.bin:  => N/A

i386-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7037/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7026/ (119 out of 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
