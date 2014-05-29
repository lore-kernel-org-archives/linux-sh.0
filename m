From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 May 2014 13:27:30 +0000
Subject: Re: [PATCH v2 04/05] staging: board: Initial board staging support
Message-Id: <CANqRtoTzOn5d9qB85sXvmLYhoTDMDtbjSkLbz9V4FRmzFM3ycQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140529131650.2329.3197.sendpatchset@w520>
	<20140529131732.2329.50630.sendpatchset@w520>
	<20140529132034.GB15585@mwanda>
In-Reply-To: <20140529132034.GB15585@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, devel <devel@driverdev.osuosl.org>, SH-Linux <linux-sh@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>

Hi Dan,

On Thu, May 29, 2014 at 10:20 PM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> On Thu, May 29, 2014 at 10:17:32PM +0900, Magnus Damm wrote:
>> --- /dev/null
>> +++ work/drivers/staging/board/Kconfig        2014-05-29 21:40:41.000000000 +0900
>> @@ -0,0 +1,7 @@
>> +config STAGING_BOARD
>> +     boolean "Staging Board Support"
>> +     help
>> +       Select to enable per-board staging support code.
>> +
>> +       If in doubt, say N here.
>> +
>
> Actually, you're probably going to need to add a bunch of dependencies
> here or it will break "make randconfig" right away.  Sorry that I forgot
> about this in the first review.

Good point, thanks for checking. I will have a look at this and add
dependencies to make sure it builds on a wide range of platforms.

Regarding the emxx_udc portion of the patches (in the v2 series patch
1 -> 3), if there are no objections would it be possible for you to
take them as-is? If so I'll resend the staging board bits only.

Thanks!

/ magnus
