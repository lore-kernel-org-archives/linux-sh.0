From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Aug 2012 06:45:06 +0000
Subject: [GIT PULL] Renesas ARM-based SoC: Armadillo800EVA for 3.7
Message-Id: <20120827064506.GB26953@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346049610-2266-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1346049610-2266-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Somehow I forgot to give the previous email a subject, not a good start :(

On Mon, Aug 27, 2012 at 03:40:08PM +0900, Simon Horman wrote:
> Hi Arnd, Hi Olaf,
> 
> please consider the following enhancements for the Armadillo800EVA board
> from Laurent Pinchart for inclusion in 3.7.
> 
> I am currently in the processes of taking over maintenance
> of shmoble from Rafael Wysocki and this my the first pull request
> in that role.
> 
> ----------------------------------------------------------------
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git armadillo800eva
> 
> for you to fetch changes up to 5c1d2d16772e2d7d4e2e8da99a92d6f50b9102f0:
> 
>   ARM: mach-shmobile: armadillo800eva: Enable power button as wakeup source (2012-08-25 15:44:53 +0900)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (2):
>       ARM: mach-shmobile: armadillo800eva: Fix GPIO buttons descriptions
>       ARM: mach-shmobile: armadillo800eva: Enable power button as wakeup source
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
