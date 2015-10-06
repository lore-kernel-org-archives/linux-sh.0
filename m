From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 06 Oct 2015 14:43:07 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Updates for v4.4
Message-Id: <5084387.KxgjSGLa7G@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1443072491.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1443072491.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 24 September 2015 14:30:20 Simon Horman wrote:
>   This part of a multi-stage effort by Geert Uytterhoeven to add:
> 
>   "Clock Domain support to the Clock Pulse Generator (CPG) Module Stop
>    (MSTP) Clocks driver using the generic PM Domain, to be used on shmobile
>    SoCs without device power domains (R-Car Gen1 and Gen2, RZ).  This allows
>    to power-manage the module clocks of SoC devices that are part of the
>    CPG/MSTP Clock Domain using Runtime PM, or for system suspend/resume,
>    similar to SoCs with device power domains (SH-Mobile and R-Mobile)."
> 
> 

Merged into next/soc, thanks!

	Arnd
