From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 21:44:34 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: Use shmobile_init_delay() on r7s72100
Message-Id: <CANqRtoTmB_BaG=C8nwwr8=u5kGhNectoYY_7TeTqeQLReey74w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140224073006.3522.95891.sendpatchset@w520>
In-Reply-To: <20140224073006.3522.95891.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Jun 5, 2014 at 5:22 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Thu, Jun 5, 2014 at 8:47 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Adjust Genmai board support to use shmobile_init_delay() together
>> with r7s72100 CPU Frequency settings from the DTS.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  arch/arm/mach-shmobile/board-genmai-reference.c |    2 +-
>>  arch/arm/mach-shmobile/board-genmai.c           |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> The contents of this patch are identical to "[PATCH 02/03] ARM: shmobile:
> Use shmobile_init_delay() on Genmai boards"?
>
> I had expected it to touch arch/arm/mach-shmobile/setup-r7s72100.c and
> arch/arm/mach-shmobile/include/mach/r7s72100.h.

I was about to explain how the patches are split this way between SoC
and board because ARM SoC likes to merge things that way, but now I
realize that you are telling me that I sent the wrong patch. =)

Thanks for pointing this out. I will fix up and resend (hopefully the
right code this time).

Cheers,

/ magnus
