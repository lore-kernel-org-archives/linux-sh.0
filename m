From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 11 Dec 2017 14:49:24 +0000
Subject: Re: [PATCH v1 07/10] v4l: i2c: Copy ov772x soc_camera sensor driver
Message-Id: <3757887.b3TU9SkMDe@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org> <1510743363-25798-8-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1510743363-25798-8-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, hverkuil@xs4all.nl, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Wednesday, 15 November 2017 12:56:00 EET Jacopo Mondi wrote:
> Copy the soc_camera based driver in v4l2 sensor driver directory.
> This commit just copies the original file without modifying it.

You might want to explain why you're not patching the Kconfig and Makefile 
here, that is because you will first convert the driver away from soc-camera 
in the next commit.

Apart from that,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/media/i2c/ov772x.c | 1124 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1124 insertions(+)
>  create mode 100644 drivers/media/i2c/ov772x.c

-- 
Regards,

Laurent Pinchart

