From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2020 08:10:48 +0000
Subject: Re: [PATCH] dt-bindings: serial: sh-sci: Convert to json-schema
Message-Id: <CAMuHMdWTf0ZkbQm-jgiNNTYhxnKfAbomK7mcvDhcMNfCbq8pEg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200306090720.9365-1-geert+renesas@glider.be>
 <20200312200523.GA17854@bogus> <CAMuHMdWoRSE7VQ5o575Ocjfh+y1yH-ciFE1BUqqPVO9oukwgNw@mail.gmail.com>
 <CAL_JsqL5CmL6M_njeHHYA21zs2jTQxENet+q=BJNVuz8K7Jubw@mail.gmail.com>
In-Reply-To: <CAL_JsqL5CmL6M_njeHHYA21zs2jTQxENet+q=BJNVuz8K7Jubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulrich Hecht <uli+renesas@fpond.eu>, Chris Brandt <chris.brandt@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Rob,

On Mon, Mar 23, 2020 at 5:42 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Mar 23, 2020 at 8:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Mar 12, 2020 at 9:05 PM Rob Herring <robh@kernel.org> wrote:
> > > On Fri, Mar 06, 2020 at 10:07:20AM +0100, Geert Uytterhoeven wrote:
> > > > Convert the Renesas Serial Communication Interface ((H)SCI(F)(A|B))
> > > > Device Tree binding documentation to json-schema.
> > > >
> > > > Split the bindings in 5 files, one per major type, to ease expressing
> > > > constraints.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > > > +  interrupts:
> > > > +    description: |
> > > > +      Must contain one or more interrupt-specifiers for the serial interface.
> > > > +      If a single interrupt is expressed, then all events are
> > > > +      multiplexed into this single interrupt.
> > > > +
> > > > +      If multiple interrupts are provided by the hardware, the order
> > > > +      in which the interrupts are listed must match order below. Note
> > > > +      that some HW interrupt events may be muxed together resulting
> > > > +      in duplicate entries.
> > > > +    minItems: 1
> > > > +    maxItems: 6
> > >
> > > This allows 2, 3, 4, or 5 interrupts. Is that valid? If not, then you
> >
> > 1, 4, and 6 are valid.
> >
> > > should do something like this:
> > >
> > > oneOf:
> > >   - items:
> > >       description: A combined interrupt
> > >   - items:
> > >       - description: Error interrupt
> > >       - ...
> >
> > So I tried:
> >
> >   interrupts:
> >     oneOf:
> >       - items:
> >           description: A combined interrupt
>
> You're missing a '-' here.

Thanks, that did the trick!

(Your example above also didn't have the '-', so I though it was special
 syntax for a single-entry ;-)

> >   interrupt-names:
> >     oneOf:
> >       - items:
> >           - const: eri
> >           - const: rxi
> >           - const: txi
> >           - const: tei
> >       - items:
> >           - const: eri
> >           - const: rxi
> >           - const: txi
> >           - const: bri
> >           - const: dri
> >           - const: tei
> >
> > ?
> > Seems to work, but needs the duplication as the 4-interrupt case is not
> > just the 4 first entries of the 6-interrupt case (tei is always last).
>
> Yes, that looks right. No name for the single irq case?

No, initially there were no interrupt-names at all, so interrupt-names is
optional.  The single muxed interrupt variant was the first variant to be
DTified.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
