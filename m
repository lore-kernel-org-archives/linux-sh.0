From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Sep 2012 04:06:31 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: Add support RTC
Message-Id: <20120913040629.GA23861@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1347505841-8594-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1347505841-8594-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 13, 2012 at 12:10:41PM +0900, Nobuhiro Iwamatsu wrote:
> The armadillo800eva has S35390A which is RTC. This is controlled
> using I2C of GPIO.
> This commit supports RTC of armadillo800eva.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Hi Iwamatsu-san,

could you please either update this patch or provide a follow-up
patch to update the defconfig so the S35390A is enabled?

"make savedefconfig" may be useful for this.
