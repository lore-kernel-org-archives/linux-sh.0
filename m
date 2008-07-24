From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Thu, 24 Jul 2008 11:37:56 +0000
Subject: Re: sh7760 i2c problem
Message-Id: <20080724113756.GD10338@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <488868B1.7000601@spesonline.com>
In-Reply-To: <488868B1.7000601@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 24, 2008 at 01:34:09PM +0200, Luca Santini wrote:
>
> if i try to compile it as a module, i get:
>
> WARNING: drivers/i2c/busses/i2c-sh7760.o(.data+0x0): Section mismatch in 
> reference from the variable sh7760_i2c_drv to the function 
> .devinit.text:sh7760_i2c_probe()
> The variable sh7760_i2c_drv references
> the function __devinit sh7760_i2c_probe()
> If the reference is valid then annotate the
> variable with __init* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, 
> *_console,
>
> WARNING: drivers/i2c/busses/i2c-sh7760.o(.data+0x4): Section mismatch in 
> reference from the variable sh7760_i2c_drv to the function 
> .devexit.text:sh7760_i2c_remove()
> The variable sh7760_i2c_drv references
> the function __devexit sh7760_i2c_remove()
> If the reference is valid then annotate the
> variable with __exit* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, 
> *_console,
>
>
>
> how to fix this?

replace all instances of "sh7760_i2c_drv" with "sh7760_i2c_driver".
It's not a bug, just a mismatch detector stupidity.

Best regards,
	Manuel Lauss
