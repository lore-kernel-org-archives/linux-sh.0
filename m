From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Nov 2015 16:30:04 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Fixes for v4.4
Message-Id: <3789266.5u2KpAtNbX@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1448586153.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1448586153.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 27 November 2015 10:56:05 Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v4.4
> 
> * r8a7793 SoC: Annotate r8a7793_boards_compat_dt with __initconst
>   Aside from being correct this builds that otherwise
>   fail with section mismatch errors.

Pulled into fixes, thanks!

	Arnd
