From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 16 Oct 2015 15:05:37 +0000
Subject: Re: [PATCH 0/3] gpio: rcar: Remove obsolete platform data support
Message-Id: <CACRpkdZuTJCQF-P3m0DNqxv1QaN=j7+w6HRMi2mruOujqVtcQQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Oct 7, 2015 at 10:23 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

>         Hi Greg, Linus, Alexandre,
>
> Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
> setup code"), which is now in arm-soc/for-next, Renesas R-Car SoCs are
> only supported in generic DT-only ARM multi-platform builds.  The driver
> doesn't need to use platform data anymore, hence this driver removes
> platform data configuration.
>
> Unfortunately the platform data header file is used in a few other
> places, so we have to fix these first to avoid breaking the build.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Include this in your pull request.

Yours,
Linus Walleij
