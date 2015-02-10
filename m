From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2015 11:14:14 +0000
Subject: Re: [PATCH v2 14/15] ARM: shmobile: bockw dts: Move Ethernet node to BSC
Message-Id: <CAMuHMdX2QLYnAV=fOM8VM4V0QOhu2FQAvmsArksD4_sSw1M5Ew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-15-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-15-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 9, 2015 at 5:02 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> +&bsc {
> +       ethernet@18300000 {
> +               compatible = "smsc,lan9220", "smsc,lan9115", "smsc,lan89218";

The most specific (89218) compatible name should be listed first.
I think the 9220 entry is not required, so I'd use just

        compatible = "smsc,lan89218", "smsc,lan9115"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
