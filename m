From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 26 Jan 2014 17:08:20 +0000
Subject: Re: [PATCH 5/8] phy-rcar-usb-gen2: add device tree support
Message-Id: <52E54104.8070100@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk> <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk> <52E54DF6.5070601@cogentembedded.com>
In-Reply-To: <52E54DF6.5070601@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org

On 26/01/14 18:03, Sergei Shtylyov wrote:
> Hello.
>
> On 01/26/2014 07:49 PM, Ben Dooks wrote:
>
>> Add support for the phy-rcar-gen2-usb driver to be probed from device
>> tree.
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>> ---
>> Fixes from v1:
>>     - use of_property_reasd-bool()
>>     - remove unused of_id variable
>
>> Cc: linux-usb@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: devicetree@vger.kernel.org
>> ---
>>   drivers/usb/phy/phy-rcar-gen2-usb.c | 31
>> ++++++++++++++++++++++++++-----
>>   1 file changed, 26 insertions(+), 5 deletions(-)
>
>> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c
>> b/drivers/usb/phy/phy-rcar-gen2-usb.c
>> index db3ab34..d146388 100644
>> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
>> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
> [...]
>> @@ -203,16 +210,29 @@ static int rcar_gen2_usb_phy_probe(struct
>> platform_device *pdev)
> [...]
>> +    if (of_id) {
>
>     You've removed the variable but not its use. Have you tried to
> compile this patch?

Thanks, already noticed that and produced v3.

I should not be let near git-rebase when hungry.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
