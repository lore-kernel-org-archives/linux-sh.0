From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 25 Jan 2015 11:10:09 +0000
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix R-Car SCIF and HSCIF overrun handling
Message-Id: <CAH1o70+upGsSNHOsausd91GLQ-sf_Sjyv3_ghN_W9Uo54sTxLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418652883-6884-1-git-send-email-ykaneko0929@gmail.com>
	<CABMQnV+Oh8Ctd9jM-7qaW4ZfuQJ_++fZkHYuKBL2ftQkrzAOjw@mail.gmail.com>
In-Reply-To: <CABMQnV+Oh8Ctd9jM-7qaW4ZfuQJ_++fZkHYuKBL2ftQkrzAOjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh <linux-sh@vger.kernel.org>

Hi,

Thanks for your review.

2015-01-22 13:51 GMT+09:00 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>:
> Hi,
>
> 2014-12-15 23:14 GMT+09:00 Yoshihiro Kaneko <ykaneko0929@gmail.com>:
>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>>
>> When fifo overrun happened, the interrupt status refers to
>> SCLSR register in R-Car SCIF and HSCIF.
>> Thus, overrun handling takes SCLSR register into account.
>>
>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>>
>> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
>> tree.
>>
>>  drivers/tty/serial/sh-sci.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 1110523..ff549a8 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -793,8 +793,6 @@ static int sci_handle_errors(struct uart_port *port)
>>                 /* overrun error */
>>                 if (tty_insert_flip_char(tport, 0, TTY_OVERRUN))
>>                         copied++;
>> -
>> -               dev_notice(port->dev, "overrun error\n");
>>         }
>>
>>         if (status & SCxSR_FER(port)) {
>> @@ -835,8 +833,6 @@ static int sci_handle_errors(struct uart_port *port)
>>
>>                 if (tty_insert_flip_char(tport, 0, TTY_PARITY))
>>                         copied++;
>> -
>> -               dev_notice(port->dev, "parity error\n");
>>         }
>
> I think that these fixis unrelated to support of HSCIF.
> Please split patch.

I got it.
I'll update this patch.

Thanks,
Kaneko

>
> Best regards,
>   Nobuhiro
>
>
> --
> Nobuhiro Iwamatsu
