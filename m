From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 08 Feb 2013 01:59:34 +0000
Subject: Re: [PATCH v2] shmobile: ipmmu: Add basic PMB support
Message-Id: <87mwvfy399.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360228959-14911-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1360228959-14911-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Damian

one comment from me

> +void *ipmmu_pmb_init(struct shmobile_ipmmu *ipmmu)
> +{
> +	int err = -ENOENT;
> +	int i;
> +	struct ipmmu_pmb_priv *priv;
> +
> +	priv = devm_kzalloc(ipmmu->dev, sizeof(struct ipmmu_pmb_priv),
> +								GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(ipmmu->dev, "cannot allocate device data\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
(snip)
> +destroy_device:
> +	device_destroy(priv->pmb_class, priv->pmb_dev);
> +unregister_region:
> +	unregister_chrdev_region(priv->pmb_dev, 1);
> +destroy_class:
> +	class_destroy(priv->pmb_class);
> +free_priv:
> +	kfree(priv);
> +	return ERR_PTR(err);
> +}

you are using devm_kzalloc() for priv.
This means kfree(priv) is not needed here.

Best regards
---
Kuninori Morimoto
