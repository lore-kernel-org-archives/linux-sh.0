From: Rob Herring <robherring2@gmail.com>
Date: Thu, 01 May 2014 01:02:10 +0000
Subject: Re: [PATCH 4/6] i2c: sh_mobile: add devicetree documentation
Message-Id: <CAL_JsqKgwKjag2hRSaDwoejuXRDxDgWwtpnS1gijQbVo0h_MjQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
	<1398896470-24663-5-git-send-email-wsa@the-dreams.de>
	<CAMuHMdWP8KH=6OKmBbA5UqixV7mdKZdEhFw8Tq_XZLaJCOQ07w@mail.gmail.com>
In-Reply-To: <CAMuHMdWP8KH=6OKmBbA5UqixV7mdKZdEhFw8Tq_XZLaJCOQ07w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Apr 30, 2014 at 5:32 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Wolfram,
>
> CC devicetree
>
> On Thu, May 1, 2014 at 12:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>  .../devicetree/bindings/i2c/i2c-sh_mobile.txt      | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
>> new file mode 100644
>> index 000000000000..d2153ce36fa8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
>> @@ -0,0 +1,26 @@
>> +Device tree configuration for Renesas IIC (sh_mobile) driver
>> +
>> +Required properties:
>> +- compatible      : "renesas,iic-<soctype>". "renesas,rmobile-iic" as fallback
>
> Please also list all supported values, so checkpatch can validate DTS compatible
> properties against this binding document.

You could add this pattern to checkpatch as well. I really wish
Renesas would follow normal convention of <vendor>,<chip>-<device>.

Rob
