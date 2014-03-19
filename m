From: Simon Horman <horms@verge.net.au>
Date: Wed, 19 Mar 2014 00:07:56 +0000
Subject: Re: [PATCH] ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
Message-Id: <20140319000753.GE14494@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140318125247.21670.94176.sendpatchset@w520>
In-Reply-To: <20140318125247.21670.94176.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 18, 2014 at 09:52:47PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add MMCIF1, SDHI0 and SDHI2 to the clock workaround list for
> Lager multiplatform. Without these additional lines wakeup
> from Suspend-to-RAM never happens.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up under the assumption that
a proper fix will be coming at some point.
