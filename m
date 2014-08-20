From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 14:53:05 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: dtsi: interrupt-parent cleanups
Message-Id: <CANqRtoTDdrR-VJ4dh96BJBmw5b-fHPRELNTrHTZK7jEXYasmJQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1408544914-21742-1-git-send-email-geert+renesas@glider.be>
	<CAMuHMdWFhqv5j8g8wGnaXBOZ7r7vBpOnW4K_KY7WAs04OYxQQg@mail.gmail.com>
In-Reply-To: <CAMuHMdWFhqv5j8g8wGnaXBOZ7r7vBpOnW4K_KY7WAs04OYxQQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Aug 20, 2014 at 11:32 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Aug 20, 2014 at 4:28 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> This series cleans up interrupt-parent use, to match common use.
>> It makes sure there's an "interrupt-parent = <&gic>;" at the top, which is
>> thus inherited by all child nodes, and removes superflous "interrupt-parent"
>> properties from the individual child nodes.
>>
>> This was tested on r8a7791/koelsch only.
>>
>> Geert Uytterhoeven (4):
>>   ARM: shmobile: r8a7779 dtsi: Remove superfluous interrupt-parent
>>   ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
>>   ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
>
> Oops, that should have been "r8a7791". I've sent a fixed version of that patch.
>
>>   ARM: shmobile: sh73a0 dtsi: Move interrupt-parent to the top

Thanks, those look like fine cleanups to me!

Acked-by: Magnus Damm <damm+renesas@opensource.se>

I suppose both your and my recent patches need a bit of testing, so I
guess it may make sense for Simon to merge one series at a time to
avoid introducing multiple potential issues simultaneously... Combine
early delay issues with Kconfig errors and potential interrupt parent
error and you have something fun to debug. =)

/ magnus
