From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 08:31:58 +0000
Subject: Re: [PATCH] gpio: em: Remove obsolete platform data support
Message-Id: <CACRpkda1M-AmT=YJUEpK2BbpHjjXu5=EgSOWy1yjOgVcJAS6VA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435067282-17314-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435067282-17314-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Jun 23, 2015 at 3:48 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since commit 59032702ead90562 ("ARM: shmobile: Remove legacy platform
> devices from EMEV2 SoC code"), EMMA Mobile SoCs are only supported in
> generic DT-only ARM multi-platform builds.  The driver doesn't need to
> use platform data anymore, hence remove platform data configuration.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only due to lack of hardware.

Patch applied.

Yours,
Linus Walleij
