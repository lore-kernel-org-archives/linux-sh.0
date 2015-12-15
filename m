From: Dirk Behme <dirk.behme@gmail.com>
Date: Tue, 15 Dec 2015 08:48:46 +0000
Subject: Re: [PATCH 2/3] arm64: dts: r8a7795: Add Cortex-A57 CPU cores
Message-Id: <566FD3EE.8040908@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449236333-4410-1-git-send-email-dirk.behme@gmail.com>
 <1449236333-4410-2-git-send-email-dirk.behme@gmail.com>
 <20151211230751.GD6496@verge.net.au>
 <CANqRtoSeibffbaoVGV7Y_gyuXxCOu+1PmRf3imQ8OKhV6VoAMQ@mail.gmail.com>
In-Reply-To: <CANqRtoSeibffbaoVGV7Y_gyuXxCOu+1PmRf3imQ8OKhV6VoAMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 15.12.2015 09:38, Magnus Damm wrote:
> Hi Simon,
>
> On Sat, Dec 12, 2015 at 8:07 AM, Simon Horman <horms@verge.net.au> wrote:
>> On Fri, Dec 04, 2015 at 02:38:52PM +0100, Dirk Behme wrote:
>>> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>>
>>> Add Cortex-A57 CPU cores to r8a7795 SoC for a total of 4 x Cortex-A57.
>>>
>>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>> Sigend-off-by: Dirk Behme <dirk.behme@gmail.com>
>>
>> Thanks, I have queued this up for v4.5.
>
> Thanks. May I ask if CPU hotplug is known to work?


I didn't test that.


> Also, which version
> of the boot loader stack is required?


I've the U-Boot / boot loader stack from BSP v3.0.2 on the board. I 
haven't tested v3.0.3, yet.


Best regards

Dirk

