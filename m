From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 05 Mar 2014 01:58:27 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7791: SD1_CLK fix
Message-Id: <CACRpkdYK_ej8f_+EUsgc_X-iJ-Ynp40az59i6D1z9f4k31v+rQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140226101026.16737.30404.sendpatchset@w520>
In-Reply-To: <20140226101026.16737.30404.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Valentine <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>

On Wed, Feb 26, 2014 at 6:10 PM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Fix the SD1_CLK handling for r8a7791. Without this patch
> it is impossible to request all pins needed for SDHI1 on
> the Koelsch board.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied for fixes.

Yours,
Linus Walleij
