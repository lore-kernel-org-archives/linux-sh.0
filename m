From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 11:01:53 +0000
Subject: Re: [PATCH 02/03] ARM: shmobile: sh73a0: Add Multiplatform support
Message-Id: <CANqRtoSYT1UaZbtJK51G7UpK+COnFLqzj0TH2_o01j2g7Cf34w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904022856.26216.25574.sendpatchset@w520>
In-Reply-To: <20140904022856.26216.25574.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, Sep 4, 2014 at 3:51 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Sep 04, 2014 at 11:28:56AM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Enable sh73a0 Multiplatform support for the generic sh73a0
>> machine vector. No board support is enabled, and the board
>> code for KZM9G DT Reference is left by itself.
>
> This appears to overlap with:
>
> [PATCH v2 03/10] ARM: shmobile: sh73a0: common clock framework board support

So it seems. I propose that Ulrich will focus on getting the sh73a0
drivers/clk bits merged, while I fix up the generic sh73a0
multiplatform support in parallel.

Can you make sure the CMT bits get sorted out independently?

Thanks,

/ magnus
