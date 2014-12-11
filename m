From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Dec 2014 12:47:32 +0000
Subject: Re: [PATCH] extcon: add MAX3355 driver
Message-Id: <54899264.30009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <14631865.01KLlU2iKL@wasted.cogentembedded.com> <5488F775.1030304@samsung.com>
In-Reply-To: <5488F775.1030304@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 12/11/2014 4:46 AM, Chanwoo Choi wrote:

> I reviewed this patch quickly. This driver has just two gpio without any registers for IP.

    Because there are no registers.

> I wonder whether MAX3355E is separate chip to detect external connector

    Yes. I thought my description has made that clear...

> or just use gpio of AP.

    What do you mean by AP?
    MAX3355 is indeed partly connected to GPIOs and partly to the USB pins.

> Could you send the datasheet of MAX3355E to me?

    Looks like Geert has beaten me to it. :-)

> Thanks,
> Chanwoo Choi

WBR, Sergei

