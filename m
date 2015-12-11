From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 11 Dec 2015 14:44:45 +0000
Subject: Re: [PATCH] extcon-usb-gpio: add enable pin support
Message-Id: <566AE15D.1020506@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4393960.B6dD3UkQy3@wasted.cogentembedded.com>
 <566A4B97.7080801@samsung.com>
In-Reply-To: <566A4B97.7080801@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 12/11/2015 07:05 AM, Chanwoo Choi wrote:

>> Sometimes  there's a real  OTG chip behind the USB ID signal mapped to a GPIO
>> pin: in my case it's Maxim Integrated MAX3355E which  integrates Vbus charge
>> pump and comparators and passes  thru the ID  signal  from an OTG connector.
>
> s/thru/through ?

    "Thru" is valid English.

>> This chip also has the SHDN# pin which  should be  driven high for the normal
>> operation  and low to  save power;  it  is connected to a GPIO pin as well on,
>> hence  we'll have  to  teach the driver to parse the new optional device tree
>> property, "enable-gpio"...

> This patch description includes the double space between words. Also, I think

    So what?

> you need to write the patch description again for formal style.

    Not sure I understand you.

> This patch adds the specific 'enable-gpio' pin to express the SHDN#pin for MAX3355E.
> I think it is not regular and standard case because maybe USB specification
> don't include the SHDN#pin information.

    Certainly, it's not a USB pin.

> I think it not appropriate way.
> Instead, you better to make the MAX3355 extcon driver to support this case.

    OK, just didn't want to duplicate most of this driver there...

> Thanks,
> Chanwoo

MBR, Sergei

