From: Simon Horman <horms@verge.net.au>
Date: Wed, 06 Jan 2016 21:29:58 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7793: move dmac nodes
Message-Id: <20160106212955.GA9953@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1451945741-17373-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1451945741-17373-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 05, 2016 at 09:15:41AM +1100, Simon Horman wrote:
> Move dmac nodes in the r8a7793 device tree to match their location
> in the r8a7791 device tree to aid comparison between the device
> trees of these similar SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> * This was the intention when the dmac nodes where added but
>   somehow something went astray.

I have queued this up.
