From: Simon Horman <horms@verge.net.au>
Date: Sat, 14 Dec 2013 01:46:41 +0000
Subject: Re: [PATCH] ARM: shmobile: Add select MIGHT_HAVE_PCI for PCI-AHB bridge code
Message-Id: <20131214014641.GB8487@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386870969-22241-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1386870969-22241-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 12, 2013 at 06:14:21PM +0000, Ben Dooks wrote:
> The PCI sub-system is not enabled by default on ARM and on certain
> Renesas devices the build does not select it. This means that there
> are configurations that do not allow the AHB-PCI bridge used for the
> USB sub-systems to be built.
> 
> For the R8A7790, R8A7791 and EMEV-2 select MIGHT_HAVE_PCI to allow the
> PCI drivers to be built. Also select MIGHT_HAVE_PCI for the multi-config
> where there may be many Reneasas devices selected.

Thanks, I will queue this up.
