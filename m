From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Nov 2014 00:36:56 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7791: Correct number of CPU cores
Message-Id: <20141105003656.GC2017@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 24, 2014 at 05:33:07PM +0900, Simon Horman wrote:
> Hi,
> 
> this short series separates AMPU resource data as it is not
> common accross R-Car gen2 SoCs: only the r8a7790 (H1) has the resouces
> described. It then corrects the resource data for the r8a7791,
> the only other SoC currently present in mainline that uses this data.
> 
> Based on the renesas-next-20141024-v3.18-rc1 tag of my renesas tree.
> 
> Hisashi Nakamura (2):
>   ARM: shmobile: Separate APMU resource data into CPU dependant part
>   ARM: shmobile: r8a7791: Correct number of CPU cores

I have queued up this series.
