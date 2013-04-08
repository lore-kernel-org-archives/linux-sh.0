From: Simon Horman <horms@verge.net.au>
Date: Mon, 08 Apr 2013 01:39:02 +0000
Subject: Re: [PATCH 1/2] input: st1232: Add reset pin handling
Message-Id: <20130408013902.GC13103@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Sat, Apr 06, 2013 at 03:18:45PM +0200, Bastian Hecht wrote:
> We add the possiblity to hand over a GPIO number for the reset pin.
> This way we can remove existing board code that takes care of it and
> group this information properly in the platform data or in the device
> tree confguration.
> 
> The implementation is analogous to the cy8ctmg110 driver, thanks.

Laurent, could I get a review from you of this and the following patch?
