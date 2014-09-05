From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Sep 2014 16:20:45 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Cleanup Updates for v3.18
Message-Id: <201409051820.45791.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408670789.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408670789.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Saturday 23 August 2014, Simon Horman wrote:
> Please consider these Renesas ARM based SoC cleanup updates for v3.18.
> 
> This pull request is based on
> "Renesas ARM Based SoC DT Timers Updates for v3.18",
> tagged as dt-timers-for-v3.18,
> which I have already sent a pull-request for.
> 
> This is a rebase of changes that didn't quite make it into v3.17.
> These cleanups depend on changes in dt-timers-for-v3.18 and rebasing
> to remove that dependency is not entirely trivial.
> 


I hesitated a bit for this one and the dt-timers-for-v3.18 branch, as they
don't really fit into our scheme, and I'd much prefer having the cleanups
done first, while everything else isn't that important.

In the end, I stuck it all into next/soc.

That's the last one of the outstanding shmobile pull requests that I'm
aware of. Again, sorry for taking my time with them. Please check that
I didn't miss anything you wanted me to pull.

Thanks,

	Arnd
