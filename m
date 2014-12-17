From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 17 Dec 2014 11:35:30 +0000
Subject: Re: [PATCH] usb: hcd: add OTG ID signal sensing
Message-Id: <54916A82.4010105@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3663198.HSrURZGche@wasted.cogentembedded.com> <BN3PR0301MB08495DD76B65E14BDE460E42816D0@BN3PR0301MB0849.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR0301MB08495DD76B65E14BDE460E42816D0@BN3PR0301MB0849.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Chen <Peter.Chen@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello.

On 12/17/2014 5:08 AM, Peter Chen wrote:

>> On the Renesas R8A7791 SoC based boards there's MAX3355 USB OTG chip and
>> mini-AB USB connector corresponding to USB port 0 driven either by EHCI/OHCI
>> or  Renesas USBHS gadget controller. And we'd like the  host/gadget drivers to
>> work based on the cable type connected. An 'extcon' driver for MAX3355 has
>> been written, so we only need to bind  to it via device tree which I'm doing in
>> this patch.

>> I wasn't able to find a solution better than checking the cable type at the host
>> driver probe time and refusing to drive a host if B-cable is connected.

> You may need a dual-role/otg driver to do it, which can enable host/device function
> according to ID pin.

    It would have been too good if I had a dual-role controller. :-)
    But I have what I have. IIUC, such configuration (OHCI and UDC sharing a 
USB port) has been used on OMAP1.

WBR, Sergei

