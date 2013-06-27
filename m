From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Jun 2013 04:45:16 +0000
Subject: Re: [PATCH 0/4] Add DVFS support on APE6EVM
Message-Id: <20130627044516.GA28229@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 21, 2013 at 09:10:34AM +0200, Guennadi Liakhovetski wrote:
> Having added CPUFreq support to the Cortex A15 cores on APE6 (r8a73a4) and 
> DT support to the max8973 regulator driver it is now possible to implement 
> CA15 CPUFreq support on APE6EVM, using a max8972 PMU to adjust SoC's DVFS
> voltage. This series depends on earlier
> 
> "ARM: shmobile: r8a73a4: wait for completion when kicking the clock"
> https://patchwork.kernel.org/patch/2601071/
> "ARM: shmobile: r8a73a4: implement CPU clock scaling for CPUFreq"
> https://patchwork.kernel.org/patch/2601111/
> 
> and requires the following max8973 patches:
> 
> "regulators: max8973: fix multiple instance support"
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg456101.html
> "regulators: max8973: initial DT support"
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg456102.html
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Magnus, Morimoto-san,

could you take some time to review this?
