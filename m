From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 07 Oct 2015 21:42:10 +0000
Subject: Re: [PATCH v2 2/2] [media] rcar_vin: Remove obsolete platform data support
Message-Id: <CAMuHMdU0qjZe6OmZN3f9yUT1xnt3H3WeOTXgLBJC4-5514UKcA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444214376-26931-3-git-send-email-geert+renesas@glider.be>
	<201510080202.LaV6j8eq%fengguang.wu@intel.com>
In-Reply-To: <201510080202.LaV6j8eq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "kbuild-all@01.org" <kbuild-all@01.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Oct 7, 2015 at 8:32 PM, kbuild test robot <lkp@intel.com> wrote:
> [auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]
>
> config: arm-bockw_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>>> arch/arm/mach-shmobile/board-bockw.c:24:45: fatal error: linux/platform_data/camera-rcar.h: No such file or directory
>     #include <linux/platform_data/camera-rcar.h>
>                                                 ^

Please ignore. Legacy (non-DT) bockw support has been removed in
arm-soc/for-next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
