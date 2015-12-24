From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Thu, 24 Dec 2015 17:16:23 +0000
Subject: Re: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Message-Id: <CAKfKVtEmsrQT6x2p=Knz836iNXw3vwQyx1M_WJ=GJjVDgBjWFA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
	<CAKfKVtHt8BpakkffRp=_2GUxqK5JO0WCsizCrjtwH5hv+TWvWg@mail.gmail.com>
	<20151224084105.GA1548@katana>
In-Reply-To: <20151224084105.GA1548@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

>
>> Also maybe we can add a flag that the driver enables.
>> that way for a short period till the driver removes the call
>> the double call is not there.
>
> The only driver I found was the s3c2410 and I fixed it. Is there another
> one? Then, I'd update my series because I want a consistent state in one
> go.
>
I think the below drivers

drivers/i2c/busses/i2c-at91.c
drivers/i2c/busses/i2c-designware-core.c
drivers/i2c/busses/i2c-designware-platdrv.c
drivers/i2c/busses/i2c-rcar.c
drivers/i2c/busses/i2c-sh_mobile.c
drivers/i2c/busses/i2c-hix5hd2.c
drivers/i2c/busses/i2c-nomadik.c
drivers/i2c/busses/i2c-omap.c
drivers/i2c/busses/i2c-qup.c
drivers/i2c/busses/i2c-s3c2410.c
