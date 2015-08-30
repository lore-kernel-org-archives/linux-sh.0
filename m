From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 30 Aug 2015 09:01:39 +0000
Subject: Re: [PATCH 0/6] arm64: renesas: r8a7795/salvator-x Serial Support
Message-Id: <CAMuHMdWmw+eAfAD3GL=a8b9D5YvEZ3fc65k5nn6oKG3WF+xO5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440612832-17627-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440612832-17627-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Sat, Aug 29, 2015 at 4:32 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Aug 27, 2015 at 3:13 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> FYI, I'm currently in the process of picking out the SCIF related bits
> for inclusion in an upcoming minimalistic-and-stable R-Car Gen3 v8
> integration series that I intend to post this weekend or early next
> week. So please do not update anything.
>
> That said, while going through your patches I noticed that SCIF2 did
> not have any dma nodes. I assumed that was something that fell between
> the hunks so to say. If that was intentional then please let me know.

It was intentional, as SCIF2 isn't DMA-capable, according to the latest
datasheet I have.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
