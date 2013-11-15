From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 15 Nov 2013 02:35:50 +0000
Subject: Re: LCDC failure of the stable v3.12 kernel for armadillo800-eva
Message-Id: <14730990.U96uTRa42r@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <52831925.8030903@jinso.co.jp>
In-Reply-To: <52831925.8030903@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Nguyen-san,

(I apologize in advance if this is the wrong way to address you, please let me 
know if I should have written Dung-san instead).

On Wednesday 13 November 2013 15:16:05 Nguyen Viet Dung wrote:
> Hi Laurent-san,
> 
> I have tested the stable v3.12 kernel for armadillo800-eva board.
> And it had a error relates LCDC.
> 
> error detail:
> -----------------
> can not display a bitmap image on LCD screen.
> when boot the board,boot log is can not display on LCD screen too.
> 
> Cause:
> ---------
> kernel that had above error:up tream v3.12-rc1....stable v2.12.0
> Error is generated in the following patch.
> [d58226a ARM: shmobile: armadillo800eva: Add backlight support]

I will try to fix that. The LCDC hardware is supported by two drivers, an 
FBDEV driver (drivers/video/sh_mobile_lcdcfb.c) and a DRM driver 
(drivers/gpu/drm/shmobile). Could you please tell which driver you're using ?
 
> Please consider this error if you have time.

-- 
Regards,

Laurent Pinchart

