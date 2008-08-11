From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Aug 2008 15:17:34 +0000
Subject: Re: [PATCH] sh: Add support sh_eth to sh7763rdp board
Message-Id: <20080811151734.GB5723@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <489BD9D6.6060804@renesas.com>
In-Reply-To: <489BD9D6.6060804@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 08, 2008 at 02:29:58PM +0900, Nobuhiro Iwamatsu wrote:
> SH7763 has sh_eth device. This patch add sh_eth platform device
> to this board.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Fri, Aug 08, 2008 at 02:30:06PM +0900, Nobuhiro Iwamatsu wrote:
> Add sh7760fb platform device to sh7763rdp's setup.

On Fri, Aug 08, 2008 at 02:30:13PM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/sh/configs/sh7763rdp_defconfig |  113 ++++++++++++++++++++++++++++++-----
>  1 files changed, 97 insertions(+), 16 deletions(-)
> 
These are now applied, thanks.
