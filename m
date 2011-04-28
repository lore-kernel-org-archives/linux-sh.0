From: john stultz <johnstul@us.ibm.com>
Date: Thu, 28 Apr 2011 20:55:56 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Runtime PM support
Message-Id: <1304024156.2971.107.camel@work-vm>
List-Id: <linux-sh.vger.kernel.org>
References: <20110425134026.4249.13858.sendpatchset@t400s>
In-Reply-To: <20110425134026.4249.13858.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Mon, 2011-04-25 at 22:40 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add Runtime PM support to the TMU driver.
> 
> The hardware device is enabled as long as the clocksource
> or the clockevent portion of the driver is used.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: John Stultz <johnstul@us.ibm.com>


