From: Bastian Hecht <hechtb@gmail.com>
Date: Mon, 17 Dec 2012 11:17:41 +0000
Subject: Re: [PATCH 2/2] net: sh_eth: Add Device Tree support
Message-Id: <CABYn4syhgijosrZjEbMK7UMVx6pFA2goMMk=3DLKw1c6R-6W3g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1355666066-25649-3-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355666066-25649-3-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Nobuhiro,

2012/12/17 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>:
> Hi, Bastian.
>
> I already sent a patch which support OF of sh-eth.
> http://patchwork.ozlabs.org/patch/191713/.

Oh great! Yes this looks much better than mine, thanks for pointing it out.

> And please CC netdev.

I omitted netdev as the patch was not intended for merge yet.

Thanks,

 Bastian

> Best regards,
>   Nobuhiro
>
> On Sun, Dec 16, 2012 at 10:54 PM, Bastian Hecht <hechtb@gmail.com> wrote:
>> We add support for Device Tree probing in order to support the Armadillo
>> DT testcase.
>>
>> Until we figure out what portions of the platform config are board
>> dependent and should be used as OF properties and what portions are only
>> SoC related and can be stored in the driver itself, I have attached all
>> platform configurations to the OF match in the driver.
>>
>> Not-yet-signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>>  drivers/net/ethernet/renesas/sh_eth.c |   72 ++++++++++++++++++++++++++++++++-
>>  1 file changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
>> index c8bfea0..1fbbf69 100644
>> --- a/drivers/net/ethernet/renesas/sh_eth.c
>> +++ b/drivers/net/ethernet/renesas/sh_eth.c
>> @@ -31,6 +31,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/mdio-bitbang.h>
>>  #include <linux/netdevice.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>>  #include <linux/phy.h>
>>  #include <linux/cache.h>
>>  #include <linux/io.h>
>> @@ -2347,6 +2349,63 @@ static const struct net_device_ops sh_eth_netdev_ops = {
>>         .ndo_change_mtu         = eth_change_mtu,
>>  };
>>
>> +#ifdef CONFIG_OF
>> +struct sh_eth_soc_config {
>> +       int             phy;
>> +       phy_interface_t phy_interface;
>> +       unsigned        edmac_endian:1;
>> +       unsigned        register_type:2;
>> +};
>> +
>> +static struct sh_eth_soc_config sh_eth_r8a7740_config = {
>> +       .phy            = 0x00,
>> +       .phy_interface  = PHY_INTERFACE_MODE_MII,
>> +       .edmac_endian   = EDMAC_LITTLE_ENDIAN,
>> +       .register_type  = SH_ETH_REG_GIGABIT,
>> +};
>> +
>> +static const struct of_device_id sh_eth_match[] = {
>> +       { .compatible = "renesas,sh-eth-r8a7740",
>> +                       .data = &sh_eth_r8a7740_config },
>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(of, sh_eth_match);
>> +
>> +static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
>> +{
>> +       const struct of_device_id *match;
>> +       struct sh_eth_plat_data *pd;
>> +       struct sh_eth_soc_config *config;
>> +
>> +       match = of_match_device(sh_eth_match, dev);
>> +       if (match)
>> +               config = (struct sh_eth_soc_config *)match->data;
>> +       else {
>> +               dev_err(dev, "%s: no OF configuration attached\n", __func__);
>> +               return NULL;
>> +       }
>> +
>> +       pd = devm_kzalloc(dev, sizeof(struct sh_eth_plat_data), GFP_KERNEL);
>> +       if (!pd) {
>> +               dev_err(dev, "failed to allocate setup data\n");
>> +               return NULL;
>> +       }
>> +
>> +       pd->phy                 = config->phy;
>> +       pd->phy_interface       = config->phy_interface;
>> +       pd->edmac_endian        = config->edmac_endian;
>> +       pd->register_type       = config->register_type;
>> +
>> +       return pd;
>> +}
>> +#else
>> +static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
>> +{
>> +       return NULL;
>> +}
>> +#define sh_eth_match NULL
>> +#endif
>> +
>>  static int sh_eth_drv_probe(struct platform_device *pdev)
>>  {
>>         int ret, devno = 0;
>> @@ -2403,7 +2462,17 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
>>         pm_runtime_enable(&pdev->dev);
>>         pm_runtime_resume(&pdev->dev);
>>
>> -       pd = (struct sh_eth_plat_data *)(pdev->dev.platform_data);
>> +       if (pdev->dev.of_node)
>> +               pd = sh_eth_parse_dt(&pdev->dev);
>> +       else
>> +               pd = pdev->dev.platform_data;
>> +
>> +       if (!pd) {
>> +               dev_err(&pdev->dev, "failed to obtain device info\n");
>> +               ret = -ENXIO;
>> +               goto out_release;
>> +       }
>> +
>>         /* get PHY ID */
>>         mdp->phy_id = pd->phy;
>>         mdp->phy_interface = pd->phy_interface;
>> @@ -2533,6 +2602,7 @@ static struct platform_driver sh_eth_driver = {
>>         .driver = {
>>                    .name = CARDNAME,
>>                    .pm = &sh_eth_dev_pm_ops,
>> +                  .of_match_table = sh_eth_match,
>>         },
>>  };
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Nobuhiro Iwamatsu
