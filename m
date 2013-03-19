From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Mar 2013 00:26:53 +0000
Subject: Re: [PATCH 00/02] sh-pfc: Initial r8a73a4 PFC support
Message-Id: <20130319002651.GA15718@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130318145029.26761.15477.sendpatchset@w520>
In-Reply-To: <20130318145029.26761.15477.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 18, 2013 at 11:50:29PM +0900, Magnus Damm wrote:
> sh-pfc: Initial r8a73a4 PFC support
> 
> [PATCH 01/02] sh-pfc: Add r8a73a4 pinmux support
> [PATCH 02/02] sh-pfc: Add r8a73a4 GPIO IRQ support
> 
> This series is V1 of initial PFC support for the r8a73a4 SoC.
> Nothing out of the ordinary, just similar but different tables
> to describe the pinmux hardware and GPIOs on r8a73a4.
> 
> The header in the mach directory is still used, and in the future
> this will be removed when fully using PINCTRL. Until then a common
> location is needed so this series simply follows what other SoCs
> do. Because of this there is a dependency on the r8a73a4 SoC code.

Laurent, could you review these and either give me some Acks or
a branch to pull? I assume the base should be the renesas-pinmux-for-v3.10 tag
in the renesas tree.

Thanks.
