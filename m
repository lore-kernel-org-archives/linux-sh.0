From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Aug 2014 18:08:33 +0000
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Enable shmobile platforms
Message-Id: <2122329.o66gXAWddB@amdc1032>
List-Id: <linux-sh.vger.kernel.org>
References: <1409234429-1916-1-git-send-email-geert+renesas@glider.be>
 <1965890.bT7bZyQJt8@amdc1032>
In-Reply-To: <1965890.bT7bZyQJt8@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, August 29, 2014 08:05:49 PM Bartlomiej Zolnierkiewicz wrote:

> +CONFIG_VIDEO_RENESAS_VSP1=y
> 
> This seems to be another option for Renesas specific hardware and it has
> a footprint of 23kB.

s/23/38/

[ sorry for the mistake ]

> [ I think that this option should depend on ARCH_SHMOBILE. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

