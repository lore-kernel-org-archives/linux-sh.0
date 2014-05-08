From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 May 2014 17:52:05 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7740 dtsi: Add Ethernet support
Message-Id: <536BC445.8080007@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399494750-31996-1-git-send-email-geert+renesas@glider.be>	<1399494750-31996-2-git-send-email-geert+renesas@glider.be>	<536B7FD3.5090506@cogentembedded.com>	<CAMuHMdVoYnRcOVht0_Bt5_NJA3vZ40svftRXN-xbqHSMHZR5dg@mail.gmail.com>	<536B8340.4010901@cogentembedded.com> <CAMuHMdUW3ENmykZGNQB8Qo3EVk+7RYzVHa6L-=WsxZZ06mfUTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUW3ENmykZGNQB8Qo3EVk+7RYzVHa6L-=WsxZZ06mfUTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Bastian Hecht <hechtb+renesas@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/08/2014 05:21 PM, Geert Uytterhoeven wrote:

>>>>> +               /* clocks = <&mstp3_clks R8A7740_CLK_GETHER>; */

>>>>      This property is mandatory, according to the bindings.

>>> Indeed, but you cannot put anything there until the platform has CCF, as
>>> mstp3_clks doesn't exist yet.

>>     Yes, that was the main obstacle to accepting those bindings sooner. This
>> patch therefore seems somewhat premature.

> My main objective is to provide working Ethernet support for Armadillo
> reference now.

    Mine was the same (but for BOCK-W board) but DT people didn't give a damn. 
:-) So there's still no Ethernet support in BOCK-W DT.

> The DTS already has other nodes without "clocks" properties.

    It means not everybody submitting the bindings had the same bad luck as 
me. :-)

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei

