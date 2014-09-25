From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 25 Sep 2014 12:16:03 +0000
Subject: renesas-drivers-2014-09-25-v3.17-rc6
Message-Id: <1411647363-11270-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've pushed renesas-drivers-2014-09-25-v3.17-rc6 to
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
This tree is meant to ease development of platform support and drivers for
Renesas ARM ("shmobile") SoCs. It's created by merging the for-next branches
of various subsystem trees into the development branch of Simon Horman's
renesas.git tree.

Today's version is based on renesas-devel-20140924-v3.17-rc6.

Included subsystem trees:
    git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git#linux-next
    git://git.linaro.org/people/mturquette/linux.git#clk-next
    git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git#for-next
    git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git#for-next
    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git#for-next
    git://git.infradead.org/users/dedekind/l2-mtd-2.6.git#master
    git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git#master
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git#tty-next
    git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git#i2c/for-next
    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#for-next
    git://gitorious.org/linux-can/linux-can-next.git#master
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git#usb-next
    git://people.freedesktop.org/~airlied/linux#drm-next
    git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git#next
    git://linuxtv.org/mchehab/media-next.git#master
    git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git#mmc-next
    git://git.linaro.org/people/ulf.hansson/mmc.git#next
    git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git#for-next
    git://git.linaro.org/people/daniel.lezcano/linux.git#clockevents/next
    git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git#next
    git://git.kernel.org/pub/scm/linux/kernel/git/djbw/dmaengine.git#next
    git://git.infradead.org/users/vkoul/slave-dma.git#next
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git#staging-next
    git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git#for-next
    git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git#next
    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git#for-next
    git://git.infradead.org/users/jcooper/linux.git#irqchip/for-next

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
