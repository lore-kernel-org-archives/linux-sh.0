From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Sep 2015 16:14:57 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Get rid of CONFIG_ARCH_SHMOBILE_LEGACY
Message-Id: <CACRpkdZ5a3tSrvEN=a4=Sjki0_rMAo_AYiQgVCfB1pO9UAhXZQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440706043-3406-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440706043-3406-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Aug 27, 2015 at 1:07 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Shmobile is all multiplatform these days, so get rid of the reference to
> CONFIG_ARCH_SHMOBILE_LEGACY.
>
> Move the legacy code to do the non-DT mapping between GPIOs and pins
> inside the existing #ifdef CONFIG_SUPERH section.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
