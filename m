From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2015 13:48:30 +0000
Subject: Re: [RESEND PATCH v2 2/3] pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
Message-Id: <CAMuHMdVWq3cvRNBqiMX9j_Es-seshqWKbnx_heTm3jAA5ncMiw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442419131-14816-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1442419131-14816-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 16, 2015 at 5:58 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> On this SoC there is no simple mapping of GP pins to pull-up register
> bits, so we need a table.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
