From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Aug 2014 13:11:18 +0000
Subject: ARM: shmobile: "i2c<m>" vs. "iic<n>" DT nodes and pinmux
Message-Id: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>

Hi,

On r8a7790, DT device nodes and C/DT pinmux data for IIC<n> are called
"iic<n>", with DT aliases from "i2c<m>" to the "iic<n>" DT nodes.
On r8a7791, DT device nodes and C/DT pinmux data for IIC<n> are called
"i2c<m>", with DT aliases from "i2c<m>" to the "i2c<m>" DT nodes.

In light of the proliferation of other members of the R-Car Gen 2 families, is
there a plan to make this consistent?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
