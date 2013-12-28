From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 28 Dec 2013 11:48:27 +0000
Subject: Re: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
Message-Id: <1503028.o7PtQzEmGv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <2198668.ESbmzZvna4@avalon>
 <CAMuHMdVH4PyhxR3JLLPX9a3fKaEgdpQpd2aa4YKL6DUD8+Pw2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVH4PyhxR3JLLPX9a3fKaEgdpQpd2aa4YKL6DUD8+Pw2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

On Friday 27 December 2013 20:08:18 Geert Uytterhoeven wrote:
> On Fri, Dec 27, 2013 at 5:20 PM, Laurent Pinchart wrote:
> > On Tuesday 24 December 2013 12:56:50 Geert Uytterhoeven wrote:
> >> Add pinctrl and SPI devices for RSPI on Genmai.
> >> 
> >> On this board, only rspi4 is in use. It's bus contains a single device
> >> (a wm8978 audio codec), for which no bindings are defined yet.
> >> 
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> >> Cc: devicetree@vger.kernel.org
> >> ---
> >> 
> >>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 ++++++++++++++++-
> >>  1 file changed, 17 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> >> b/arch/arm/boot/dts/r7s72100-genmai-reference.dts index
> >> 114510f8bf09..6d99630627e4 100644
> >> --- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> >> +++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> >> @@ -43,7 +43,7 @@
> >>  };
> >>  
> >>  &pfc {
> >> -     pinctrl-0 = <&scif2_pins &ethernet_pins>;
> >> +     pinctrl-0 = <&scif2_pins &ethernet_pins &rspi4_pins>;
> > 
> > You should add pinctrl-0 and pinctrl-names properties to the spi4 node
> > instead. Device nodes should reference their pinctrl configuration
> > directly, scif2 and ethernet are exceptions as DT bindings for those
> > devices are not in mainline yet.
> 
> I put it there because the actual driver doesn't use DT yet. Is that OK?

I had missed that. That's fine, but shouldn't you then delay patch 5/6 until 
the driver gets DT support ?

You've already sent a DT bindings proposal (thanks for that !), wouldn't it 
make sense to implement support in the driver before this patch ? We're pretty 
close to that from what I can see.

-- 
Regards,

Laurent Pinchart

