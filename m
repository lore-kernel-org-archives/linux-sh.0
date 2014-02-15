From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 15 Feb 2014 00:03:25 +0000
Subject: Re: [PATCH v3] sh_eth: add device tree support
Message-Id: <52FEBCDC.2030508@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402060258.57025.sergei.shtylyov@cogentembedded.com> <1591086.qftVlE1XBX@avalon>
In-Reply-To: <1591086.qftVlE1XBX@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nobuhiro.iwamatsu.yj@renesas.com, rob@landley.net, linux-doc@vger.kernel.org

Hello.

On 02/11/2014 07:08 PM, Laurent Pinchart wrote:

> Thanks a lot for the patch. DT support for sh-eth was number one on my most
> wanted list :-)

    It's been available for several months already (though just for BOCK-W).
Since the clock DT support turned to be the requirement, I had to change to 
Lager/Koelsch where CCF is already available.

> Please see below for two minor comments.

    Thanks.
    Sigh, I had to scroll thru quite a lot of uncommented text to find them. 
Please trim such text in the future to save the readers' time.

>> Add support of the device tree probing for the Renesas SH-Mobile SoCs
>> documenting the device tree binding as necessary.

>> This work is loosely based on the original patch by Nobuhiro Iwamatsu
>> <nobuhiro.iwamatsu.yj@renesas.com>.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

>> Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
>> =================================>> --- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
>> +++ net-next/drivers/net/ethernet/renesas/sh_eth.c
[...]
>> @@ -2710,6 +2714,56 @@ static const struct net_device_ops sh_et
>>   	.ndo_change_mtu		= eth_change_mtu,
>>   };
>>
>> +#ifdef CONFIG_OF
>> +static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct sh_eth_plat_data *pdata;
>> +	struct device_node *phy;
>> +	const char *mac_addr;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return NULL;
>> +
>> +	pdata->phy_interface = of_get_phy_mode(np);
>> +
>> +	phy = of_parse_phandle(np, "phy-handle", 0);
>> +	if (of_property_read_u32(phy, "reg", &pdata->phy)) {
>> +		devm_kfree(dev, pdata);

> No need to free memory here, this will be handled by the core after the
> probe() function fails.

    OK, we should fail the probe when we return NULL from here.

>> +		return NULL;
>> +	}
[...]
>> @@ -2778,7 +2834,19 @@ static int sh_eth_drv_probe(struct platf
>>   	mdp->ether_link_active_low = pd->ether_link_active_low;
>>
>>   	/* set cpu data */
>> -	mdp->cd = (struct sh_eth_cpu_data *)id->driver_data;
>> +	if (id) {
>> +		mdp->cd = (struct sh_eth_cpu_data *)id->driver_data;
>> +	} else	{
>> +		const struct of_device_id *match;
>> +
>> +		match = of_match_device(of_match_ptr(sh_eth_match_table),
>> +					&pdev->dev);
>> +		if (!match) {
>> +			ret = -EINVAL;
>> +			goto out_release;
>> +		}

> You can probably remove error checking, if no match is found the probe
> function wouldn't have been called in the first place.

    Yes, you seem to be correct here as well.

WBR, Sergei

