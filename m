From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 11 Feb 2015 01:39:53 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Fix uninitialized variable usage
Message-Id: <20150211012753.GH21387@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420734565-23815-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1420734565-23815-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 08, 2015 at 06:29:25PM +0200, Laurent Pinchart wrote:
> The desc variable is used uninitialized in the rcar_dmac_desc_get() and
> rcar_dmac_xfer_chunk_get() functions if descriptors need to be
> allocated. Fix it.
Applied, thanks

-- 
~Vinod

