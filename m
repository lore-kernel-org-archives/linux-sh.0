From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 05 Jul 2017 11:48:54 +0000
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Message-Id: <CAHp75VfKhTkBZfuDdp=hkZMkXyBmMdYwrSNLmO-PyBz==NtrRQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-i2c <linux-i2c@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 5, 2017 at 1:13 PM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> This series addresses some of the points identified by Andy. The series is
> based on top of i2c/for-next. 2 of the patches from v1 have already been
> applied so I've dropped them from this version.
>
> I have compile tested patch 1/1 but I don't have access to sh hardware
> to actually test the changes on.


Entire series looks good to me:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Further improvement is to get timeout value via device properties API
and get rid of legacy platform data completely. This can be done in
further series.

>
> Chris Packham (4):
>   sh: sh7785lcr: add GPIO lookup table for i2c controller reset
>   i2c: pca-platform: unconditionally use devm_gpiod_get_optional
>   i2c: pca-platform: use device_property_read_u32
>   i2c: pca-platform: drop gpio from platform data
>
>  arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
>  arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-
>  drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++----------------------
>  include/linux/i2c-pca-platform.h          |  3 ---
>  4 files changed, 20 insertions(+), 29 deletions(-)
>
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
