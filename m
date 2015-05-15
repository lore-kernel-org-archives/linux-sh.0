From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 May 2015 08:22:53 +0000
Subject: Re: [PATCH 0/4] i2c: small updates to the slave framework
Message-Id: <CAMuHMdXGi5Gc=4_Fu2xmfGKN862w-v5EtQ_pCOd3Sx2tZyoCSg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

On Thu, May 14, 2015 at 2:40 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Before nailing down the DT representation problem, here are some smaller
> updates for the slave framework I have lying around.
>
> Wolfram Sang (4):
>   i2c: add FUNC flag for slave capabilities
>   i2c: rcar: report slave capabilities to users
>   i2c: slave: docs: be more precise about the prerequsites
>   i2c: slave: add error messages to slave core

This series looks fine to me

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
