From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 18 Apr 2013 14:27:24 +0000
Subject: Re: [PATCH 1/4] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <517002CC.2000807@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304180206.39465.sergei.shtylyov@cogentembedded.com> <201304180211.13992.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304180211.13992.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: g.liakhovetski@gmx.de, mchehab@redhat.com, linux-media@vger.kernel.org
Cc: magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, matsu@igel.co.jp, Vladimir Barinov <vladimir.barinov@cogentembedded.com>

On 18-04-2013 2:11, Sergei Shtylyov wrote:

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

> Add Renesas R-Car VIN (Video In) V4L2 driver.

> Based on the patch by Phil Edworthy <phil.edworthy@renesas.com>.

> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: some formatting cleanup]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

> +static int rcar_vin_probe(struct platform_device *pdev)
> +{
[...]
> +	ret = devm_request_irq(&pdev->dev, irq, rcar_vin_irq, IRQF_DISABLED,

    I forgot that this flag is deprecated now. Also we need to pass IRQF_SHARED
for the VIN driver to work on R8A7778 where VIN0/1 share the IRQ.

WBR, Sergei

