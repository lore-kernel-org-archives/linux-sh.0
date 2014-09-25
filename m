From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 25 Sep 2014 13:09:13 +0000
Subject: Re: [PATCH 00/12] Renesas R-Car DU HDMI support
Message-Id: <1411650553.5671.5.camel@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Laurent,

Am Mittwoch, den 24.09.2014, 23:04 +0300 schrieb Laurent Pinchart:
> Hello,
> 
> This patch set adds support for the HDMI output port present on the Renesas
> Koelsch board. Doing so requires two components, a driver for the external
> ADV7511W HDMI encoder, and support for HDMI encoders in the DU driver.
> 
> The HDMI encoder drivers uses the DRM slave encoder framework and the
> component framework to communicate with the DU driver. The DT bindings are
> based on the OF graph bindings to link the display controller and encoder.
> 
> The first two patches have been taken from Philipp Zabel's "[PATCH v3 0/8]
> Add of-graph helpers to loop over endpoints and find ports by id" series.
> Philipp, I don't see that series in linux-next, what's the merge status ?

There is a remaining comment by Guennadi on the soc_camera patch.

regards
Philipp

