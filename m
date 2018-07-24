From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Jul 2018 21:33:36 +0000
Subject: Re: [RESEND PATCH 4/4] sh: remove board_time_init() callback
Message-Id: <CAK8P3a0xYSaGbtxGWN=3NmcBnQ3Fd6rnHXp=0D0_MLXaJKfS+w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <0ad306a7d410d3695c7869bf081efaa71e956ae4.1531826106.git.baolin.wang@linaro.org>
 <201807250052.6f8He2LR%fengguang.wu@intel.com>
In-Reply-To: <201807250052.6f8He2LR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, kbuild-all@01.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jul 24, 2018 at 7:07 PM, kbuild test robot <lkp@intel.com> wrote:
> Hi Arnd,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on sof-driver-fuweitax/master]
> [also build test ERROR on v4.18-rc6 next-20180724]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/sh-dreamcast-rtc-push-down-rtc-class-ops-into-driver/20180719-041209
> base:   https://github.com/fuweitax/linux master
> config: sh-rsk7264_defconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh
>
> All errors (new ones prefixed by >>):
>
>    arch/sh/kernel/time.c: In function 'time_init':
>>> arch/sh/kernel/time.c:42:2: error: implicit declaration of function 'timer_init'; did you mean 'time_init'? [-Werror=implicit-function-declaration]
>      timer_init();
>      ^~~~~~~~~~

Hmm, I fixed it locally, but Baolin forwarded the version from the
original submission that had the same bug (timer_init instead of timer_probe):

https://www.spinics.net/lists/linux-sh/msg52798.html

I'll just send the correct version once more.

      Arnd
