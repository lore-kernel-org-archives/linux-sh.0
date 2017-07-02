From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 02 Jul 2017 17:15:56 +0000
Subject: Re: [PATCH 1/6] sh: sh7785lcr: add GPIO lookup table for i2c controller reset
Message-Id: <CAMuHMdWxXXH4+orqXq+8BNZ0utnrRCL74ZV+s9ejD=tL3ooSeg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-2-chris.packham@alliedtelesis.co.nz> <201707030057.MeI4Unxu%fengguang.wu@intel.com>
In-Reply-To: <201707030057.MeI4Unxu%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, kbuild test robot <lkp@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Chris,

On Sun, Jul 2, 2017 at 6:47 PM, kbuild test robot <lkp@intel.com> wrote:
> [auto build test ERROR on wsa/i2c/for-next]
> [also build test ERROR on v4.12-rc7 next-20170630]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Chris-Packham/sh-sh7785lcr-add-GPIO-lookup-table-for-i2c-controller-reset/20170702-214426
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> config: sh-sh7785lcr_32bit_defconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sh
>
> All errors (new ones prefixed by >>):
>
>    arch/sh/boards/board-sh7785lcr.c: In function 'sh7785lcr_devices_setup':
>>> arch/sh/boards/board-sh7785lcr.c:295:2: error: implicit declaration of function 'gpiod_add_lookup' [-Werror=implicit-function-declaration]
>      gpiod_add_lookup(&i2c_gpio_table);

It's called gpiod_add_lookup_table()

https://www.kernel.org/pub/tools/crosstool/ is your friend...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
