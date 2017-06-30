From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 Jun 2017 08:44:21 +0000
Subject: Re: [PATCH 5/6] i2c: pca-platform: use device_property_read_u32
Message-Id: <CAHp75Vc+6WGFiJifEExjv3jSFsy+ORGtRoDPmv31sSFN=zkHMg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz> <20170630005408.23968-6-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170630005408.23968-6-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 30, 2017 at 3:54 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Use device_property_read_u32 instead of of_property_read_u32_index to
> lookup the "clock-frequency" property.

My comments below.

>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/i2c/busses/i2c-pca-platform.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
> index 1e3c247de8f8..80420f753a87 100644
> --- a/drivers/i2c/busses/i2c-pca-platform.c
> +++ b/drivers/i2c/busses/i2c-pca-platform.c
> @@ -176,13 +176,12 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)

>         if (platform_data) {
>                 i2c->adap.timeout = platform_data->timeout;
>                 i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;

>         } else {
>                 i2c->adap.timeout = HZ;
> -               i2c->algo_data.i2c_clock = 59000;
> +               ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> +                                              &i2c->algo_data.i2c_clock);
> +               if (ret)
> +                       i2c->algo_data.i2c_clock = 59000;

My idea is to get rid of legacy platform data completely.
That's why I suggested device_* in the first place.

In similar way like you did with GPIO lookup table, you may use
PROPERTY_ENTRY*() macros in the board files.

Does it make sense?

-- 
With Best Regards,
Andy Shevchenko
