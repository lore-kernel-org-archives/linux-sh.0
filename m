From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Feb 2013 04:15:59 +0000
Subject: Re: [PATCH v2 5/8] ARM: shmobile: add sh73a0-specific timer initialisation to kzm9g-reference
Message-Id: <CANqRtoRWhSncOm7rP3wwY3We2M+HQCzXM8P1UzPVQ6EmbvrM_w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Feb 13, 2013 at 12:46 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Feb 08, 2013 at 07:38:29PM +0100, Guennadi Liakhovetski wrote:
>> This patch fixes failing boot of the kzm9g-reference kernel.
>
> Magnus specifically asked for the DT reference code not to use
> early timers.
>
> As you have no doubt observed the current code doesn't work with SMP.
> I have not been able to find a solution that does work with CONFIG_SMP
> enabled without using early timers. I would welcome some ideas
> on how to resolve this problem without using early timers.

I have now tracked down and submitted a fix for the KZM9D regression
you pointed me to earlier.

Next step is to figure out what is wrong with KZM9G in DT-only mode.
Can you guide me to reproduce off-list?

Thanks,

/ magnus
