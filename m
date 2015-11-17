From: Simon Horman <horms@verge.net.au>
Date: Tue, 17 Nov 2015 17:46:14 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Move SPI FLASH partitions to subnode
Message-Id: <20151117174613.GH23979@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447144506-20336-1-git-send-email-geert+renesas@glider.be>
 <20151112011522.GB19649@verge.net.au>
 <CAMuHMdVaBXSNnf5k3Sxx=bz8CscsE85PozgBH82yXa3HBXC1sg@mail.gmail.com>
 <20151113002820.GE20462@verge.net.au>
 <CAMuHMdW4jOYJJvk8RX+uZRhsa=eT3hg+by_3rbKP96M1mrLjPQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW4jOYJJvk8RX+uZRhsa=eT3hg+by_3rbKP96M1mrLjPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mtd@vger.kernel.org

On Fri, Nov 13, 2015 at 08:56:18AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Nov 13, 2015 at 1:28 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Nov 12, 2015 at 11:03:33AM +0100, Geert Uytterhoeven wrote:
> >> On Thu, Nov 12, 2015 at 2:15 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Tue, Nov 10, 2015 at 09:35:06AM +0100, Geert Uytterhoeven wrote:
> >> >> As of commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
> >> >> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
> >> >> partitions in a special 'partitions' subnode"), having partitions as
> >> >> direct subnodes of an mtd device is discouraged:
> >> >>
> >> >>     spi0.0: 'partitions' subnode not found on /spi@e6b10000/flash@0. Trying to parse direct subnodes as partitions.
> >> >
> >> > I seem to see something else, perhaps I have a hardware problem?
> >> >
> >> >      m25p80 spi0.0: unrecognized JEDEC id bytes: 01,  2, 20
> >>
> >> That indeed means QSPI doesn't work. Is it reproducible?
> >> Is this on Koelsch?
> >
> > Yes. It appears to happy reliably in my Koelsch.
> 
> Which tree / config?
> 
> I've just tried renesas-devel-20151113-v4.3 and topic/gen3-latest with
> shmobile_defconfig, and the QSPI flash was detected correctly on both (the
> former failed to parse partitions, as the code for the partitions subnode is
> not yet in v4.3).

* I am able to reproduce the "unrecognized JDEC id" problem on my Koelsch board
  using renesas-devel-20151113-v4.3 with shmobile_defconfig.

* I also noticed the partitions problem (on the gose board).
  Perhaps I should have held off on applying the patches in question.
  But the appears to be resolved now that the branch
  with the patch in question has been rebased on top of v4.4-rc1.
