From: Simon Horman <horms@verge.net.au>
Date: Mon, 30 Sep 2013 00:47:33 +0000
Subject: Re: [PATCH 0/2] Add CAN0 support for R8A7778/BOCK-W board
Message-Id: <20130930004733.GA30501@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201309280441.52414.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201309280441.52414.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Sep 28, 2013 at 04:41:51AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20130927v2' tag. Here we add the CAN0 controller support working
> on the R8A7778/BOCK-W board. The patchset requires the 'rcar_can' driver and 
> R8A7778 PFC patch posted earlier in order to compile and/or work.

Thanks, got it. At the very least I will have to wait
for the driver to be merged before taking these patches.

> 
> [1/2] ARM: shmobile: r8a7778: add CAN clock support
> [2/2] ARM: shmobile: BOCK-W: add CAN0 support
> 
>    Unfortunately, the use of CAN is much hindered by the fact that the CAN0
> signals use the BOCK-W's product serial port and CAN1 pins are not connected.

Morimoto-san, do you have any thoughts on this?
