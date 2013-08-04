From: Olof Johansson <olof@lixom.net>
Date: Sun, 04 Aug 2013 19:21:33 +0000
Subject: Re: [GIT 0/7] Renesas ARM and SH based SoC backlight drivers for v3.12
Message-Id: <20130804192133.GD10876@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374207161.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374207161.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Jul 19, 2013 at 01:34:48PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following backlight drivers for v3.12.
> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-backlight-for-v3.12

Pulled. In the future a branch like this could be split into the driver updates
for the backlight stuff, then board patches to plumb in the new drivers. But
I've pulled it all into the next/boards branch for now.


-Olof
