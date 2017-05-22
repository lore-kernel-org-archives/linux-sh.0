From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 22 May 2017 20:54:16 +0000
Subject: Re: [PATCH 4/4] input: tsc2007: move header file out of I2C realm
Message-Id: <20170522205416.GA12016@dtor-ws>
List-Id: <linux-sh.vger.kernel.org>
References: <20170521204013.6623-1-wsa@the-dreams.de>
 <20170521204013.6623-5-wsa@the-dreams.de>
 <20170522074105.umwz723mvkxxmcnj@dell>
In-Reply-To: <20170522074105.umwz723mvkxxmcnj@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, May 22, 2017 at 08:41:05AM +0100, Lee Jones wrote:
> On Sun, 21 May 2017, Wolfram Sang wrote:
> 
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> > 
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  arch/sh/boards/mach-ecovec24/setup.c     | 2 +-
> >  drivers/input/touchscreen/tsc2007_core.c | 2 +-
> >  drivers/mfd/timberdale.c                 | 2 +-
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> >  include/linux/{i2c => input}/tsc2007.h   | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >  rename include/linux/{i2c => input}/tsc2007.h (95%)

This should really go into include/linux/platform_data/, not into
input/, for the same reason you are moving it out of i2c. I'd also like
to get rid of platform data for tsc2007 altogether...

I guess I'll take it (moving to platform_data/) so I can work on generic
properties...

Thanks.

-- 
Dmitry
