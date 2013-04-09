From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 08:28:33 +0000
Subject: Re: [PATCH v2 1/2] input: st1232: Add reset pin handling
Message-Id: <20130409082833.GE18478@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
 <2096590.pSU6Gke5Ke@avalon>
In-Reply-To: <2096590.pSU6Gke5Ke@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Mon, Apr 08, 2013 at 04:17:20PM +0200, Laurent Pinchart wrote:
> Hi Bastian,
> 
> Thanks for the patch.
> 
> On Monday 08 April 2013 14:52:26 Bastian Hecht wrote:
> > We add the possiblity to hand over a GPIO number for the reset pin.
> > This way we can remove existing board code that takes care of it and
> > group this information properly in the platform data or in the device
> > tree confguration.
> > 
> > The implementation is analogous to the cy8ctmg110 driver, thanks.
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Bastian, I'm unclear on which tree this will go through.
Please let me know if it is mine.
