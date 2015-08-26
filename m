From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Aug 2015 23:31:41 +0000
Subject: Re: [PATCH v2] clk: shmobile: Get rid of CONFIG_SHMOBILE_MULTI
Message-Id: <20150826233139.GB22263@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150826074309.4298.76147.sendpatchset@little-apple>
 <CAMuHMdVXJ8Te_Rwn2WZCdXdh_+0__S6QEp7ZBzggpY-UgqtqLA@mail.gmail.com>
 <CANqRtoS-OvQKQZE1-wEnweeZaNqXVtQb3atJ1Fy+D1=Tt-b=XQ@mail.gmail.com>
In-Reply-To: <CANqRtoS-OvQKQZE1-wEnweeZaNqXVtQb3atJ1Fy+D1=Tt-b=XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Aug 26, 2015 at 04:56:47PM +0900, Magnus Damm wrote:
> Hi Geert,
> 
> On Wed, Aug 26, 2015 at 4:48 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Aug 26, 2015 at 9:43 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >>
> >> Shmobile is all multiplatform these days, so get rid of the
> >> reference to CONFIG_ARCH_SHMOBILE_MULTI. Also instead of always
> >> enabling DIV6 and MSTP adjust the Makefile to enable DIV6 and
> >> MSTP depending on if they are included in the SoC or not.
> >>
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >>
> >>  Changes since V1:
> >>  - dropped DIV6 from R-Car Gen1 variants - thanks Geert!
> >
> > BTW, you forgot to mention, but it's important for Mike and Stephen to
> > know that this should not be queued up in a branch that still has
> > ARCH_SHMOBILE_LEGACY.
> 
> Right, we need to sync with the mach-shmobile integration merge order
> with stuff from Simon. I believe the remaining legacy cleanups are
> targeted for v4.4. So merging this in v4.4 or later would be good.

Yes, the remaining legacy cleanups are queued up in my renesas tree for
v4.4.
