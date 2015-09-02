From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 09:30:16 +0000
Subject: Re: [PATCH 0/6] arm64: renesas: Obtain MD pin values using syscon/regmap
Message-Id: <CAMuHMdWQedgxL3UNc6_a1KWAhyX8NDk1Kq0xFwn=dDkHGYA7Zg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441120361-1232-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441120361-1232-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 1, 2015 at 5:12 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series converts the R-Car Gen3 Clock Pulse Generator (CPG)
> driver from obtaining the mode pin values using mapping of the hardcoded
> MODEMR register to using syscon and regmap.
>
> It follows the same spirit as "[PATCH/RFC 00/11] ARM: shmobile: Let CPG
> use syscon for MD pin values"[*], but this time I did write DT binding
> documentation.
>
> Feel free to fold some patches into the r8a7795 cpg, dtsi, and Kconfig
> baseline.

Imported into topic/gen3-modemr-syscon-v1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
