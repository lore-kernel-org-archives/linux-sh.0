From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 27 Jan 2014 19:06:26 +0000
Subject: Re: [PATCH] phy-rcar-usb-gen2: add device tree support
Message-Id: <52E6AE32.5050906@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-6-git-send-email-ben.dooks@codethink.co.uk> <1390755901-3743-1-git-send-email-ben.dooks@codethink.co.uk> <52E6A436.5090408@cogentembedded.com>
In-Reply-To: <52E6A436.5090408@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org

On 27/01/14 18:23, Sergei Shtylyov wrote:
> Hello.
>
> On 01/26/2014 08:05 PM, Ben Dooks wrote:

[snip]

>>
>> +static struct of_device_id rcar_gen2_usb_phy_ofmatch[] = {
>> +    { .compatible = "renesas,usb-phy-r8a7790", },
>> +    { .compatible = "renesas,rcar-gen2-usb-phy", },
>
>     Frankly speaking, I don't understand the need for the clearly
> duplicate entries.

Thanks, will look into remove it.
Anyone else have any comments on this?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
