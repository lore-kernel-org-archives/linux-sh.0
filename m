From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jun 2008 04:03:29 +0000
Subject: Re: [2.6 patch] sh: export get_cpu_subtype
Message-Id: <20080624040329.GC22526@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080618003650.GO25911@cs181133002.pp.htv.fi> <20080617223340.GN25911@cs181133002.pp.htv.fi> <20080617223103.GL25911@cs181133002.pp.htv.fi> <20080617223057.GK25911@cs181133002.pp.htv.fi> <20080617223053.GJ25911@cs181133002.pp.htv.fi> <20080617223040.GI25911@cs181133002.pp.htv.fi> <20080617223023.GH25911@cs181133002.pp.htv.fi>
In-Reply-To: <20080618003650.GO25911@cs181133002.pp.htv.fi> <20080617223340.GN25911@cs181133002.pp.htv.fi> <20080617223103.GL25911@cs181133002.pp.htv.fi> <20080617223057.GK25911@cs181133002.pp.htv.fi> <20080617223053.GJ25911@cs181133002.pp.htv.fi> <20080617223040.GI25911@cs181133002.pp.htv.fi> <20080617223023.GH25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 18, 2008 at 01:30:24AM +0300, Adrian Bunk wrote:
> This patch fixes the following build error:
> 
> <--  snip  -->
> 
> ...
>   MODPOST 1837 modules
> ERROR: "get_cpu_subtype" [arch/sh/oprofile/oprofile.ko] undefined!
> ...
> make[2]: *** [__modpost] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

On Wed, Jun 18, 2008 at 01:30:40AM +0300, Adrian Bunk wrote:
> This patch fixes the following build error:
> 
> <--  snip  -->
> 
> ...
>   MODPOST 1837 modules
> ERROR: "board_pci_channels" [drivers/pcmcia/yenta_socket.ko] undefined!
> ...
> make[2]: *** [__modpost] Error 1
> 
> <--  snip  -->
> 
> I freely admit that it's a pathological configuration, but as long as 
> it is allowed it should build.
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

On Wed, Jun 18, 2008 at 01:30:53AM +0300, Adrian Bunk wrote:
> EXPORT_SYMBOL's in lib-y considered harmful:
> 
> <--  snip  -->
> 
> ...
>   MODPOST 1837 modules
> ERROR: "__raw_readsl" [drivers/ssb/ssb.ko] undefined!
> ERROR: "__raw_writesl" [drivers/ssb/ssb.ko] undefined!
> ERROR: "__raw_writesl" [drivers/net/smc91x.ko] undefined!
> ERROR: "__raw_readsl" [drivers/net/smc91x.ko] undefined!
> ERROR: "__raw_writesl" [drivers/net/3c59x.ko] undefined!
> ERROR: "__raw_readsl" [drivers/net/3c59x.ko] undefined!
> ...
> make[2]: *** [__modpost] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

On Wed, Jun 18, 2008 at 01:30:57AM +0300, Adrian Bunk wrote:
> This patch makes the needlessly global aica_rtc_{get,set}timeofday() 
> static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

On Wed, Jun 18, 2008 at 01:31:03AM +0300, Adrian Bunk wrote:
> This patch makes the needlessly global EARLY_PCI_OP's static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

On Wed, Jun 18, 2008 at 01:33:40AM +0300, Adrian Bunk wrote:
> This patch makes the needlessly global pcibios_max_latency static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

On Wed, Jun 18, 2008 at 03:36:50AM +0300, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make the following needlessly global code static:
>   - cf-enabler.c: cf_init()
>   - cpu/clock.c: __clk_enable()
>   - cpu/clock.c: __clk_disable()
>   - process_32.c: default_idle()
>   - time_32.c: struct clocksource_sh
>   - timers/timer-tmu.c: struct tmu_timer_ops
> - remove the following unused functions (no CONFIG_BLK_DEV_FD on sh):
>   - process_{32,64}.c: disable_hlt()
>   - process_{32,64}.c: enable_hlt()
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

These are all applied, thanks.
