From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Feb 2014 14:28:42 +0000
Subject: Re: [PATCH 2/3] renesas: change to using clock-indices
Message-Id: <CANqRtoRcZFJcwQUychmR3y0DU1xiHd24=OOGGETXanQR+TJmNg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Feb 14, 2014 at 10:21 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Friday 14 February 2014 11:32:08 Magnus Damm wrote:
>> On Fri, Feb 14, 2014 at 3:02 AM, Ben Dooks wrote:
>> > With the addition of clock-indices, we need to change the renesas
>> > clock implementation to use these instead of the local definition.
>> >
>> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> > ---
>> >
>> >  .../bindings/clock/renesas,cpg-mstp-clocks.txt   |  2 +-
>> >   arch/arm/boot/dts/r8a7790.dtsi                  | 16 ++++++++--------
>> >  arch/arm/boot/dts/r8a7791.dtsi                   | 18 +++++++++---------
>> >  drivers/clk/shmobile/clk-mstp.c                  |  2 +-
>> >  4 files changed, 19 insertions(+), 19 deletions(-)
>>
>> Thanks for your patches! Good to see more common bindings.
>>
>> Regarding how to roll it into the SoC code, I feel that this patch [2/3] and
>> next patch [3/3] potentially causes breakage with the existing binding that
>> was part of the v3.13 upstream kernel.
>
> If I'm not mistaken that's v3.14, not v3.13.

Nope, it's merged in v3.13. Looked it up before sending the email. =)

>> I'd like to maintain backwards compatibility for our users. Also, this patch
>> crosses subsystems which may not be entirely ideal from a merge perspective.
>>
>> If other people in the community agree with [1/3] then may I propose that
>> you rework the series into:
>>
>> [1/3] as-is is fine for me
>> [2/3] clk-mstp and documentation changes only - Take the clk-mstp.c
>> code from [2/3] and merge with [3/3], stay backwards compatible.
>> [3/3] adjust the SoC DTS
>>
>> That would maintain backwards compatibility and keep existing users happy.
>
> We'll have to address this DT backward compatibility nonsense at some point.
> We can't consider all bindings as stable as soon as they hit mainline, that
> just won't fly. In this particular case, given that the driver got merged in
> v3.14-rc1, and that our mainline multiplatform boards in mainline are
> virtually useless in real products given their early stage of development, I
> would rather consider the clocks DT bindings as unstable for at least a couple
> more kernel versions.

We need to chat more frequently my friend.

Cheers,

/ magnus
