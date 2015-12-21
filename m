From: Chanwoo Choi <cw00.choi@samsung.com>
Date: Mon, 21 Dec 2015 02:42:05 +0000
Subject: Re: [PATCH] extcon: max3355: kill unneeded #include's
Message-Id: <567766FD.2030004@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6137530.8k1Rzov2Uy@wasted.cogentembedded.com>
In-Reply-To: <6137530.8k1Rzov2Uy@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

On 2015년 12월 21일 03:31, Sergei Shtylyov wrote:
> Some #include's weren't needed from the start, some are left overs from the
> earlier driver versions... Kill 'em all! :-)

I don't prefer following expression. I think you should write the description
to maintain the formal style on the next.
- "... Kill 'em all! :-) "

> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'extcon-next' branch of the 'extcon.git' repo.
> If possible, please fold this patch into the main MAX3355 driver patch.
> 
>  drivers/extcon/extcon-max3355.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> Index: extcon/drivers/extcon/extcon-max3355.c
> =================================> --- extcon.orig/drivers/extcon/extcon-max3355.c
> +++ extcon/drivers/extcon/extcon-max3355.c
> @@ -11,14 +11,9 @@
>  
>  #include <linux/extcon.h>
>  #include <linux/gpio.h>
> -#include <linux/init.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/workqueue.h>
>  
>  struct max3355_data {
>  	struct extcon_dev *edev;
> 

I combine it on original patch.

Thanks,
Chanwoo Choi



