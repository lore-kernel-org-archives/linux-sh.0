From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Jan 2014 19:05:21 +0000
Subject: Re: [PATCH 1/4] ARM: lager: enable i2c devices
Message-Id: <CAMuHMdWu_qy6kHsMDTOuBA2swghV6tn5g9yghzCAx0Tqatqqxg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982298-23143-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389982298-23143-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 17, 2014 at 7:11 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Add i2c0, i2c1, i2c2 and i2c3 nodes to the Lager reference device tree as
> these busses all have devices on them that can be probed even if they

s/they/there/

> are no drivers yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
