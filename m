From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Nov 2013 10:14:37 +0000
Subject: Re: [PATCH] gpio: Renesas RZ GPIO driver
Message-Id: <CAMuHMdUw1P91DeAUOQSXLD7dxG4sR8sUOZTMSFEAayi6ZVN7Hw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106234737.8971.37405.sendpatchset@w520>
In-Reply-To: <20131106234737.8971.37405.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Thu, Nov 7, 2013 at 12:47 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> The hardware allows control of GPIOs in blocks of up to 16 pins,
> and once device may span multiple blocks. Interrupts are not

... one device ...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
