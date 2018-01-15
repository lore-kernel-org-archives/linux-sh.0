From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2018 08:12:04 +0000
Subject: Re: [PATCH 1/2] sh_eth: gather all TSU init code in one place
Message-Id: <CAMuHMdUFhW7LVtVyQ8hFT+8+Us8WV7W2n9B9Zac=yCRNKv3+5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180114175159.604307495@cogentembedded.com>
In-Reply-To: <20180114175159.604307495@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev <netdev@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Jan 14, 2018 at 6:47 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The  sh_eth_cpu_data::chip_reset() method  always resets using ARSTR and
> this register is always located at the start of the  TSU register region.
> Therefore, we can  only call  this method if we know TSU is there and thus
> simplify  the probing code a  bit...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
