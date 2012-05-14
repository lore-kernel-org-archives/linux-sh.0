From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 14 May 2012 06:13:57 +0000
Subject: Re: [PATCH v2 5/5] net: sh_eth: use NAPI
Message-Id: <4FB0A2A5.3060001@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FACD007.1070308@renesas.com>
 <1336750529.2874.69.camel@bwh-desktop.uk.solarflarecom.com>
In-Reply-To: <1336750529.2874.69.camel@bwh-desktop.uk.solarflarecom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: netdev <netdev@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>

2012/05/12 0:35, Ben Hutchings wrote:
> On Fri, 2012-05-11 at 17:38 +0900, Shimoda, Yoshihiro wrote:
>> This patch modifies the driver to use NAPI.
> [...]
>> +static int sh_eth_poll(struct napi_struct *napi, int budget)
>> +{
< snip >
>> +	/* check whether the controller doesn't have any events */
>> +	if (!txfree_num && !(intr_status & cd->eesr_err_check) &&
>> +	    work_done < budget) {
>> +		napi_complete(napi);
> 
> If and only if you return a value less than the budget then you *must*
> call napi_complete().  You can't add these extra conditions.

Thank you for the point. I will fix it.

< snip >
> 
> You will also need to call napi_disable() and napi_enable() in the
> set_ringparam implementation.

I will add the code in sh_eth_set_ringparam().

> Ben.
> 

Best regards,
Yoshihiro Shimoda
