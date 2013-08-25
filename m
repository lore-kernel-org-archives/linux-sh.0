From: Chris Ball <cjb@laptop.org>
Date: Sun, 25 Aug 2013 04:12:00 +0000
Subject: Re: [PATCH 0/6] mmc: sh_mmcif: revision-specific CCS and CLK_CTRL2 handling
Message-Id: <8738pyqui7.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Wed, 10 Jul 2013 21:21:11 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi Guennadi,

On Wed, Jul 10 2013, Guennadi Liakhovetski wrote:
> This patch series adds version-specific support for Command Completion 
> Signal and the CE_CLK_CTRL2 register. Presumably, the first two patches 
> will go via the MMC tree, the rest should be applied after them.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> Guennadi Liakhovetski (6):
>   mmc: sh_mmcif: revision-specific Command Completion Signal handling
>   mmc: sh_mmcif: revision-specific CLK_CTRL2 handling

Thanks, I've pushed these two patches to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
