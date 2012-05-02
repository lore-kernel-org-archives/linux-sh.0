From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 02 May 2012 21:03:53 +0000
Subject: Re: [PATCH v3 02/10] ARM: sh-mobile: mackerel: Add error IRQ resource
Message-Id: <CANqRtoT1cJ2uMZ+hqDO74681x2-5zMF16jyyDZh33USns4f8FA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335951710-9390-3-git-send-email-hechtb@gmail.com>
 <201205022249.30426.rjw@sisk.pl>
In-Reply-To: <201205022249.30426.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Brian Norris <computersforpeace@gmail.com>, Bastian Hecht <hechtb@googlemail.com>

2012/5/3 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday, May 02, 2012, Bastian Hecht wrote:
>> Supply the platform data for the FLSTEI error IRQ.
>>
>> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>
> I'm going to take this patch into the renesas.git tree and push it
> upstream throuch arm-soc, if that's not a problem.

Sure, that's fine. Seems like a rather clear case of a mach-shmobile
patch without any special dependencies.

Cheers,

/ magnus
