From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 08 Apr 2013 18:33:03 +0000
Subject: Re: [GIT PULL] Renesas ARM based SoC bockw defconfig updates for v3.10
Message-Id: <201304082033.04091.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1365130583-11257-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365130583-11257-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 05 April 2013, Simon Horman wrote:
> An update to the defconfig for the bockw board to enable SMSC ethernet.
> 
> This is based on:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-boards3-for-v3.10
> 
> The reason for using that base is that the bockw defconfig was added
> in the boards branch instead of the defconfig branch, which was not ideal.

Pulled into the same next/boards2 branch that had the original addition.

	Arnd
