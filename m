From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 18 Dec 2015 13:45:05 +0000
Subject: Re: [PATCH v3] extcon: add Maxim MAX3355 driver
Message-Id: <56740DE1.8040301@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2473780.4IzuWX8hE2@wasted.cogentembedded.com>
 <CAJKOXPfD8DnDow04_wyRyGk+8zBmT15giDS+WDcV+pFaWSypGw@mail.gmail.com>
 <5672C884.3000603@cogentembedded.com> <56735125.1040304@samsung.com>
In-Reply-To: <56735125.1040304@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 12/18/2015 3:19 AM, Krzysztof Kozlowski wrote:

[...]

>>> Please pass the source through recent coccicheck and fix the findings.
>>
>>     Has it been included in the kernel source somewhere already?
>
> The rules detecting the unnecessary owner should be there for some time
> (sice 4.2 or 4.1?). The coccicheck is in kernel - scripts/coccicheck. It

    Found it already.

> uses coccinelle/spatch.

    Installed it.

> You can run it just like other code-checker
> tools - sparse and smatch.

    I tried but couldn't figure out how to confine 'make coccicheck'only to 
the files I need.

> Best regards,
> Krzysztof

MBR, Sergei

