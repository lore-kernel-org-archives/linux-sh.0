From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 08:08:48 +0000
Subject: Re: [PATCH/RFC 06/12] sh-pfc: Skip gpiochip registration when no GPIO resource is found
Message-Id: <CACRpkdb91cdTtXwS=8U67TVGfVZ7D4H_0iRkeh0SBkx8JOORUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 9:51 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>> But maybe this could be refactored to actually be a number of
>> IOMEM resources?
>
> pfc->info->data_regs is a list of SoC-specific information about GPIO
> registers. It contains, among other information, the register physical address
> in the reg field. pfc->window is a list of ioremapped IOMEM resources.

So the thing is that this array of resources are handled elsewhere, where
they are ioremapped and stashed into pfc->window, OK following now.

> The main purpose of this code is to allow an atomic transition from GPIO
> handling inside the PFC driver to GPIO handling by a separate driver without
> requiring a patch to touch both arch/arm/mach-shmobile/ and
> drivers/pinctrl/sh-pfc/. Such a transition only requires adding the GPIO
> platform device and removing the GPIO IOMEM resource from the PFC device. A
> later patch can then remove the pfc->info->data_regs completely from SoC data
> in drivers/pinctrl/sh-pfc/pfc-*.c.

OK I buy this argument!

Acked-by: Linus Walleij <linus.walleij@linaro.org>

>> The ++i and this thing make the code pretty hard for me to grasp. But maybe
>> I'm just dumb? Could you explain here what is happening, like with some
>> small comment or so....
>
> ++i and i++ would be totally equivalent in the for loop above. I took the
> habit of using the pre-increment style in for loops from my C++ programming
> days (http://forums.codeguru.com/showthread.php?231052-C-Operator-Why-should-I-use-i-instead-of-i).

Interesting, that will be very useful the day we rewrite the kernel in
C++ ;-)

Yours,
Linus Walleij
