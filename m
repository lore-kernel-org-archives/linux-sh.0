From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 17 Feb 2011 00:56:13 +0000
Subject: Re: [RFC, PATCH 1/4] net: sh_eth: modify the definitions of register
Message-Id: <AANLkTikxYtG620D4z09k15v7=r5CZ7xCcDWenbJmM_sP@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D5A67CC.80107@renesas.com>
In-Reply-To: <4D5A67CC.80107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2011/2/17 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>:
> 2011/2/15 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>:
>> The previous code cannot handle the ETHER and GETHER both as same time
>> because the definitions of register was hardcoded.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>> =A0arch/sh/include/asm/sh_eth.h | =A0 =A07 +
>> =A0drivers/net/sh_eth.c =A0 =A0 =A0 =A0 | =A0322 +++++++++++-----------
>> =A0drivers/net/sh_eth.h =A0 =A0 =A0 =A0 | =A0623 +++++++++++++++++++++++=
+------------------
>> =A03 files changed, 537 insertions(+), 415 deletions(-)
>>
>
> <snip>
>
>>
>> +static const u16 *sh_eth_get_register_offset(int register_type)
>> +{
>> + =A0 =A0 =A0 const u16 *reg_offset =3D NULL;
>> +
>> + =A0 =A0 =A0 switch (register_type) {
>> + =A0 =A0 =A0 case SH_ETH_REG_GIGABIT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_offset =3D sh_eth_offset_gigabit;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case SH_ETH_REG_FAST_SH4:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_offset =3D sh_eth_offset_fast_sh4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case SH_ETH_REG_FAST_SH3_SH2:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_offset =3D sh_eth_offset_fast_sh3_sh2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case SH_ETH_REG_DEFAULT:
>> +#if defined(CONFIG_CPU_SUBTYPE_SH7763)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_offset =3D sh_eth_offset_gigabit;
>> +#elif defined(CONFIG_CPU_SH4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_offset =3D sh_eth_offset_fast_sh4;
>> +#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_offset =3D sh_eth_offset_fast_sh3_sh2;
>> +#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unknown register type (%d=
)\n", register_type);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return reg_offset;
>> +}
>> +
>
> Is the handling of SH_ETH_REG_DEFAULT necessary?
>
>>
>> +static inline void sh_eth_write(struct net_device *ndev, unsigned long =
data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int enum_i=
ndex)
>> +{
>> + =A0 =A0 =A0 struct sh_eth_private *mdp =3D netdev_priv(ndev);
>> +
>> + =A0 =A0 =A0 writel(data, ndev->base_addr + mdp->reg_offset[enum_index]=
);
>> +}
>> +
>> +static inline unsigned long sh_eth_read(struct net_device *ndev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 int enum_index)
>> +{
>> + =A0 =A0 =A0 struct sh_eth_private *mdp =3D netdev_priv(ndev);
>> +
>> + =A0 =A0 =A0 return readl(ndev->base_addr + mdp->reg_offset[enum_index]=
);
>> +}
>> +
>> +static inline void sh_eth_tsu_write(struct sh_eth_private *mdp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned l=
ong data, int enum_index)
>> +{
>> + =A0 =A0 =A0 writel(data, mdp->tsu_addr + mdp->reg_offset[enum_index]);
>> +}
>> +
>> +static inline unsigned long sh_eth_tsu_read(struct sh_eth_private *mdp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 int enum_index)
>> +{
>> + =A0 =A0 =A0 return readl(mdp->tsu_addr + mdp->reg_offset[enum_index]);
>> +}
>> +
>> =A0#endif /* #ifndef __SH_ETH_H__ */
>
> I do not think that a new function is necessary.
> I think it use MACRO.
>
> For example,
> #define sh_eth_write(data,reg) \
> {\
> =A0 =A0writel(data, ndev->base_addr + mdp->reg_offset[reg]); \
> }
>

Oh sorry, this is bad coding style.
Please ignore this comment.

Nobuhiro


--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
