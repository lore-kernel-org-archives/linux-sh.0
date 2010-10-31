From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 31 Oct 2010 14:55:24 +0000
Subject: Re: [PATCH] ARM: shmobile: remove sh_timer_config clk member
Message-Id: <20101031145524.GC6955@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101013073638.19764.20402.sendpatchset@t400s>
In-Reply-To: <20101013073638.19764.20402.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 13, 2010 at 04:36:38PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Now when the SH-Mobile ARM platforms have been converted
> to use device name it is possible to remove "clk" from
> struct sh_timer_config.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

This was certainly long overdue! Applied, thanks.
