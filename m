From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 21 Jul 2011 07:54:14 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: wait for CMCNT on init V2
Message-Id: <20110721075413.GD27831@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630091258.10263.21421.sendpatchset@t400s>
In-Reply-To: <20110630091258.10263.21421.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 13, 2011 at 04:59:48PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add code to the CMT driver to wait for CMCNT V2. This to let
> the register value settle before starting the timer channel.
> Makes the driver more robust.
> 
> Needed for CMT2 on sh7372 and certain CMT channels on sh73a0.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
