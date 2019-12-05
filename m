From: Rob Landley <rob@landley.net>
Date: Thu, 05 Dec 2019 19:13:04 +0000
Subject: Re: [PATCH v2] drivers: Fix boot problem on SuperH
Message-Id: <4e06aa64-59e1-888d-184a-0cb49ac175d5@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20191203205852.15659-1-linux@roeck-us.net>
In-Reply-To: <20191203205852.15659-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

On 12/3/19 2:58 PM, Guenter Roeck wrote:
> SuperH images crash too eearly to display any console output. Bisect
> points to commit 507fd01d5333 ("drivers: move the early platform device
> support to arch/sh"). An analysis of that patch suggests that
> early_platform_cleanup() is now called at the wrong time. Restoring its
> call point fixes the problem.
> 
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Yup, I need this too.

Acked-by: Rob Landley <rob@landley.net>

Rob
