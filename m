From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 12 Nov 2013 16:13:34 +0000
Subject: Re: [PATCH 03/14] ARM: shmobile: r8a7779: add HPB-DMAC support
Message-Id: <528253AE.4040708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
 <441f750236f3d3d435a1e89ad885ec896832b9c6.1381293239.git.horms+renesas@verge.net.au>
 <52814F8E.4090606@cogentembedded.com> <5281501A.9070009@cogentembedded.com>
 <20131112015853.GC9863@verge.net.au>
In-Reply-To: <20131112015853.GC9863@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello.

On 12-11-2013 5:58, Simon Horman wrote:

>>>> From: Max Filippov <max.filippov@cogentembedded.com>

>>>> Add HPB-DMAC platform device on R8A7779 SoC along with its slave and c=
hannel
>>>> configurations (only for SDHI0 so far).

>>>> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
>>>> [Sergei: moved *enum* declaring HPB-DMAC slave IDs from now removed
>>>> <mach/dma.h>
>>>> to <mach/r8a7779.h>, removed #include <mach/dma.h> from setup-r8a7779.=
c,
>>>> removed
>>>> SSI-related *enum* values and SSI-related data from hpb_dmae_slaves[] =
and
>>>> hpb_dmae_channels[], added ASYNCMDR.ASBTMD{20|24|43} and
>>>> ASYNCMDR.ASMD{20|24|43}
>>>> fields/values, fixed comments to ASYNCMDR.ASBTMD2[123] and ASYNCMDR.AS=
MD2[123]
>>>> fields/values, renamed all the bit/field/value #define's to include 'H=
BP_DMAE_'
>>>> prefix to match the driver, moved comments after the element initializ=
ers of
>>>> hpb_dmae_channels[].]
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>>> ---
>>>>   arch/arm/mach-shmobile/include/mach/r8a7779.h |   7 ++
>>>>   arch/arm/mach-shmobile/setup-r8a7779.c        | 154
>>>> ++++++++++++++++++++++++++
>>>>   2 files changed, 161 insertions(+)

>>>     Hm, Simon, do you know how this patch and the next one ended up bei=
ng
>>> merged twice into Linus' tree?

>>     Sorry, I followed up to the wrong patch. So, the question was
>> about this patch and the previous one.

>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=1Eb6b5a0e55bfcfb0852b7d0f9442841ff807345
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id38c4991ed350abd7c5b3cb807fe022cb712a8ba

>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
id=A43e5bd76a4a3df58167d85e8020a1c9e566ad75
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
idD1f750236f3d3d435a1e89ad885ec896832b9c6

> I assume that the reference to above git IDs implies that the answer
> to your question is yes.

    And answer to the question "how" is? :-)

WBR, Sergei

