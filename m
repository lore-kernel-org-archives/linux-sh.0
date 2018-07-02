From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Jul 2018 09:50:47 +0000
Subject: Re: [PATCH 4/4] serial: sh-sci: Stop RX FIFO timer during port shutdown
Message-Id: <CAMuHMdUu5Kgq6B3pE8SovP6Kv=gpWF7g8qSFTs2d0hoNo3TrEg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-8-geert+renesas@glider.be>
In-Reply-To: <20180629142513.20743-8-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rob,

On Sun, Jul 1, 2018 at 7:27 PM Rob Landley <rob@landley.net> wrote:
> On 06/29/2018 09:25 AM, Geert Uytterhoeven wrote:
> > The RX FIFO timer may be armed when the port is shut down, hence the
> > timer function may still be called afterwards.
> >
> > Fix this race condition by deleting the timer during port shutdown.
>
> Will any of this make the qemu-system-sh4 serial console work again?

Probably not, as none of these patches touch the qemu source tree.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
