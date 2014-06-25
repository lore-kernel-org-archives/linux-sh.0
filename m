From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Jun 2014 09:32:47 +0000
Subject: Re: [PATCH v2 01/07] ARM: shmobile: Allow use of boot code for non-SMP case
Message-Id: <CANqRtoTeoBitPgTytzU+gh2s8P2XtY_yZGCnBVNFbxONeJCR8w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606072010.14868.5474.sendpatchset@w520>
In-Reply-To: <20140606072010.14868.5474.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Jun 25, 2014 at 5:04 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 06, 2014 at 04:20:10PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Allow build of platsmp.c and headsmp.S even though
>> SMP is disabled in the kernel configuration. With
>> this in place it is possible to share the reset
>> vector setup code with power management code that
>> needs to be built even though SMP is disabled.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Hi Magnus,
>
> could you let me know what the status of this series is.
> Should I queue it up?

I think Komayashi-san did some testing earlier (thanks), and in my
mind the series is a step in the right direction. So please queue it
up!

Cheers,

/ magnus
