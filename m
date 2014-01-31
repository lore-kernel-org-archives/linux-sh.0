From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Jan 2014 00:00:12 +0000
Subject: Re: [PATCH] arm: shmobile: r7s72100: really add i2c clocks
Message-Id: <20140131000010.GA14663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1388117724-11103-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1388117724-11103-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 30, 2014 at 10:11:33AM +0100, Wolfram Sang wrote:
> 
> > > >> From: Wolfram Sang <wsa@sang-engineering.com>
> > > >>
> > > >> Due to a merge conflict, addition of the clocks was lost. Tested with
> > > >> RIIC2 on a genmai board. Others untested but hopefully trivial enough to
> > > >> be added.
> > > >>
> > > >> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> > > >
> > > > Thanks, I will queue this up.
> > > 
> > > This still seems to be missing?
> > 
> > Thanks, I have now queued it up.
> 
> It is not upstream yet?

Hi,

the following is in the devel branch of my renesas tree, queued up for v3.15.



From: Wolfram Sang <wsa@sang-engineering.com>

ARM: shmobile: r7s72100: really add i2c clocks

Due to a merge conflict, addition of the clocks was lost. Tested with
RIIC2 on a genmai board. Others untested but hopefully trivial enough to
be added.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
[horms+renesas@verge.net.au: Capitalised "ARM" in subject]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index e6ab0cd..dd8ce87 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -176,6 +176,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
 	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 
 	/* ICK */

