From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Dec 2018 08:27:34 +0000
Subject: Re: [PATCH v4 0/4] serial: sh-sci: Fix fallback to PIO on DMA failure
Message-Id: <CAMuHMdWd6N1w0-gb744xEJOh8zGiBoru8yZCdNT1O69fbdQ__Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be> <c6dd8a4a-234c-ff1e-0d22-7af61dcec427@landley.net>
In-Reply-To: <c6dd8a4a-234c-ff1e-0d22-7af61dcec427@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, uli+renesas@fpond.eu, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi Rob,

On Sun, Dec 16, 2018 at 3:22 AM Rob Landley <rob@landley.net> wrote:
> On 12/13/18 12:44 PM, Geert Uytterhoeven wrote:
> > When submitting a DMA request fails, the sh-sci driver is supposed to
> > fall back to PIO.  However, this never really worked due to various
> > reasons (sh-sci driver issues and dmaengine framework limitations).
>
> Is it possible to test this under qemu-system-sh4? (Does that emulate the DMA
> controller?)

No, the sh-sci emulation in QEMU is very limited, and does not include DMA.

My patch series does not affect PIO mode, only errors paths in DMA code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
