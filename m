From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Jun 2012 07:44:32 +0000
Subject: Re: [PATCH 1/3] sh: Convert sh_clk_mstp32_register to sh_clk_mstp_register
Message-Id: <20120628074432.GB21764@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1340758782-605-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1340758782-605-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 27, 2012 at 09:59:40AM +0900, Nobuhiro Iwamatsu wrote:
> sh_clk_mstp32_register is deprecated. This convert to sh_clk_mstp_register.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Thanks, I'll queue it up for 3.5 now that some of the noise has died
down. With any luck we should be able to apply your 3/3 patch during the
next merge window, assuming no new users are added.
