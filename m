From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Aug 2013 08:35:55 +0000
Subject: Re: [PATCH 02/02] ARM: shmobile: Per-CPU SMP boot / sleep code for SCU SoCs
Message-Id: <20130805083553.GC13274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130731183808.31551.47235.sendpatchset@w520>
 <20130731183827.31551.83583.sendpatchset@w520>
In-Reply-To: <20130731183827.31551.83583.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 01, 2013 at 03:38:27AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook in the per-CPU boot and sleep code in the shared
> mach-shmobile SCU code. CPUs may be kept in the asm
> routine until ->boot_secondary() when the per-CPU
> boot vector is installed. At the end of ->die() the
> asm sleep routine is invoked.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the smp branch.
