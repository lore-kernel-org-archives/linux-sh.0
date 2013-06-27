From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Jun 2013 04:48:38 +0000
Subject: Re: [PATCH v5 0/3] R8A7778/BOCK-W R-Car VIN driver support
Message-Id: <20130627044838.GB28229@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201306220326.46176.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306220326.46176.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Jun 22, 2013 at 03:26:45AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130620' tag. Here we add the VIN platform code working on
> the R8A7778/BOCK-W with ML86V7667 video decoder.
> 
> [1/3] ARM: shmobile: r8a7778: add VIN support
> [2/3] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support
> [3/3] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in defconfig
> 
>    The patch containing OKI ML86V7667 video decoder driver has been removed
> from the series as it should be applied to the 'media_tree.git' repo. The patch
> containing the VIN PFC support has been also removed from the series and has
> now been merged.

Hi Sergei,

is this series dependent on that patch or can it be applied independently?

Magnus, Morimoto-san,

could you take some time to review this series?
