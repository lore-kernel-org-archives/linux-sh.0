From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Jan 2014 08:41:05 +0000
Subject: Re: Build regressions/improvements in v3.13
Message-Id: <CAMuHMdVBD7Gn_0zNBD+oVq11=UrCrB-Aocm4EmGRgHdRqF+XoA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390291850-17849-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1390291850-17849-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jan 21, 2014 at 9:10 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.13[1]  to v3.13-rc8[3], the summaries are:
>   - build errors: +22/-3

  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'dmac_resource.end'):  => 87:2
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'dmac_resource.start'):  => 86:2
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[0].end'):  => 69:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[0].start'):  => 68:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[1].end'):  => 74:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'epbr_resources[1].start'):  => 73:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[0].end'):  => 50:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[0].start'):  => 49:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[1].end'):  => 55:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'femi_resources[1].start'):  => 54:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[0].end'):  => 100:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[0].start'):  => 99:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[1].end'):  => 105:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: (near initialization for 'pbr_resources[1].start'):  => 104:3
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: braced-group within expression allowed only inside a function:
=> 30:12, 73:12, 31:10, 99:12, 68:12, 36:10, 86:11, 54:12, 74:10,
55:10, 104:12, 49:12, 69:10, 87:9, 105:10, 35:12, 50:10, 100:10
  + /scratch/kisskb/src/arch/sh/drivers/superhyway/ops-sh4-202.c:
error: initializer element is not constant:  => 74:3, 86:2, 55:3,
105:3, 73:3, 68:3, 100:3, 104:3, 99:3, 87:2, 50:3, 69:3, 49:3, 54:3
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error:
'cached_to_uncached' undeclared (first use in this function):  =>
99:17
  + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit
declaration of function 'cpu_context'
[-Werror=implicit-function-declaration]:  => 192:2
  + /scratch/kisskb/src/kernel/bounds.c: error: -mcall-aixdesc must be
big endian:  => 1:0

sh-randconfig

  + /scratch/kisskb/src/scripts/mod/devicetable-offsets.c: error:
-mcall-aixdesc must be big endian:  => 1:0
  + /scratch/kisskb/src/scripts/mod/empty.c: error: -mcall-aixdesc
must be big endian:  => 1:0
  + <stdin>: error: -mcall-aixdesc must be big endian:  => 1:0

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7082/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7056/ (119 out of 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
