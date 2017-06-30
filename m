From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 Jun 2017 08:40:51 +0000
Subject: Re: [PATCH 3/6] i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
Message-Id: <CAHp75VejpMcgsyncpbFnDXbwYcwdD1BPqy53s98xcNmfAnJTFw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz> <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 30, 2017 at 3:54 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Rather than returning -ENODEV if i2c_pca_add_numbered_bus() fails,
> propagate the error to aid debugging.
>

+ Suggested-by ?

You or Wolfram can use below if you agree on it (I'm fine either way):

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

> ---
>  drivers/i2c/busses/i2c-pca-platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
> index daccef6865e8..853a2abedb05 100644
> --- a/drivers/i2c/busses/i2c-pca-platform.c
> +++ b/drivers/i2c/busses/i2c-pca-platform.c
> @@ -232,9 +232,9 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
>                         return ret;
>         }
>
> -       if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
> -               return -ENODEV;
> -       }
> +       ret = i2c_pca_add_numbered_bus(&i2c->adap);
> +       if (ret)
> +               return ret;
>
>         platform_set_drvdata(pdev, i2c);
>
> --
> 2.13.0
>



-- 
With Best Regards,
Andy Shevchenko
