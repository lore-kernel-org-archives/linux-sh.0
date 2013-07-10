From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 10 Jul 2013 01:49:43 +0000
Subject: Re: [PATCH v2 3/7] backlight: Add ROHM BD6107 backlight driver
Message-Id: <000b01ce7d0f$c0024a00$4006de00$@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372965210-10024-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372965210-10024-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, July 05, 2013 4:13 AM, Laurent Pinchart wrote:
> 
> The BD6107 is a multi-purpose 10 channels LED driver for the mobile
> market. Only the main channel is supported by this driver.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This looks good.
Acked-by: Jingoo Han <jg1.han@samsung.com>


Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/Kconfig      |   6 +
>  drivers/video/backlight/Makefile     |   1 +
>  drivers/video/backlight/bd6107.c     | 213 +++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/bd6107.h |  19 ++++
>  4 files changed, 239 insertions(+)
>  create mode 100644 drivers/video/backlight/bd6107.c
>  create mode 100644 include/linux/platform_data/bd6107.h



