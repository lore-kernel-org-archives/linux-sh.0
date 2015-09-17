From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 12:41:18 +0000
Subject: Re: [PATCH v2 09/11] devicetree: bindings: Remove unused 32-bit CMT bindings
Message-Id: <CANqRtoQ1UUdz1FoqrqkXAj6F9gudOfvgi-vDuAXxDs6Hy3wuXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
	<20150917095452.5369.320.sendpatchset@little-apple>
	<55FAAEA8.1050102@cogentembedded.com>
In-Reply-To: <55FAAEA8.1050102@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, SH-Linux <linux-sh@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Sergei,

On Thu, Sep 17, 2015 at 9:14 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 9/17/2015 12:54 PM, Magnus Damm wrote:
>
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Remove the 32-bit CMT compat strings to reduce maintenance burden.
>>
>> It should be fine to break DT compatibility because the 32-bit
>> 32-bit CMT DT binding was never part of any upstream DTS file.
>
>
>    Nit: "32-bit" repeated twice.

Oops, will fix, thanks for reporting!

Cheers,

/ magnus
