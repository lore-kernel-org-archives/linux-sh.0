From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Sep 2013 13:37:48 +0000
Subject: Re: [RFC 07/10] ARM: shmobile: r8a7790: i2c pinmux
Message-Id: <3928735.V4qgk4BlrU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-8-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-8-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Friday 30 August 2013 14:37:41 Ulrich Hecht wrote:
> Adds pinmux for i2c bus 1 and 2. (Pins for 0 and 3 are not multiplexed.)
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've modified the subject to "sh-pfc: r8a7790: Add I2C pin groups and 
functions" and have taken the patch in my tree and will push it to v3.13.

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 90 +++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)

-- 
Regards,

Laurent Pinchart

