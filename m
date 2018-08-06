From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Aug 2018 14:34:34 +0000
Subject: Re: [PATCH/RFC 3/4] Revert "serial: sh-sci: Compute the regshift value for SCI ports"
Message-Id: <CAMuHMdVMToQsVpUzqnSC-OscNnNfoyOSt47S9Eset3hNPwxtWg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
 <20180806140755.24087-4-geert+renesas@glider.be> <2848864.ufBBija138@avalon>
In-Reply-To: <2848864.ufBBija138@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Chris Brandt <chris.brandt@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, uli@fpond.eu, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi Laurent,

On Mon, Aug 6, 2018 at 4:16 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday, 6 August 2018 17:07:54 EEST Geert Uytterhoeven wrote:
> > This reverts commit dfc80387aefb78161f83732804c6d01c89c24595.
> >
> > Deriving the proper regshift value from the register block size is
> > fragile, as it may have been rounded up.
> >
> > Furthermore we will need plat_sci_port.regshift again.
>
> Won't this break bisection ? Shouldn't you squash patches 3 and 4 together ?
>
> Does this mechanism break anything on non-DT platforms ? If not I'd rather
> keep it for them, and only use compat strings for DT platforms, to avoiding
> adding back a platform data field.

Actually I think the original commit broke SCI on H8/300, as regshift should be
zero on that platform.
But that was not discovered until recently.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
