From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 22 May 2010 08:40:25 +0000
Subject: Re: [PATCH 0/4] sh-mobile SCIFB support
Message-Id: <20100522084025.GH17814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org

On Fri, May 21, 2010 at 05:49:02PM +0200, Guennadi Liakhovetski wrote:
> This patch series fixes support for SCIFA ports on sh7372 and adds SCIFB 
> support to sh-sci.c
> 
This series no longer applies, so please give it a respin. Also, to save
me from having to mangle all of the patch subjects, for anything impacted
arch/arm/mach-shmobile we use 'ARM: mach-shmobile:', for sh-sci we use
'serial: sh-sci:', etc, etc. The sh prefixes here are really misleading
since they're either all ARM or serial specific.
