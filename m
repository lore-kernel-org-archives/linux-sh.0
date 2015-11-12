From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2015 10:03:33 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Move SPI FLASH partitions to subnode
Message-Id: <CAMuHMdVaBXSNnf5k3Sxx=bz8CscsE85PozgBH82yXa3HBXC1sg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447144506-20336-1-git-send-email-geert+renesas@glider.be>
	<20151112011522.GB19649@verge.net.au>
In-Reply-To: <20151112011522.GB19649-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mtd-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Simon,

On Thu, Nov 12, 2015 at 2:15 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Nov 10, 2015 at 09:35:06AM +0100, Geert Uytterhoeven wrote:
>> As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
>> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
>> partitions in a special 'partitions' subnode"), having partitions as
>> direct subnodes of an mtd device is discouraged:
>>
>>     spi0.0: 'partitions' subnode not found on /spi@e6b10000/flash@0. Trying to parse direct subnodes as partitions.
>
> I seem to see something else, perhaps I have a hardware problem?
>
>      m25p80 spi0.0: unrecognized JEDEC id bytes: 01,  2, 20

That indeed means QSPI doesn't work. Is it reproducible?
Is this on Koelsch?

>> Hence move the SPI FLASH partitions to a "partitions" subnode.
>
> Thanks, I will queue this up.
>
> I assume we also need this for other boards with flash nodes
> in mainline: bockw, lager, porter, silk.

Indeed. I converted Koelsch only to see if it works, and as a reminder for
the other boards. But as you added more deprecated usage, I sent out what
I had.

> I'm happy to prepare patches to do that if you want to pass.

Feel free to convert the other boards if you have time. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
