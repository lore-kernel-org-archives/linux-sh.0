From: Olof Johansson <olof@lixom.net>
Date: Thu, 20 Feb 2014 08:25:02 +0000
Subject: Re: [GIT PULL 0/3] Renesas ARM Based SoC Clean-Ups for v3.15
Message-Id: <20140220082502.GF19089@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391650702.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391650702.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 06, 2014 at 03:20:06PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> please consider these Renesas ARM Based SoC clean-ups for v3.15.
> 
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.15
> 
> for you to fetch changes up to d24d1780c340777942061ef3445edcf228e8d35b:
> 
>   ARM: shmobile: emev2: Use __initconst for const init definition (2014-02-04 10:24:28 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Clean-Ups for v3.15
> 
> * Renesas SoCs (Global)
>   - Remove duplicate shmobile_invalidate_start() declaration
> 
> * emev2 SoC (Emma Mobile)
>   - Use __initconst for const init definition
> 
> * r8a7779 SoC (R-Car H1)
>   - Remove unused clock constants

Merged into next/cleanup.


Thanks,

-Olof
