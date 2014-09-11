From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Sep 2014 08:19:50 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC PM Cleanups for v3.18
Message-Id: <3730544.GaXb8fh1yg@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1410395620.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1410395620.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 11 September 2014 09:57:24 Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC PM cleanups for v3.18.
> 
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pm-cleanups-for-v3.18
> 
> for you to fetch changes up to 834720dbf03819a8b2d0ba5fbe01d008267f9da6:
> 
>   ARM: shmobile: armadillo800eva legacy: Use rmobile_add_devices_to_domains() (2014-09-09 11:16:08 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC PM Cleanups for v3.18
> 
> * Make domain_devices[] static __initdata
> * Add and use rmobile_add_devices_to_domain
> 

Pulled into next/cleanup, thanks!

	Arnd
