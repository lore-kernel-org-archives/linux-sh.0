From: john stultz <johnstul@us.ibm.com>
Date: Thu, 28 Apr 2011 20:55:09 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: __clocksource_updatefreq_hz()
Message-Id: <1304024109.2971.104.camel@work-vm>
List-Id: <linux-sh.vger.kernel.org>
References: <20110425133211.3957.30006.sendpatchset@t400s>
In-Reply-To: <20110425133211.3957.30006.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, lethal@linux-sh.org, simon@horms.net, linux-sh@vger.kernel.org

On Mon, 2011-04-25 at 22:32 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch updates the clocksource part of the CMT driver
> to make use of the __clocksource_updatefreq_hz() function.
> 
> Without this patch the old code uses clocksource_register()
> together with a hack that assumes a never changing clock rate
> (see clk_enable(), clk_get_rate() and clk_disable()).
> 
> The patch uses clocksource_register_hz() with 1 Hz as initial
> value, then lets the ->enable() callback update the value
> with __clocksource_updatefreq_hz() once the struct clk has
> been enabled and the frequency is stable.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: John Stultz <johnstul@us.ibm.com>

If these don't get picked up for 2.6.40, I'll queue them myself.

thanks
-john

