From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Aug 2013 08:43:11 +0000
Subject: Re: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-Id: <87y57k99b8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

# I dropped some mail address

> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-shmobile/setup-r8a7778.c between commit 803c2df21752
> ("[media] ARM: shmobile: r8a7778: add VIN support") from the v4l-dvb tree
> and commits cfa66a81621d ("ARM: shmobile: bockw: add DT reference") and
> a66c9744574c ("ARM: shmobile: r8a7778: cleanup registration of mmcif")
> from the arm-soc tree.
(snip)
>  +void __init r8a7778_add_vin_device(int id, struct rcar_vin_platform_data *pdata)
>  +{
>  +	BUG_ON(id < 0 || id > 1);
>  +
>  +	vin_info_table[id]->data = pdata;
>  +	vin_info_table[id]->size_data = sizeof(*pdata);
>  +
>  +	platform_device_register_full(vin_info_table[id]);
>  +}

We need to cleanup above style again after merging.
