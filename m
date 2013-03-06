From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Mar 2013 06:42:00 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-r8a7779: add DIV4 clock support
Message-Id: <CANqRtoSjhLK1CNpYx4TSOaKHMJO5M629p3gYHRk+xFcdpMFPHg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wed, Mar 6, 2013 at 1:56 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Magnus
>
>> > Current R8A7778 clock is using temporary setting as quick hack.
>> > To correct it, this patch adds PLL-A and DIV4 clocks
>> >
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > ---
>> >
>> > This patch is based on my previous R-Car M1A patch set
>> >
>> >  arch/arm/mach-shmobile/clock-r8a7778.c |  107 ++++++++++++++++++++++++--------
>> >  1 file changed, 82 insertions(+), 25 deletions(-)
>>
>> Uhm, you probably noticed already, but your patch subject says
>> "r8a7779" but the actual patch is for"r8a7778"..
>
> Grr.. sorry about it.
> I send v2

Thanks.

>> Regarding MD pins I believe r8a7779 has a MODEMR register where you
>> can read the MD pin settings. How about r8a7778?
>
> Yeah, I found it.
> But it is not needed,  becouse FRQMR showed the clcok division rate
> for each clocks

Ok, does that include "clkz" too? On r8a7779 "clkz" and "clkzs" are
not visible in FRQMR, but I believe they are needed for TWD support.
Do you have any plan to include "smp_twd" clock support for the TWD
timer driver?

Thanks,

/ magnus
