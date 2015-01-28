From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Jan 2015 05:45:23 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <CANqRtoREqLXGn43e3Jr90gdgpVoe-OGGuorgmjLSFaxt-22HDA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<5155160.jFIrOp4XSG@avalon>
	<877fwab63w.wl%kuninori.morimoto.gx@renesas.com>
	<5977920.SJUic98Q2P@avalon>
In-Reply-To: <5977920.SJUic98Q2P@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org

Hi Laurent, everyone,

On Mon, Jan 26, 2015 at 12:01 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Morimoto-san,
>
> On Monday 26 January 2015 02:57:32 Kuninori Morimoto wrote:
>> Hi Laurent
>>
>> >> If you are caring about naming (= DMA), it is "Audio *DMAC* peri peri".
>> >> I wonder dma_transfer_direction has DMA_DEV_TO_DEV (this driver is not
>> >> using it though...) it is for peripheral-to-peripheral ?
>> >> And API point of view, 2nd DMAC doesn't need new DMAEngine API.
>> >> From DRY (= Don't Repeat Yourself) point of view, I don't want to
>> >> re-create "similar but different" implementation for naming issue.
>> >>
>> >> From DT bindings complexity point of view, which is complex ?
>> >> DMAC driver side ? DT node side ?
>> >> Indeed sound driver needs many node, but is is regular arrangement, not
>> >> complex, and, it needs many node for 1st DMAC too. I don't understand
>> >> why 1st is OK, 2nd is not OK ? From DMAC driver side complexity point of
>> >> view, 1st DMAC has same complexity (= it accepts many node from many
>> >> drivers) ?
>> >>
>> >> If I need to move 2nd DMAC from DMAEngine to sound driver side,
>> >> please explain it to Mark Brown (= ALSA SoC maintainer)
>> >
>> > I'm not saying you need to, I just wanted to raise the issue. From what I
>> > understood Vinod was also having doubts on using the DMA engine API for
>> > this device, given that it doesn't really match what the DMA engine API
>> > has been designed for. If everybody else is fine with your patches, and
>> > if the sound DT nodes are not considered overly complex with the DMA
>> > engine bindings, then I have no objection.
>>
>> Thank you for your feedback,
>> and I'm so sorry for my previous rude mail.
>
> No worries, I haven't found it rude. I know it could seem that I've trying to
> block this patch series without any reason, so a straight to the point reply
> was expected :-)
>
>> I think 2nd DMAC doesn't be complex issue, because it is very simple device.
>> But, this is my side (sound driver point) opinion.
>> Of course I can agree about DMAEngine side opinion/concern.
>> I don't know what it the best solution.
>>
>> Now, I asked about it to Mark (= ALSA SoC maintainer).
>> I can follow ALSA SoC maintainer + DMAEngine maintainer.
>
> I'd like to hear Marc's opinion, yes. And if Vinod is fine with your proposal,
> that's totally fine with me as well.

From my side anything is fine really, and I agree that the DT
integration patch looked rather "special". =)

At the same time I do think it makes sense to model the DT after the
hardware. So if there is a separate DMA controller device then I can't
see what is wrong with representing that in DT as a separate device.
That aside, the current implementation may not have been entirely
clean so perhaps we can begin by fixing that and see where that leads
us.

So I wonder as an incremental approach, how about simply reworking the
DT interface (old code has 200+ channels mapped out individually) to
something more manageable (maybe 20+ groups instead)? If that still
seems completely wrong DT-wise then we can look into how to rework the
architecture.

Cheers,

/ magnus
