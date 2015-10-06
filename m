From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 06 Oct 2015 14:47:09 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Clk Updates for v4.4
Message-Id: <4977830.HvfsxT5pKz@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1443072085.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1443072085.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 24 September 2015 14:29:59 Simon Horman wrote:
> Renesas ARM Based SoC Clk Updates for v4.4
> 
> * Consider "zb_clk" suitable for power management
> 
>   This part of a multi-stage effort by Geert Uytterhoeven to add:
> 
>   "Clock Domain support to the Clock Pulse Generator (CPG) Module Stop
>    (MSTP) Clocks driver using the generic PM Domain, to be used on shmobile
>    SoCs without device power domains (R-Car Gen1 and Gen2, RZ).  This allows
>    to power-manage the module clocks of SoC devices that are part of the
>    CPG/MSTP Clock Domain using Runtime PM, or for system suspend/resume,
>    similar to SoCs with device power domains (SH-Mobile and R-Mobile)."
> 

Pulled into next/drivers, thanks!

	Arnd
