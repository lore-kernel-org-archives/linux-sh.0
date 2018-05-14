From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 14 May 2018 11:38:59 +0000
Subject: Re: [PATCH v3 2/3] platform: move the early platform device support to arch/sh
Message-Id: <20180514113859.GA6358@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-3-brgl@bgdev.pl>
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 04, 2018 at 03:27:30PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
> 
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
> 
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
