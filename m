From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Mon, 07 Jul 2014 22:35:06 +0000
Subject: Re: renesas-drivers-2014-07-07-v3.16-rc4
Message-Id: <53BB209A.5030303@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
In-Reply-To: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thanks for creating this.

I have a naive question about its usage.
Could you clarify how developers should use your tree and Simon tree ?

- Currently, as my understanding, patches are developed and submitted 
  base on devel branch of Simon tree.
- So, with your tree, patches will be developed base on your tree and you
  and/or Simon will re-base into devel branch of Simon tree for upstream ?

Is it how it will work ?

Thanks.

Best regards,
KHIEM Nguyen

On 7/7/2014 8:05 PM, Geert Uytterhoeven wrote:
> Hi all,
> 
> I've pushed renesas-drivers-2014-07-07-v3.16-rc4 to
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> This tree is meant to ease development of platform support and drivers for
> Renesas ARM ("shmobile") SoCs. It's created by merging the for-next branches
> of various subsystem trees into the development branch of Simon Horman's
> renesas.git tree.
> 
> Today's version is based on renesas-devel-v3.16-rc4-20140707, and contains
> the following for-next branches:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git#linux-next
> git://git.linaro.org/people/mturquette/linux.git#clk-next
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git#for-next
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git#for-next
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git#for-next
> git://git.infradead.org/users/dedekind/l2-mtd-2.6.git#master
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git#master
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git#tty-next
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git#i2c/for-next
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#asoc/for-next
> git://gitorious.org/linux-can/linux-can-next.git#master
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git#usb-next
> git://people.freedesktop.org/~airlied/linux#drm-next
> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git#next
> git://linuxtv.org/mchehab/media-next.git#master
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git#mmc-next
> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git#for-next
> git://git.linaro.org/people/daniel.lezcano/linux.git#clockevents/next
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git#next
> git://git.kernel.org/pub/scm/linux/kernel/git/djbw/dmaengine.git#next
> git://git.infradead.org/users/vkoul/slave-dma.git#next
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git#staging-next
> git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git#for-next
> 
> If anything is missing, please tell me.
> 
> Thanks for your comments!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
