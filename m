From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Mar 2011 04:51:28 +0000
Subject: Re: [PATCH] sh: intc: fix build error in interrupts.h
Message-Id: <20110330045124.GA19997@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4D928B6A.0@renesas.com>
In-Reply-To: <4D928B6A.0@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 30, 2011 at 10:47:49AM +0900, Paul Mundt wrote:
> On Wed, Mar 30, 2011 at 10:46:18AM +0900, Yoshihiro Shimoda wrote:
> > Fix the problem that name of some functions changed.
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Thomas already caught this, so it should be resolved soon.

FWIW, thanks for pointing me towards this patch.
It fixed a build problem I was seeing when building 2.6.39-rc1
for mackerel.

Drive-by Tested-by: Simon Horman <horms@verge.net.au>

