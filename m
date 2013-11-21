From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 04:38:48 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: sh73a0: fixup sdhi compatible name
Message-Id: <20131121043846.GQ31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjoz92xd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjoz92xd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 08:32:16PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > On Tue, Nov 19, 2013 at 07:18:09PM -0800, Kuninori Morimoto wrote:
> > > sh73a0 != r8a7740
> > > 
> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Thanks, I will queue this up.
> > Assuming all goes will I plan to push this and other updates
> > today or tomorrow.
> > 
> > Can you confirm that at this time there is no run-time
> > affect of this change?
> 
> Thank you.
> It should be OK, since sh_mobile_sdhi driver is using
> same value for renesas,sdhi-r8a7740/sh73a0.

Thanks.
