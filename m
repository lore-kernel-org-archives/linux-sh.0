From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Nov 2015 00:14:52 +0000
Subject: Re: [PATCH 01/02] ARM: shmobile: r8a7793: Add DU node to device tree
Message-Id: <20151125001451.GD20596@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151116091523.20711.53542.sendpatchset@little-apple>
In-Reply-To: <20151116091523.20711.53542.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 16, 2015 at 06:15:23PM +0900, Magnus Damm wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Add the DU device with a disabled state. Boards that want to enable the
> DU need to specify the output topology.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up for v4.5.
