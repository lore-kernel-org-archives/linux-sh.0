From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 15 Dec 2013 14:58:19 +0000
Subject: Re: [PATCH v5 06/17] ARM: shmobile: lager-reference: Enable multiplaform kernel support
Message-Id: <52ADC38B.9040009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387034741-3852-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387034741-3852-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 15-12-2013 17:09, Geert Uytterhoeven wrote:

>> +config ARCH_R8A7790
>> +       bool "R-Car H2 (R8A77900)"

> Is the trailing "0" intentional?

>> +       select RENESAS_IRQC
>> +
>>   config ARCH_R8A7791
>>          bool "R-Car M2 (R8A77910)"

> Same here.

    Yes, it's the full model numbers.

> Gr{oetje,eeting}s,
>
>                          Geert

WBR, Sergei

