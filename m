From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Nov 2013 08:40:37 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: mark GPIO keys as wake-up sources
Message-Id: <CANqRtoQtEUubECP9gtXtEnazrHzaABpG4pmVKenRr4Yh5t76WA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131113224026.20904.35898.sendpatchset@w520>
 <20131114062639.GA2292@verge.net.au>
In-Reply-To: <20131114062639.GA2292@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Thu, Nov 14, 2013 at 3:26 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Nov 14, 2013 at 07:40:26AM +0900, Magnus Damm wrote:
>> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>
>> Enable wakeup for the GPIO keys on the Lager board.
>>
>> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Hi Magnus,
>
> is this relevant to other boards too?

Yes, but I'd like to add the missing pieces for Suspend-to-RAM to
other SoCs too before trying to do that. If you want to give it a go,
why don't you try to enable it on r8a7779 and Marzen?

Thanks,

/ magnus
