From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 12 Apr 2013 14:26:20 +0000
Subject: Re: [PATCH] sh-pfc: R8A7779: add VIN pin groups
Message-Id: <5168198C.90709@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304120251.38652.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304120251.38652.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 12-04-2013 8:33, Kuninori Morimoto wrote:

> Thank you for your patch

    It's not mine. :-)

>> +/* - VIN0 ------------------------------------------------------------------- */
>> +static const unsigned int vin0_data8_pins[] = {
>> +	/* D[0:7] */
>> +	70, 71, 72, 73, 74, 75, 76, 77,
>> +};

> Can you use RCAR_GP_PIN() macro on this patch ?

> 0bd898b16cdc0a4512d0b1af2fbe1174d217dd2d
> (gpio-rcar: Add RCAR_GP_PIN macro)

    I think there should be a wholesale conversion patch for all this file.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei

