From: Olof Johansson <olof@lixom.net>
Date: Tue, 11 Jun 2013 06:50:26 +0000
Subject: Re: [GIT PULL 000/130] Renesas ARM based SoC pinmux and GPIO update for
Message-Id: <20130611065026.GE6688@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 05, 2013 at 05:24:51PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> Please note that this pull-request is based on renesas-fixes-for-v3.10
> in order to avoid a messy conflict.

Thanks for doing that. It's quite common that platform maintainers forget to
deal with conflicts due to fixes, which can sometimes be a bit annoying. :-)


> The following changes since commit 5600a8485603b240790005b9b58de4c4f6ada69d:
> 
>   ARM: shmobile: sh73a0: Update CMT clockevent rating to 80 (2013-06-04 14:37:53 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux-for-v3.11

Pulled into next/drivers. Thanks!


-Olof
