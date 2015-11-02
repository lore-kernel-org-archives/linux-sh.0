From: Simon Horman <horms@verge.net.au>
Date: Mon, 02 Nov 2015 02:14:02 +0000
Subject: Re: [PATCH] arm64: renesas: salvator-x: Setup ethernet0 alias for U-Boot
Message-Id: <20151102021401.GE11188@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446197120-4640-1-git-send-email-geert+renesas@glider.be>
 <5186464.J3dvUFu6c7@avalon>
 <CAMuHMdXUyL=v2wv8-zfOi0bH6fbs5bnHvDKE2yeaAi-6Ltz1Vg@mail.gmail.com>
 <7457617.F4Cc6TXnNy@avalon>
In-Reply-To: <7457617.F4Cc6TXnNy@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Oct 30, 2015 at 03:37:26PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> On Friday 30 October 2015 14:16:03 Geert Uytterhoeven wrote:
> > On Fri, Oct 30, 2015 at 2:06 PM, Laurent Pinchart wrote:
> > > On Friday 30 October 2015 10:25:20 Geert Uytterhoeven wrote:
> > >> Add an ethernet0 alias for the wired network card so that U-Boot can
> > >> find the device-node and add an appropriate "local-mac-address"
> > >> property.
> > > 
> > > I like that :-) Can U-Boot add the property ? I thought it needed a
> > > placeholder.
> > 
> > At least for Salvator-X it does. See also the thread at
> > http://www.spinics.net/lists/arm-kernel/msg456841.html
> 
> Cool :-)
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I will include this in the next spin of the ravb integration
patches for r8a7795/salvator-x.
