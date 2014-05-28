From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 28 May 2014 01:12:10 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <538537EA.5080909@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com> <53845B05.80900@renesas.com> <5384E9BC.8090202@cogentembedded.com>
In-Reply-To: <5384E9BC.8090202@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "kishon@ti.com" <kishon@ti.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "rdunlap@infradead.org" <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hello,

(2014/05/28 4:38), Sergei Shtylyov wrote:
> Hello.
> 
> On 05/27/2014 01:29 PM, Yoshihiro Shimoda wrote:
< snip >
>> So, before I tested this driver, I changed the "hsusb" to "usbhs".
>> Otherwise, the devm_clk_get() in the driver failed.
> 
>     This is very strange, the driver works OK for me.
> 

I'm sorry, my report was wrong.
The driver works OK for me too, when I tested the driver using "usbhs" today.
And, I was not able to duplicate an issue I reported yesterday.
So, maybe my test environment was wrong...

Best regards,
Yoshihiro Shimoda
