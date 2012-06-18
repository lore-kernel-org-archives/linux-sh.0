From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jun 2012 02:11:51 +0000
Subject: Re: [PATCH 2/6] misc: Add Renesas Mobile TPU PWM driver
Message-Id: <20120618021151.GC17850@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1339773427-29508-3-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339773427-29508-3-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 15, 2012 at 05:17:03PM +0200, Laurent Pinchart wrote:
> The Timer Pulse Unit (TPU is a 4-channels 16-bit timer used to generate
> waveforms. This driver exposes PWM functions through the PWM API for
> other drivers to use.
> 
> The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
> and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.
> 

Tested-by: Simon Horman <horms@verge.net.au>

> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
