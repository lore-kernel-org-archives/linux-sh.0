From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 12 Dec 2013 18:12:55 +0000
Subject: Re: [PATCH] ARM: shmobile: Add select MIGHT_HAVE_PCI for PCI-AHB bridge code
Message-Id: <52A9FCA7.2090709@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1386870969-22241-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1386870969-22241-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/12/13 18:11, Ben Dooks wrote:
> The PCI sub-system is not enabled by default on ARM and on certain
> Renesas devices the build does not select it. This means that there
> are configurations that do not allow the AHB-PCI bridge used for the
> USB sub-systems to be built.
>
> For the R8A7790, R8A7791 and EMEV-2 select MIGHT_HAVE_PCI to allow the
> PCI drivers to be built. Also select MIGHT_HAVE_PCI for the multi-config
> where there may be many Reneasas devices selected.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> CC: Linux SH List <linux-sh@vger.kernel.org>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Argh, sorry did not remove the extra Kconfig entry.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
