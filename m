From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Oct 2015 14:07:44 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7795: Make PORT_GP_x() macros consistent
Message-Id: <CACRpkdZ=xher-CLsNWaTCbrVyp61rQ1vXjB60B5Pi0_77-6idQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446147587-20216-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446147587-20216-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Oct 29, 2015 at 8:39 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> On r8a7795, PORT_GP_x() is a macro for defining GPIOs 0..x.
> In all other sh-pfc code, PORT_GP_x() is a macro for defining GPIOs
> 0..(x-1).
>
> Make the r8a7795 macro definitions consistent with the rest of the
> sh-pfc codebase.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Counting on you to stack this up again, but let's save the next pull
request until after the merge window.

Yours,
Linus Walleij
