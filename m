From: Olof Johansson <olof@lixom.net>
Date: Tue, 06 Nov 2012 14:07:22 +0000
Subject: Re: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8
Message-Id: <20121106140722.GC27284@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1351730411-1874-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1351730411-1874-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 01, 2012 at 08:40:03AM +0800, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following board enhancements for 3.8.
> 
> This differs from v2 of this pull request in that:
> * Several patches have been moved to the soc branch which
>   I will send a pull request for shortly.
>   - ARM: shmobile: r8a7779: add HSPI clock support
>   - ARM: shmobile: r8a7779: add I2C clock support
>   - ARM: shmobile: r8a7779: add I2C driver support
>   - ARM: shmobile: r8a7740: Enable PMU
> * Several new patches have been added.
>   - ARM: shmobile: Remove G4EVM machine support
>   - ARM: shmobile: Remove G3EVM machine support
> 
> ---------------------------------------------------------------
> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:
> 
>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

Thanks, pulled.


-Olof
