From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 23:56:05 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: bockw: add SMSC support on DT
Message-Id: <20131003235602.GB29457@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87txh0yzbj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txh0yzbj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 04, 2013 at 12:21:08AM +0200, Sergei Shtylyov wrote:
> Hello.
> 
> On 02-10-2013 8:14, Kuninori Morimoto wrote:
> 
> >This patch enables SMSC on BockW board via DT.
> >SMSC interrupt is connected to FPGA, and is connected
> >to IRQ0 on BockW.
> >This patch enabled INTC IRQ too
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >---
> >  arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   27 +++++++++++++++++++++++-
> >  arch/arm/mach-shmobile/board-bockw-reference.c |   20 ++++++++++++++++++
> >  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> >diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> >index 9bb903a..4425fd2 100644
> >--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> >+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> >@@ -22,11 +22,36 @@
> [...]
> >+	lan0@18300000 {
> 
>    According to the ePAPR spec, the node name should be "ethernet", not "lan0".
> 
> WBR, Sergei

Morimoto-san, Sergei,

could one of you send a follow-up patch to fix this?
