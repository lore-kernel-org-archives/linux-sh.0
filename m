From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Oct 2015 11:12:03 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <1917001.aD8sIkvx7f@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de> <131418014.1WnDGNUZcn@avalon> <20151022110505.GB1572@katana>
In-Reply-To: <20151022110505.GB1572@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Wolfram,

On Thursday 22 October 2015 13:05:05 Wolfram Sang wrote:
> On Thu, Oct 22, 2015 at 02:10:52AM +0300, Laurent Pinchart wrote:
> > On Thursday 03 September 2015 22:20:09 Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > 
> > > Setting up new messages was done in process context while handling a
> > > message was in interrupt context. Because of the HW design, this IP core
> > > is sensitive to timing, so the context switches were too expensive. Move
> > > this setup to interrupt context as well.
> > > 
> > > In my test setup, this fixed the occasional 'data byte sent twice' issue
> > > which a number of people have seen. It also fixes to send REP_START
> > > after a read message which was wrongly send as a STOP + START sequence
> > > before.
> > 
> > I'm afraid this patch has been found by git bisect to break HDMI on
> > Koelsch
> > 
> > :-(
> > 
> > The regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val) call in
> > drivers/gpu/drm/i2c/adv7511.c returns -ENXIO.
> > 
> > Reverting the patch on top of Geert's current drivers master branch fixes
> > the problem.
> 
> But HDMI worked on Koelsch in Dublin??

I know :-)

Do you have a Koelsch board now ? Could you try 
b9653e9c000dc2ebd9c8712442c659ccd1586e22 from Geert's drivers tree ? On my 
board the adv7511 fails to probe completely due to the regmap_read() failure.

-- 
Regards,

Laurent Pinchart

