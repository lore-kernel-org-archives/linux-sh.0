From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2015 02:20:04 +0000
Subject: Re: [PATCH 04/05] serial: sh-sci: Add SCIFA/SCIFB CTS/RTS pin setup
Message-Id: <CANqRtoT9DYTFa9mnm=oiP+1f=4FqKqX3VmKCmXNQngpUb3Br3g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217125236.14480.78833.sendpatchset@w520>
	<20141217125315.14480.15475.sendpatchset@w520>
	<1784675.cFO7ikSQzd@avalon>
In-Reply-To: <1784675.cFO7ikSQzd@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, linux-serial@vger.kernel.org

Hi Laurent,

On Sun, Jan 4, 2015 at 11:46 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Wednesday 17 December 2014 21:53:15 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Add SCIFA/SCIFB pin setup code for CTS/RTS pins to handle
>> both cases of hardware flow control enabled or disabled.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  drivers/tty/serial/sh-sci.c |   60 +++++++++++++++++++++++++++++++++++++++-
>>  include/linux/serial_sci.h  |    2 +
>>  2 files changed, 61 insertions(+), 1 deletion(-)
>>
>> --- 0006/drivers/tty/serial/sh-sci.c
>> +++ work/drivers/tty/serial/sh-sci.c  2014-12-16 16:10:18.000000000 +0900

>> +     control = serial_port_in(port, SCPCR);
>> +     data = serial_port_in(port, SCPDR);
>> +
>> +     if (hwflow_enabled) {
>> +             control &= ~(BIT(4) | BIT(3));
>> +     } else {
>> +             control |= BIT(4) | BIT(3);
>
> Could you please define SCPCR_RTSC and SCPCR_CTSC macros to replace BIT(3) and
> BIT(4) ?
>
>> +             data |= BIT(4);
>
> And SCPDR_RTSD here ?

Sure, that makes sense. I've included this update in V2. Sorry for
being a bit lazy in V1. =)

/ magnus
