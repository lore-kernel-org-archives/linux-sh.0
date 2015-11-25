From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Nov 2015 01:08:52 +0000
Subject: Re: Rcar Gen2: DU: Bootlogs Error and show image error
Message-Id: <3453972.RAU3IWxHYj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <564ECE30.9000206@jinso.co.jp>
In-Reply-To: <564ECE30.9000206@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, and sorry for the late reply.

On Friday 20 November 2015 16:39:28 Cao Minh Hiep wrote:
> Hi Laurent-san
> 
> Thanks for your kindness support!
> I don't mean to bother you!

You're not bothering me at all :-)

> But as you know, we have reported to you before, have some problems
> related to DU driver.
> We couldn't show a image on the display. We found the messages as showed
> below:
> -----
> Boot logs on Rcar-H2:
> rcar-du feb00000.display: failed to initialize encoder
> /i2c@e6520000/hdmi@39 (-38), skipping
> rcar-du feb00000.display: fb0:  frame buffer device
> -----
> Boot logs on Rcar-M2:
> rcar-du feb00000.display: failed to initialize encoder
> /i2c@e6530000/hdmi@39 (-g
> rcar-du feb00000.display: error: no encoder could be initialized
> rcar-du feb00000.display: failed to initialize DRM/KMS (-22)
> rcar-du: probe of feb00000.display failed with error -22
> -----
> 
> This is tested on linux stable v4.3.
> Please have a look when you have time.

Have you enabled CONFIG_DRM_RCAR_HDMI ?

-- 
Regards,

Laurent Pinchart


