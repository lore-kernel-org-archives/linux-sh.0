From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 04 Mar 2015 21:54:09 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Cleanup for v4.1
Message-Id: <9266543.XzoOMM56Nv@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424931049.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424931049.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 26 February 2015 15:22:32 Simon Horman wrote:
> ----------------------------------------------------------------
> Renesas ARM Based SoC Cleanup for v4.1
> 
> * Remove redundant cpu_disable implementation from r8a7779 SoC
> * Remove mach/{uncompress,clkdev,system}.h
> 

We have a lot of work for multiplatform this time, with your changes,
at91 and the patches I send over the last week. I've decided to
create a next/multiplatform branch for this, and merge your patches
into that one.

	Arnd
