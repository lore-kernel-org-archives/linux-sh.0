From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 May 2014 06:23:25 +0000
Subject: Re: [PATCH v2 04/05] staging: board: Initial board staging support
Message-Id: <CANqRtoThLHgsbU-zbmpAtYq+mYuD126Shm3ZiVdZzm84XD2WZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140529131650.2329.3197.sendpatchset@w520>
	<20140529131732.2329.50630.sendpatchset@w520>
	<20140529132034.GB15585@mwanda>
	<CANqRtoTzOn5d9qB85sXvmLYhoTDMDtbjSkLbz9V4FRmzFM3ycQ@mail.gmail.com>
	<CANqRtoQDQLsWOyRSbQmtbmJc_qO=5X3ZMK12ZuwZ-FSR1iWCog@mail.gmail.com>
	<1401372183.25908.3.camel@x220>
In-Reply-To: <1401372183.25908.3.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>, devel <devel@driverdev.osuosl.org>, SH-Linux <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>

On Thu, May 29, 2014 at 11:03 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Thu, 2014-05-29 at 22:53 +0900, Magnus Damm wrote:
>> --- 0011/drivers/staging/board/Kconfig
>> +++ work/drivers/staging/board/Kconfig    2014-05-29 22:32:39.000000000 +0900
>> @@ -1,5 +1,6 @@
>>  config STAGING_BOARD
>>      boolean "Staging Board Support"
>> +    depends on OF && OF_ADDRESS
>
> I have no idea what this is all about, but wouldn't just OF_ADDRESS be
> enough here (as OF_ADDRESS depends on OF)?

Yeah, that makes sense. I am also considering stubbing in the missing
function prototypes in the header files to be able to get rid of this
dependency.

Cheers,

/ magnus
