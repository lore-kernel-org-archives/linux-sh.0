From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Aug 2011 07:38:16 +0000
Subject: Re: [PATCH] mmc: sdhi, mmcif: zboot: Correct clock disable logic
Message-Id: <20110808073816.GH32513@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1312351734-4426-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1312351734-4426-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 03, 2011 at 03:08:54PM +0900, Simon Horman wrote:
> This corrects a logic-error that I made in the original implementation.
> 
> An alternate patch would be to just remove these lines and
> leave the clock running as it is reconfigured later on during
> boot anyway.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

Applied, thanks.
