From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Nov 2015 00:36:32 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: koelsch: Fix pinmux for HDMI
Message-Id: <20151125003631.GK20596@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448409665-30811-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1448409665-30811-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 25, 2015 at 02:01:05AM +0200, Laurent Pinchart wrote:
> The signals output by the DU to the HDMI transmitter use full 24-bit
> RGB. Make sure all pins are properly muxed.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
