From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Sep 2013 09:57:12 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <32862238.6GZiWtzlsc@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Tuesday 24 September 2013 17:54:11 Guennadi Liakhovetski wrote:
> Hi Valentine,
> 
> On Tue, 24 Sep 2013, Valentine Barshak wrote:
> > This adds ADV7611/ADV7612 Dual Port Xpressview
> > 225 MHz HDMI Receiver support.
> > 
> > The code is based on the ADV7604 driver, and ADV7612 patch
> > by Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > 
> > Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> 
> IIRC, Laurent is reviewing all new media I2C drivers, I added him to cc.

Actually I only handle sensor drivers. I can of course review other I2C V4L2 
subdevice drivers from time to time :-)

I'll review the patch and send comments.

-- 
Regards,

Laurent Pinchart

