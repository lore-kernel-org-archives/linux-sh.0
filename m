From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Aug 2015 23:14:50 +0000
Subject: Re: [PATCH/RFC 10/10] Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for Salvator-X bo
Message-Id: <20150827231446.GD8066@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 01:59:32PM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 27, 2015 at 1:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Thu, Aug 27, 2015 at 06:24:10PM +0900, Simon Horman wrote:
> >> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >>
> >> This is a work-around for limitations in the driver implementation.
> >
> > I know this is marked "local: hack:", still: If this is a driver
> > limitation, shouldn't it rather be in the dtsi then?
> 
> You mean, in the driver?
> 
> DT decribes the hardware, not driver limitations.

Yes indeed, that was my main reason behind labelling it as a local hack.
