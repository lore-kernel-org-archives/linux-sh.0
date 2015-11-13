From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Nov 2015 00:28:21 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Move SPI FLASH partitions to subnode
Message-Id: <20151113002820.GE20462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447144506-20336-1-git-send-email-geert+renesas@glider.be>
 <20151112011522.GB19649@verge.net.au>
 <CAMuHMdVaBXSNnf5k3Sxx=bz8CscsE85PozgBH82yXa3HBXC1sg@mail.gmail.com>
In-Reply-To: <CAMuHMdVaBXSNnf5k3Sxx=bz8CscsE85PozgBH82yXa3HBXC1sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mtd@vger.kernel.org

On Thu, Nov 12, 2015 at 11:03:33AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Nov 12, 2015 at 2:15 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Nov 10, 2015 at 09:35:06AM +0100, Geert Uytterhoeven wrote:
> >> As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
> >> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
> >> partitions in a special 'partitions' subnode"), having partitions as
> >> direct subnodes of an mtd device is discouraged:
> >>
> >>     spi0.0: 'partitions' subnode not found on /spi@e6b10000/flash@0. Trying to parse direct subnodes as partitions.
> >
> > I seem to see something else, perhaps I have a hardware problem?
> >
> >      m25p80 spi0.0: unrecognized JEDEC id bytes: 01,  2, 20
> 
> That indeed means QSPI doesn't work. Is it reproducible?
> Is this on Koelsch?

Yes. It appears to happy reliably in my Koelsch.

> 
> >> Hence move the SPI FLASH partitions to a "partitions" subnode.
> >
> > Thanks, I will queue this up.
> >
> > I assume we also need this for other boards with flash nodes
> > in mainline: bockw, lager, porter, silk.
> 
> Indeed. I converted Koelsch only to see if it works, and as a reminder for
> the other boards. But as you added more deprecated usage, I sent out what
> I had.
> 
> > I'm happy to prepare patches to do that if you want to pass.
> 
> Feel free to convert the other boards if you have time. Thanks!

Sure, will do.
