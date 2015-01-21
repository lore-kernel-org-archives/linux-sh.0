From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2015 12:50:31 +0000
Subject: Re: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <CAMuHMdXiZxhF5yuBzeQ_4TqyUCpD+UUugMsS+UHdvwQ6q=4bRA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150120113800.11062.65299.sendpatchset@little-apple>
In-Reply-To: <20150120113800.11062.65299.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Jan 21, 2015 at 10:25 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jan 21, 2015 at 09:57:43AM +0100, Geert Uytterhoeven wrote:
>> On Wed, Jan 21, 2015 at 12:50 AM, Simon Horman <horms@verge.net.au> wrot=
e:
>> > My na=C3=AFve guess is that the GIC setup for the r8a73a4 is somehow
>> > more complex or than calling gic_init() and that this is reflected
>> > in its DT - which seems more complex than for the r8a77{40,98,99} which
>> > we have been fixed in a manner very close to the patch you propose her=
e.
>>
>> According to the bindings, the extra 2 reg property ranges are for the
>> virtualization extensions, which we don't use.
>
> Thanks, now there is one less mystery in my life.
>
> Perhaps we could tidy up the dts file to remove bits that are unused?
> Or are they used when booting using DT?

I don't know. But given they're in the binding docs, I'd keep them,
unless they're incorrect.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
