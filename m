From: Colin Cross <ccross@google.com>
Date: Mon, 07 Feb 2011 19:59:26 +0000
Subject: Re: [RFC,PATCH 1/3] Add a common struct clk
Message-Id: <AANLkTi=5FNvWKQf6cRt4wNejC7u4XKsqLp9Pwc2Z45_3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800158.458894385837.1.gpush@pororo>
In-Reply-To: <1297058877.800158.458894385837.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sun, Feb 6, 2011 at 10:07 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wr=
ote:
<snip>

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> new file mode 100644
> index 0000000..12e0daf
> --- /dev/null
> +++ b/drivers/clk/clk.c

<snip>

> +int clk_enable(struct clk *clk)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!clk->ops->enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 spin_lock(&clk->enable_lock);

spin_lock_irqsave/spin_unlock_irqrestore.  This could get called with
irqs on or off.
