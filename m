From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 17 Feb 2011 06:51:35 +0000
Subject: Re: [RFC, PATCH 1/4] net: sh_eth: modify the definitions of register
Message-Id: <4D5CC577.5010108@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D5A67CC.80107@renesas.com>
In-Reply-To: <4D5A67CC.80107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2011/02/17 9:56, Nobuhiro Iwamatsu wrote:
> 2011/2/17 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>:
>>> +static const u16 *sh_eth_get_register_offset(int register_type)
>>> +{
>>> +       const u16 *reg_offset = NULL;
>>> +
>>> +       switch (register_type) {
>>> +       case SH_ETH_REG_GIGABIT:
>>> +               reg_offset = sh_eth_offset_gigabit;
>>> +               break;
>>> +       case SH_ETH_REG_FAST_SH4:
>>> +               reg_offset = sh_eth_offset_fast_sh4;
>>> +               break;
>>> +       case SH_ETH_REG_FAST_SH3_SH2:
>>> +               reg_offset = sh_eth_offset_fast_sh3_sh2;
>>> +               break;
>>> +       case SH_ETH_REG_DEFAULT:
>>> +#if defined(CONFIG_CPU_SUBTYPE_SH7763)
>>> +               reg_offset = sh_eth_offset_gigabit;
>>> +#elif defined(CONFIG_CPU_SH4)
>>> +               reg_offset = sh_eth_offset_fast_sh4;
>>> +#else
>>> +               reg_offset = sh_eth_offset_fast_sh3_sh2;
>>> +#endif
>>> +               break;
>>> +       default:
>>> +               printk(KERN_ERR "Unknown register type (%d)\n", register_type);
>>> +               break;
>>> +       }
>>> +
>>> +       return reg_offset;
>>> +}
>>> +
>>
>> Is the handling of SH_ETH_REG_DEFAULT necessary?
Thank you for your review!
No, it isn't necessary. I will remove it and I will add NULL checking of mdp->reg_offset.

Best regards,
Yoshihiro Shimoda
