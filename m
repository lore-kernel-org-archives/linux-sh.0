From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 03 Jul 2013 12:35:05 +0000
Subject: Re: [GIT PULL 0/2] Renesas ARM based SoC fixes for v3.11
Message-Id: <201307031435.05949.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1372739438.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1372739438.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 02 July 2013, Simon Horman wrote:
> --------------------------------------------------
> Renesas ARM based SoC fixes for v3.11
> 
> * Correct GIO3 base addresses for EMEV2 SoC
>   - This bug bug added when GPIO support was added for the EMEV2 SoC
>     in v3.5
> 
> * Correct SCIFB0 resources for r8a77a4 SoC
>   - This was a bug was added when SCIF support was added for the r8a77a4 SoC
>     in v3.10
> 

Pulled into the fixes branch, thanks!

	Arnd
