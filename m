From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 May 2018 12:38:01 +0000
Subject: Re: [PATCH] media: arch: sh: migor: Fix TW9910 PDN gpio
Message-Id: <14986389.IZxnRVqLam@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1527671604-18768-1-git-send-email-jacopo+renesas@jmondi.org> <2981239.tGoCg7U0XF@avalon> <20180530122343.GA10472@w540>
In-Reply-To: <20180530122343.GA10472@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jacopo mondi <jacopo@jmondi.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Hans Verkuil <hans.verkuil@cisco.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Jacopo,

On Wednesday, 30 May 2018 15:23:43 EEST jacopo mondi wrote:
> On Wed, May 30, 2018 at 02:52:31PM +0300, Laurent Pinchart wrote:
> > On Wednesday, 30 May 2018 12:30:49 EEST Geert Uytterhoeven wrote:
> >> On Wed, May 30, 2018 at 11:13 AM, Jacopo Mondi wrote:
> >>> The TW9910 PDN gpio (power down) is listed as active high in the chip
> >>> manual. It turns out it is actually active low as when set to physical
> >>> level 0 it actually turns the video decoder power off.
> >> 
> >> So the picture "Typical TW9910 External Circuitry" in the datasheet,
> >> which ties PDN to GND permanently, is wrong?
> 
> Also the definition of PDN pin in TW9910 manual, as reported by Laurent made
> me think the pin had to stay in logical state 1 to have the chip powered
> down. That's why my initial 'ACTIVE_HIGH' flag. The chip was not
> recognized, but I thought it was a local problem of the Migo-R board I
> was using.
> 
> Then one day I tried inverting the pin active state just to be sure,
> and it started being fully operational :/
> 
> > The SH PTT2 line is connected directory to the TW9910 PDN signal, without
> > any inverter on the board. The PDN signal is clearly documented as
> > active-high in the TW9910 datasheet. Something is thus weird.
> 
> I suspect the 'active high' definition in datasheet is different from
> our understanding. Their 'active' means the chip is operational, which
> is not what one would expect from a powerdown pin.
> 
> > Jacopo, is it possible to measure the PDN signal on the board as close as
> > possible to the TW9910 to see if it works as expected ?
> 
> Not for me. The board is in Japan and my multimeter doesn't have cables
> that long, unfortunately.

How about trying that during your next trip to Japan ? :-)

-- 
Regards,

Laurent Pinchart



