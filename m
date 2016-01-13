From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 13 Jan 2016 14:07:55 +0000
Subject: Re: [RFC v2 2/4] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <56965A3B.60208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
 <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdUdxk6yjYAr3i7sjdMa-WJxrbOhsEz3JidY9aZVhaoURw@mail.gmail.com>
 <20160113125227.GD1540@katana>
In-Reply-To: <20160113125227.GD1540@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

Hello.

On 01/13/2016 03:52 PM, Wolfram Sang wrote:

>>> These bindings allow an I2C bus to switch between multiple masters. This
>>> is not hot-swichting because connected I2C slaves will be
>>> re-instantiated. It is meant to select the best I2C core at runtime once
>>> the task is known. Example: Prefer i2c-gpio over another I2C core
>>> because of HW errata affetcing your use case.
>>
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
>>> @@ -0,0 +1,155 @@
>>
>>> +Here is a snipplet for a bus to be demuxed. It contains various i2c clients for
>>
>> snippet
>>
>>> +HDMI, so the bus is named "i2c-hdmi":
>>> +
>>> +       i2chdmi: i2c@8 {
>>
>> Would it make sense to call the node "i2c-bus@8"?
>
> That sounds like a question for our EPapr expert Sergei (CCed) :)

    ePAPR only mentions "i2c". I'm not sure where the numeric part of the name 
comes from in this case...

[...]

MBR, Sergei

