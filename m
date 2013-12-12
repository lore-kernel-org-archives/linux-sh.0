From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 12 Dec 2013 02:16:05 +0000
Subject: Re: [PATCH 08/12] mmc: sh_mobile_sdhi: Convert to clk_prepare/unprepare
Message-Id: <4390506.Q1di3yUE6Z@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <23114596.UeGyAebmZh@avalon> <87a9g67t63.fsf@octavius.laptop.org>
In-Reply-To: <87a9g67t63.fsf@octavius.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Chris,

On Wednesday 11 December 2013 20:29:56 Chris Ball wrote:
> Hi Laurent,
> 
> On Wed, Dec 11 2013, Laurent Pinchart wrote:
> > PING ?
> 
> I'm sorry about the delay -- it's in mmc-next for 3.14 now.

Thanks a lot and sorry about shouting. Don't worry about the delay, I only 
wanted to make sure the patch would get in v3.14.

Now, if you wanted to review (and hopefully apply) the following patches as 
well that would be perfect :-)

[PATCH v3 1/3] mmc: sh_mmcif: Factorize DMA channel request and configuration 
code
[PATCH v3 2/3] mmc: sh_mmcif: Fix compilation warning on 64-bit platforms
mmc: sdhi: Enable driver compilation with COMPILE_TEST
mmc: sh_mmcif: Enable driver compilation with COMPILE_TEST

(Please note that "[PATCH v3 3/3] mmc: sh_mmcif: Enable the driver on all ARM 
platforms" has been superseded by "mmc: sh_mmcif: Enable driver compilation 
with COMPILE_TEST")

-- 
Regards,

Laurent Pinchart

