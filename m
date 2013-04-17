From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 17 Apr 2013 10:10:17 +0000
Subject: Re: [PATCH] ARM: shmobile: BOCK-W: enable CONFIG_PM_RUNTIME in defconfig
Message-Id: <20130417101017.GW14496@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <201304170303.46193.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304170303.46193.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 17, 2013 at 03:03:45AM +0400, Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Enable CONFIG_PM_RUNTIME in 'bockw_defconfig' -- it's already used by TMU, SCI,
> I2C, and Ether drivers to control the clocks...
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130416' tag.

Maybe you should send it to Simon rather than me for initial merging, who
would presumably know if this is the right thing for this bockw platform?
