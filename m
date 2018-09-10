From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 10 Sep 2018 19:12:14 +0000
Subject: Re: [PATCH 2/2] clocksource: sh_cmt: add R-Car gen3 support
Message-Id: <cbcd513a-caba-a804-110d-acd5432a2698@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3ce24bfe-1edb-1a92-8847-ff998ac86d16@cogentembedded.com>
 <dc0446c7-e63b-17f1-45ed-e544b5602b9e@cogentembedded.com>
 <OSBPR01MB21036C90B39B5ADB56A7DD8EB8010@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB21036C90B39B5ADB56A7DD8EB8010@OSBPR01MB2103.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Biju Das <biju.das@bp.renesas.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hello!

On 09/06/2018 11:27 AM, Biju Das wrote:

>> -----Original Message-----
>> From: devicetree-owner@vger.kernel.org <devicetree-
>> owner@vger.kernel.org> On Behalf Of Sergei Shtylyov
>> Sent: 05 September 2018 21:32
>> To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
>> <tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>;
>> devicetree@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org; linux-sh@vger.kernel.org
>> Subject: [PATCH 2/2] clocksource: sh_cmt: add R-Car gen3 support
>>
>> Add support for the R-Car gen3 CMT0 and CMT1 bindings -- they seem to be
>> the same CMT0 and CMT1 as in R-Car gen2 SoCs. Also document R8A779{7|8}
>> bindings as these are the R-Car gen3 SoCs for which the initial support was
>> done.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  Documentation/devicetree/bindings/timer/renesas,cmt.txt |    7 +++++++
>>  drivers/clocksource/sh_cmt.c                            |    8 ++++++++
>>  2 files changed, 15 insertions(+)
>>
>> Index: renesas/Documentation/devicetree/bindings/timer/renesas,cmt.txt
>> =============================
>> ====>> --- renesas.orig/Documentation/devicetree/bindings/timer/renesas,cmt.txt
>> +++ renesas/Documentation/devicetree/bindings/timer/renesas,cmt.txt
>> @@ -34,6 +34,10 @@ Required Properties:
>>      - "renesas,r8a7793-cmt1" for the 48-bit CMT1 device included in r8a7793.
>>      - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
>>      - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
>> +    - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in
>> r8a77970.
>> +    - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in
>> r8a77970.
>> +    - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in
>> r8a77980.
>> +    - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in
>> r8a77980.
>>
>>      - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2
>>  and RZ/G1.
>> @@ -41,6 +45,9 @@ Required Properties:
>>  and RZ/G1.
>>  These are fallbacks for r8a73a4, R-Car Gen2 and RZ/G1
>> entries
>>  listed above.
>> +    - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car
>> Gen3.
>> +    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car
> 
>  Do we need to mention CMT1/2/3 instead of CMT1, since CMT2/3 is similar to CMT1?

   Well, the manual only describes CMT0 and CMT1 separately. Perhaps it would have been
clearer to call them CMTT0 and CMTT1 as they stand for Compare Match Timer Type 0/1?
Note at this point we already have a history of describing CMT0/1 only in the bindings
as well...

[...]

MBR, Sergei
