From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Jun 2017 19:16:12 +0000
Subject: Re: [PATCH] fortify: Avoid panic() in favor of BUG()
Message-Id: <CAGXu5jL5uDLDUfLtoyfCOpGByR=XLN5yGcePreCs7jN6NE=0Hw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170626235122.GA25261@beast> <201706272333.FIsTGv3H%fengguang.wu@intel.com>
In-Reply-To: <201706272333.FIsTGv3H%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh <linux-sh@vger.kernel.org>
Cc: kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Micay <danielmicay@gmail.com>, LKML <linux-kernel@vger.kernel.org>

On Tue, Jun 27, 2017 at 8:52 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Kees,
>
> [auto build test WARNING on next-20170619]
> [cannot apply to linus/master linux/master v4.12-rc6 v4.12-rc5 v4.12-rc4 v4.12-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Kees-Cook/fortify-Avoid-panic-in-favor-of-BUG/20170627-230653
> config: sh-allyesconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sh
>
> All warnings (new ones prefixed by >>):
>
>    lib/string.c: In function 'fortify_panic':
>>> lib/string.c:986:1: warning: 'noreturn' function does return
>     }
>     ^
>
> vim +/noreturn +986 lib/string.c
>
> 94df2904 Rasmus Villemoes 2015-06-25  970   *
> 94df2904 Rasmus Villemoes 2015-06-25  971   * Returns pointer to the nul byte at the end of @s.
> 94df2904 Rasmus Villemoes 2015-06-25  972   */
> 94df2904 Rasmus Villemoes 2015-06-25  973  char *strreplace(char *s, char old, char new)
> 94df2904 Rasmus Villemoes 2015-06-25  974  {
> 94df2904 Rasmus Villemoes 2015-06-25  975       for (; *s; ++s)
> 94df2904 Rasmus Villemoes 2015-06-25  976               if (*s = old)
> 94df2904 Rasmus Villemoes 2015-06-25  977                       *s = new;
> 94df2904 Rasmus Villemoes 2015-06-25  978       return s;
> 94df2904 Rasmus Villemoes 2015-06-25  979  }
> 94df2904 Rasmus Villemoes 2015-06-25  980  EXPORT_SYMBOL(strreplace);
> b90d6eba Daniel Micay     2017-06-06  981
> b90d6eba Daniel Micay     2017-06-06  982  void fortify_panic(const char *name)
> b90d6eba Daniel Micay     2017-06-06  983  {
> 8a94b337 Kees Cook        2017-06-26  984       pr_emerg("detected buffer overflow in %s\n", name);
> 8a94b337 Kees Cook        2017-06-26  985       BUG();
> b90d6eba Daniel Micay     2017-06-06 @986  }
> b90d6eba Daniel Micay     2017-06-06  987  EXPORT_SYMBOL(fortify_panic);

This implies that the sh arch doesn't correctly mark their BUG
implementation as not returning... I'll send a patch.

-Kees

-- 
Kees Cook
Pixel Security
