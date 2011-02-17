From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 17 Feb 2011 06:51:44 +0000
Subject: Re: [RFC, PATCH 2/4] net: sh_eth: remove the SH_TSU_ADDR
Message-Id: <4D5CC580.9080905@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D5A67CF.3040406@renesas.com>
 <AANLkTimJM0yEOU6RgoAs+Njv5b7ixVRnPubnUg=F72GX@mail.gmail.com>
In-Reply-To: <AANLkTimJM0yEOU6RgoAs+Njv5b7ixVRnPubnUg=F72GX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: netdev@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

2011/02/17 9:24, Nobuhiro Iwamatsu wrote:
>> @@ -1559,7 +1565,9 @@ out:
>>  static int sh_eth_drv_remove(struct platform_device *pdev)
>>  {
>>        struct net_device *ndev = platform_get_drvdata(pdev);
>> +       struct sh_eth_private *mdp = netdev_priv(ndev);
>>
>> +       iounmap(mdp->tsu_addr);
>>        sh_mdio_release(ndev);
>>        unregister_netdev(ndev);
>>        pm_runtime_disable(&pdev->dev);
> 
> You forget to fix for ARSTR.
Thank you for your point! I will fix it.

Best regards,
Yoshihiro Shimoda
