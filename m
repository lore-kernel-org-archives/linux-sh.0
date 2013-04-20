From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 20 Apr 2013 21:59:42 +0000
Subject: Re: [PATCH 1/5] V4L2: I2C: ML86V7667 video decoder driver
Message-Id: <51730FCE.8000604@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304210013.46110.sergei.shtylyov@cogentembedded.com> <201304210016.33720.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304210016.33720.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mchehab@redhat.com, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, matsu@igel.co.jp, vladimir.barinov@cogentembedded.com

Hello.

On 04/21/2013 12:16 AM, Sergei Shtylyov wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>
> Add OKI Semiconductor ML86V7667 video decoder driver.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: added v4l2_device_unregister_subdev() call to the error cleanup path of
> ml86v7667_probe(); some cleanup.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

> Index: renesas/drivers/media/i2c/ml86v7667.c
> =================================> --- /dev/null
> +++ renesas/drivers/media/i2c/ml86v7667.c
> @@ -0,0 +1,504 @@

[...]

> +/* ACC Loop filter & Chrominance control register bits */
> +#define ACCC_CHROMA_CR_SHIFT	3
> +#define ACCC_CHROMA_CR_MASK	(7 << 3)
> +#define ACCC_CHROMA_CB_SHIFT	0
> +#define ACCC_CHROMA_CB_MASK	(7 << 3)

     Should be (7 << 0), of course. My fault. :-(

WBR, Sergei


