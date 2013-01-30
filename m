From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Jan 2013 04:23:57 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: set clock rates before timer init
Message-Id: <20130130042357.GL28230@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1358485325-19673-1-git-send-email-hdk@igel.co.jp>
In-Reply-To: <1358485325-19673-1-git-send-email-hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 18, 2013 at 02:02:05PM +0900, Hideki EIRAKU wrote:
> Previously clock rates were set after initialization of timer.
> Therefore the timer used the default extal1 clock rate (25MHz)
> instead of the correct rate for this board (24MHz).
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>

Thanks, I have applied this to the boards2 branch
and will merge it into the next branch.
