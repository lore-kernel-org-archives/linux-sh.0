From: Simon Horman <horms@verge.net.au>
Date: Sun, 06 Jul 2014 14:33:27 +0000
Subject: Re: [PATCH v2 0/2] Add R8A7791/Henninger board CAN DT support
Message-Id: <20140706143327.GJ3750@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201407032337.03509.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407032337.03509.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 03, 2014 at 11:37:02PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-v3.16-rc3-20140701' tag. Here we add the CAN device tree support
> for the R8A7791-based Henninger board. It depends on the PFC CAN support and
> R-Car CAN device tree support patches posted recently in order to work.

Thanks, please repost these patches once the bindings have been merged.

> 
> [1/2] ARM: shmobile: r8a7791: add CAN DT support
> [2/2] ARM: shmobile: henninger: add CAN0 DT support
> 
> WBR, Sergei
> 
