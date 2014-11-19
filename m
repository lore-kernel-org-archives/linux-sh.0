From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 19 Nov 2014 22:08:09 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Boards Updates for v3.19
Message-Id: <201411192308.10133.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415756816.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415756816.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 13 November 2014, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC boards updates for v3.19.
> 
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.19
> 
> for you to fetch changes up to 534547c036afad3f23d49d8352896f5d05709685:
> 
>   ARM: shmobile: kzm9g-reference: Add restart callback (2014-11-10 10:16:35 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Boards Updates for v3.19
> 
> * Add restart callback to kzm9g
> 

Pulled into next/soc, though not happy, as explained in the other pull
request about a restart callback.

	Arnd
