From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jun 2012 13:06:36 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: Support MMC_SLEEP_AWAKE command
Message-Id: <2609967.tcqa2xCl8R@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com> <CAPDyKFo_my_+xQOKYooNawtJ1b3Ncm2osNg9TMN8YpftXfr+Jg@mail.gmail.com>
In-Reply-To: <CAPDyKFo_my_+xQOKYooNawtJ1b3Ncm2osNg9TMN8YpftXfr+Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, Saugata Das <saugata.das@linaro.org>, Girish Shivananjappa <girish.shivananjappa@linaro.org>

Hi Ulf,

On Wednesday 20 June 2012 13:54:33 Ulf Hansson wrote:
> Hi Laurent,
> 
> Your issue seem more related to a mmc protocol problem. Likely caused
> by a bad patch for eMMC 4.5 poweroff notify. The patch I refer to is:
> "mmc: core: Fix PowerOff Notify suspend/resume"
> 
> You may try to revert this patch and see if the same problem occurs for you.
> 
> We are trying to fix the issue inserted by the above commit in a patch
> named: "MMC-4.5 Power OFF Notify Rework", please have a look if you have
> the time.

I think the two issues are othorgonal (but please feel free to tell me if 
there's something I'm missing).

The MMCIF controller driver rejects the MMC_SLEEP_AWAKE command 
unconditionally, even though it should be accepted, because it happens to 
share the command number with an SDIO command (SD_IO_SEND_OP_COND) used to 
probe SDIO support. My patch fixes this by accepting the MMC_SLEEP_AWAKE 
command but still rejecting the SD_IO_SEND_OP_COND command.

-- 
Regards,

Laurent Pinchart

