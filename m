From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 10 Sep 2018 19:30:11 +0000
Subject: Re: [PATCH 2/2] clocksource: sh_cmt: add R-Car gen3 support
Message-Id: <8cbf8657-8213-5772-1d32-cc9d2bb139c7@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3ce24bfe-1edb-1a92-8847-ff998ac86d16@cogentembedded.com>
 <dc0446c7-e63b-17f1-45ed-e544b5602b9e@cogentembedded.com>
 <TYAPR01MB228578C6DE61F93B96761B40B7010@TYAPR01MB2285.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB228578C6DE61F93B96761B40B7010@TYAPR01MB2285.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Paterson <Chris.Paterson2@renesas.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hello!

On 09/06/2018 11:06 AM, Chris Paterson wrote:

>> From: devicetree-owner@vger.kernel.org <devicetree-
>> owner@vger.kernel.org> On Behalf Of Sergei Shtylyov
>> Sent: 05 September 2018 21:32
>>
>> Add support for the R-Car gen3 CMT0 and CMT1 bindings -- they seem to be
>> the same CMT0 and CMT1 as in R-Car gen2 SoCs. Also document R8A779{7|8}
>> bindings as these are the R-Car gen3 SoCs for which the initial support was
>> done.
> 
> Is it allowed to combine the bindings doc update with the driver change? (I usually get a checkpatch warning for this).

   I don't (and have double checked that this patch is checkpatch-clean).

> It it's not a problem:

   Let's hear what Rob says...
   However note that Documentation/devicetree/bindings/timer/ is
listed under the CLOCKSOURCE, CLOCKEVENT DRIVERS entry in MAINTAINERS. 

> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

   Thank you!

> Kind regards, Chris

MBR, Sergei
