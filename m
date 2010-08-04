From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Aug 2010 07:45:17 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: Rate calculation fix
Message-Id: <20100804074517.GD15098@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100802092405.30680.9349.sendpatchset@t400s>
In-Reply-To: <20100802092405.30680.9349.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 02, 2010 at 06:24:05PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Fix the rate calculation in the CMT driver.
> Without this fix the clocksource runs way
> too fast and we get a divide-by-zero error.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

On Wed, Aug 04, 2010 at 01:31:38PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Fix a one-off error in the CMT driver V2. The match register
> should be programmed with the period minus one.
> 
> Many thanks to Eiraku-san for tracking down this issue.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
