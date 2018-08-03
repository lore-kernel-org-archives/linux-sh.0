From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 03 Aug 2018 11:13:00 +0000
Subject: Re: [PATCH 4/4] serial: sh-sci: Stop RX FIFO timer during port shutdown
Message-Id: <CAMuHMdUxS6=zkWLh30vz8o2YtjS43bt6CssW09yq+S62G77gmQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-1-geert+renesas@glider.be>
 <20180629142513.20743-8-geert+renesas@glider.be> <c3d1884b-baab-241d-e4ee-745ed87dbb3b@landley.net>
 <CAMuHMdUu5Kgq6B3pE8SovP6Kv=gpWF7g8qSFTs2d0hoNo3TrEg@mail.gmail.com> <b5e03d7d-d7d5-4e31-5d9a-036521f30ff5@landley.net>
In-Reply-To: <b5e03d7d-d7d5-4e31-5d9a-036521f30ff5@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Jul 2, 2018 at 9:01 PM Rob Landley <rob@landley.net> wrote:
> On 07/02/2018 04:50 AM, Geert Uytterhoeven wrote:
> > On Sun, Jul 1, 2018 at 7:27 PM Rob Landley <rob@landley.net> wrote:
> >> On 06/29/2018 09:25 AM, Geert Uytterhoeven wrote:
> >>> The RX FIFO timer may be armed when the port is shut down, hence the
> >>> timer function may still be called afterwards.
> >>>
> >>> Fix this race condition by deleting the timer during port shutdown.
> >>
> >> Will any of this make the qemu-system-sh4 serial console work again?
> >
> > Probably not, as none of these patches touch the qemu source tree.
>
> So we remain well into the second year of each project pointing the finger at
> the other on this, and nothing getting fixed. And the workaround remains "run a
> kernel from before February 2017 if you want a working serial console under qemu.
>
> Good to know,

FTR, patch for qemu is "hw/char/sh_serial: Add timeout handling to unbreak
serial input"
(http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg05579.html)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
