From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Apr 2015 00:12:55 +0000
Subject: Re: [PATCH 08/10] ARM: shmobile: armadillo800eva dts: Use generic names for device nodes
Message-Id: <20150430001254.GB17758@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
 <1430139334-15272-9-git-send-email-geert+renesas@glider.be>
 <553E3404.6020601@cogentembedded.com>
 <CAMuHMdVBCS66UCjZwRSdcWjgukoVK-JMq2ZFHX0WKkh=Jh+yBQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVBCS66UCjZwRSdcWjgukoVK-JMq2ZFHX0WKkh=Jh+yBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 28, 2015 at 10:52:37AM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 27, 2015 at 3:05 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> >> -       wm8978: wm8978@1a {
> >> +       wm8978: codec@1a {
> >
> >     Perhaps sound-codec?
> 
> Given there's no single instance of "sound-codec" under
> Documentation/devicetree/, and only four occurrences in DTS files (whoops,
> I should fix up 3 of them ;-):

:)

I'm happy to help with that if you are dunning short of cycles.

>     arch/arm/boot/dts/r8a7778-bockw.dts: ak4643: sound-codec@12 {
>     arch/arm/boot/dts/r8a7790-lager.dts: ak4643: sound-codec@12 {
>     arch/arm/boot/dts/r8a7791-koelsch.dts: ak4643: sound-codec@12 {
>     arch/xtensa/boot/dts/xtfpga.dtsi: tlv320aic23: sound-codec@0 {
> 
> I'm strongly leaning towards "codec".

On the strength of that I have queued this up.
